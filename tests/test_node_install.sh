#!/usr/bin/env bash
# Testes para installers/node.sh e installers/claude_code.sh usando um nvm.sh
# "stub" (fake), para não depender de rede real nem baixar um Node de verdade.
# Bash puro (sem bats). Rodar com:
#   bash tests/test_node_install.sh

set -uo pipefail

TESTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$TESTS_DIR/.." && pwd)"

# shellcheck source=tests/test_helpers.sh
source "$TESTS_DIR/test_helpers.sh"

NODE_SH="$REPO_DIR/installers/node.sh"
CLAUDE_CODE_SH="$REPO_DIR/installers/claude_code.sh"

# ---------------------------------------------------------------------------
# Fixtures: um nvm.sh stub que implementa só os subcomandos que os installers
# realmente chamam (`install --lts`, `alias default 'lts/*'`, `use default`).
# Cria binários fake de node/npm sob $NVM_DIR/versions/node/<versao>/bin, e um
# npm fake que, quando chamado como `npm install -g @anthropic-ai/claude-code`,
# cria um `claude` fake no mesmo bin dir (para os testes de claude_code.sh).
# ---------------------------------------------------------------------------

write_fake_nvm_stub() {
  local dest="$1"
  cat > "$dest" <<'STUB_EOF'
#!/usr/bin/env bash
NVM_STUB_LTS_VERSION="v20.99.0"

nvm() {
  local sub="${1:-}"
  case "$sub" in
    install)
      local vdir="$NVM_DIR/versions/node/$NVM_STUB_LTS_VERSION/bin"
      mkdir -p "$vdir"
      cat > "$vdir/node" <<'NODE_EOF'
#!/usr/bin/env bash
echo "v20.99.0-stub"
NODE_EOF
      cat > "$vdir/npm" <<'NPM_EOF'
#!/usr/bin/env bash
if [[ "${1:-}" == "install" && "${2:-}" == "-g" && "${3:-}" == "@anthropic-ai/claude-code" ]]; then
  dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  cat > "$dir/claude" <<'CLAUDE_EOF'
#!/usr/bin/env bash
echo "claude-stub"
CLAUDE_EOF
  chmod +x "$dir/claude"
  exit 0
fi
echo "9.99.9-stub"
NPM_EOF
      chmod +x "$vdir/node" "$vdir/npm"
      return 0
      ;;
    alias)
      if [[ "${2:-}" == "default" ]]; then
        mkdir -p "$NVM_DIR/alias"
        if [[ -x "$NVM_DIR/versions/node/$NVM_STUB_LTS_VERSION/bin/node" ]]; then
          echo "$NVM_STUB_LTS_VERSION" > "$NVM_DIR/alias/default"
          return 0
        fi
        return 1
      fi
      return 1
      ;;
    use)
      local version=""
      if [[ "${2:-}" == "default" ]]; then
        [[ -s "$NVM_DIR/alias/default" ]] || return 1
        version="$(cat "$NVM_DIR/alias/default")"
      elif [[ "${2:-}" == "--lts" ]]; then
        version="$NVM_STUB_LTS_VERSION"
      else
        return 1
      fi
      local bindir="$NVM_DIR/versions/node/$version/bin"
      [[ -x "$bindir/node" ]] || return 1
      export PATH="$bindir:$PATH"
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}
STUB_EOF
}

# Fake curl: em vez de baixar o installer real do nvm, copia o stub acima para
# $NVM_DIR/nvm.sh (lido em tempo de execução, via env do processo que chama o
# fake curl) e imprime um script vazio no stdout — o que o `| bash` de node.sh
# vai "executar" sem efeito nenhum, já que o trabalho real é o side effect acima.
write_fake_curl() {
  local fake_bin="$1" stub_path="$2" marker="${3:-}"
  cat > "$fake_bin/curl" <<CURL_EOF
#!/usr/bin/env bash
${marker:+echo "CURL FOI CHAMADO" >> "$marker"}
mkdir -p "\$NVM_DIR"
cp "$stub_path" "\$NVM_DIR/nvm.sh"
echo "#!/bin/sh"
CURL_EOF
  chmod +x "$fake_bin/curl"
}

# Roda `installers/node.sh install` com um fake curl, deixando $nvm_dir num
# estado "instalado de verdade" (segundo o stub) para outros testes reaproveitarem.
install_stub_node() {
  local home_dir="$1" nvm_dir="$2" stub_path="$3" fake_bin="$4"
  mkdir -p "$fake_bin"
  write_fake_curl "$fake_bin" "$stub_path"
  HOME="$home_dir" \
    NVM_DIR="$nvm_dir" \
    SCRIPT_DIR="$REPO_DIR" \
    PATH="$fake_bin:/usr/bin:/bin" \
    "$NODE_SH" install >/dev/null 2>&1
}

echo "== installers/node.sh =="

test_node_clean_install_provides_node_and_npm() {
  local workdir
  workdir="$(mktemp -d)"
  trap 'rm -rf "$workdir"' RETURN

  local home_dir="$workdir/home" nvm_dir="$workdir/nvm" fake_bin="$workdir/bin"
  mkdir -p "$home_dir" "$fake_bin"

  local stub="$workdir/fake_nvm.sh"
  write_fake_nvm_stub "$stub"
  write_fake_curl "$fake_bin" "$stub"

  local out exit_code
  out="$(
    HOME="$home_dir" \
    NVM_DIR="$nvm_dir" \
    SCRIPT_DIR="$REPO_DIR" \
    PATH="$fake_bin:/usr/bin:/bin" \
    "$NODE_SH" install 2>&1
  )"
  exit_code=$?
  assert_true "$exit_code" "node.sh install (nvm.sh stub) sai com status 0"

  # check() num subprocesso NOVO, sem o fake curl no PATH — prova que o
  # estado instalado é detectável de forma durável, e que check() não precisa
  # de curl para funcionar.
  local out2 exit_code2
  out2="$(
    HOME="$home_dir" \
    NVM_DIR="$nvm_dir" \
    SCRIPT_DIR="$REPO_DIR" \
    PATH="/usr/bin:/bin" \
    "$NODE_SH" check 2>&1
  )"
  exit_code2=$?
  assert_true "$exit_code2" "node.sh check retorna 0 depois de um install bem-sucedido, num processo novo"
}

test_node_check_fails_when_only_nvm_present_no_version() {
  local workdir
  workdir="$(mktemp -d)"
  trap 'rm -rf "$workdir"' RETURN

  local home_dir="$workdir/home" nvm_dir="$workdir/nvm"
  mkdir -p "$home_dir" "$nvm_dir"

  # Simula o estado "bugado" de antes desta correção: nvm.sh existe, mas
  # nenhuma versão de node foi instalada/definida como default ainda.
  write_fake_nvm_stub "$nvm_dir/nvm.sh"

  local out exit_code
  out="$(
    HOME="$home_dir" \
    NVM_DIR="$nvm_dir" \
    SCRIPT_DIR="$REPO_DIR" \
    PATH="/usr/bin:/bin" \
    "$NODE_SH" check 2>&1
  )"
  exit_code=$?
  assert_false "$exit_code" \
    "node.sh check retorna != 0 quando só nvm.sh existe, sem versão default (regressão do bug original)"
}

test_node_second_run_does_not_reinstall() {
  local workdir
  workdir="$(mktemp -d)"
  trap 'rm -rf "$workdir"' RETURN

  local home_dir="$workdir/home" nvm_dir="$workdir/nvm" fake_bin="$workdir/bin"
  mkdir -p "$home_dir"

  local stub="$workdir/fake_nvm.sh"
  write_fake_nvm_stub "$stub"
  install_stub_node "$home_dir" "$nvm_dir" "$stub" "$fake_bin"

  # Novo fake_bin/curl que, se chamado, grava um marker — simula o que
  # run_installer faz de verdade: só chama `install` se `check` falhar.
  # Aqui chamamos só `check` de novo e provamos que ele nunca invoca curl.
  local fake_bin2="$workdir/bin2" marker="$workdir/curl_called.marker"
  mkdir -p "$fake_bin2"
  write_fake_curl "$fake_bin2" "$stub" "$marker"

  local out exit_code
  out="$(
    HOME="$home_dir" \
    NVM_DIR="$nvm_dir" \
    SCRIPT_DIR="$REPO_DIR" \
    PATH="$fake_bin2:/usr/bin:/bin" \
    "$NODE_SH" check 2>&1
  )"
  exit_code=$?

  assert_true "$exit_code" "node.sh check (segunda chamada) continua saindo com status 0"
  assert_file_absent "$marker" "node.sh check não invoca curl (nada a reinstalar)"
}

test_node_clean_install_provides_node_and_npm
test_node_check_fails_when_only_nvm_present_no_version
test_node_second_run_does_not_reinstall

echo
echo "== installers/claude_code.sh =="

test_claude_code_check_finds_npm_via_nvm_default() {
  local workdir
  workdir="$(mktemp -d)"
  trap 'rm -rf "$workdir"' RETURN

  local home_dir="$workdir/home" nvm_dir="$workdir/nvm" fake_bin="$workdir/bin"
  mkdir -p "$home_dir"

  local stub="$workdir/fake_nvm.sh"
  write_fake_nvm_stub "$stub"
  install_stub_node "$home_dir" "$nvm_dir" "$stub" "$fake_bin"

  # PATH deliberadamente sem node/npm/claude — só /usr/bin:/bin — pra provar
  # que é o carregamento do nvm (load_default_node) que resolve o npm, e não
  # um PATH herdado por acidente do processo do node.sh anterior.
  local out exit_code
  out="$(
    HOME="$home_dir" \
    NVM_DIR="$nvm_dir" \
    SCRIPT_DIR="$REPO_DIR" \
    PATH="/usr/bin:/bin" \
    "$CLAUDE_CODE_SH" check 2>&1
  )"
  exit_code=$?
  assert_false "$exit_code" "claude_code.sh check retorna != 0 antes de instalar (claude ainda não existe)"

  local has_npm_error="nao"
  [[ "$out" == *"npm não encontrado"* ]] && has_npm_error="sim"
  assert_eq "nao" "$has_npm_error" \
    "claude_code.sh check não imprime erro de 'npm não encontrado' (npm existe via nvm, só falta o claude)"

  out="$(
    HOME="$home_dir" \
    NVM_DIR="$nvm_dir" \
    SCRIPT_DIR="$REPO_DIR" \
    PATH="/usr/bin:/bin" \
    "$CLAUDE_CODE_SH" install 2>&1
  )"
  exit_code=$?
  assert_true "$exit_code" "claude_code.sh install sai com status 0 (encontrou npm via nvm, sem PATH herdado)"

  out="$(
    HOME="$home_dir" \
    NVM_DIR="$nvm_dir" \
    SCRIPT_DIR="$REPO_DIR" \
    PATH="/usr/bin:/bin" \
    "$CLAUDE_CODE_SH" check 2>&1
  )"
  exit_code=$?
  assert_true "$exit_code" "claude_code.sh check retorna 0 depois do install"
}

test_claude_code_install_fails_clearly_without_node() {
  local workdir
  workdir="$(mktemp -d)"
  trap 'rm -rf "$workdir"' RETURN

  local home_dir="$workdir/home" nvm_dir="$workdir/nvm-inexistente"
  mkdir -p "$home_dir"

  local out exit_code
  out="$(
    HOME="$home_dir" \
    NVM_DIR="$nvm_dir" \
    SCRIPT_DIR="$REPO_DIR" \
    PATH="/usr/bin:/bin" \
    "$CLAUDE_CODE_SH" install 2>&1
  )"
  exit_code=$?

  assert_false "$exit_code" "claude_code.sh install falha sem node/npm disponível"
  assert_contains "$out" "npm não encontrado" \
    "claude_code.sh install imprime a mensagem de erro esperada"
  assert_contains "$out" "./setup.sh --only node" \
    "claude_code.sh install orienta a rodar o installer node primeiro"
}

test_claude_code_check_finds_npm_via_nvm_default
test_claude_code_install_fails_clearly_without_node

test_suite_summary
exit $?
