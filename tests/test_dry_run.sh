#!/usr/bin/env bash
# Testes de "--dry-run não deve ter efeitos colaterais" para ensure_homebrew
# e _dotfiles_backup_and_link. Bash puro (sem bats). Rodar com:
#   bash tests/test_dry_run.sh

set -uo pipefail

TESTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$TESTS_DIR/.." && pwd)"

# shellcheck source=tests/test_helpers.sh
source "$TESTS_DIR/test_helpers.sh"

echo "== ensure_homebrew (DRY_RUN=true) =="

test_ensure_homebrew_dry_run_skips_install() {
  local workdir
  workdir="$(mktemp -d)"
  trap 'rm -rf "$workdir"' RETURN

  local fake_bin="$workdir/bin"
  mkdir -p "$fake_bin"

  # curl "fake" que grava um marker se for chamado — prova que dry-run nunca
  # invoca o curl real (nem baixa nem executa o install.sh do Homebrew).
  cat > "$fake_bin/curl" <<'EOF'
#!/usr/bin/env bash
echo "CURL FOI CHAMADO" >> "$FAKE_MARKER"
echo "#!/bin/sh"
EOF
  chmod +x "$fake_bin/curl"

  local marker="$workdir/curl_called.marker"
  local out exit_code

  # PATH restrito: sem brew real, então ensure_homebrew sempre cai no ramo
  # "não encontrado" e exercita o gate de dry-run.
  out="$(
    FAKE_MARKER="$marker" \
    PATH="$fake_bin:/usr/bin:/bin" \
    DRY_RUN=true \
    bash -c '
      source "'"$REPO_DIR"'/lib/detect_os.sh"
      ensure_homebrew
    ' 2>&1
  )"
  exit_code=$?

  assert_true "$exit_code" "ensure_homebrew em dry-run sai com status 0"
  assert_contains "$out" "[dry-run]" "ensure_homebrew em dry-run imprime [dry-run]"
  assert_file_absent "$marker" "ensure_homebrew em dry-run NÃO invoca curl"
}

test_ensure_homebrew_dry_run_skips_install

echo
echo "== apply_dotfiles / _dotfiles_backup_and_link (DRY_RUN=true) =="

test_dotfiles_dry_run_preserves_existing_file() {
  local home_dir
  home_dir="$(mktemp -d)"
  trap 'rm -rf "$home_dir"' RETURN

  echo "conteudo-original-do-usuario" > "$home_dir/.zshrc"

  local out exit_code
  out="$(
    HOME="$home_dir" \
    SCRIPT_DIR="$REPO_DIR" \
    DRY_RUN=true \
    bash -c '
      source "'"$REPO_DIR"'/lib/dotfiles.sh"
      apply_dotfiles
    ' 2>&1
  )"
  exit_code=$?

  assert_true "$exit_code" "apply_dotfiles em dry-run sai com status 0"
  assert_contains "$out" "[dry-run]" "apply_dotfiles em dry-run imprime [dry-run]"

  local content
  content="$(cat "$home_dir/.zshrc")"
  assert_eq "conteudo-original-do-usuario" "$content" \
    ".zshrc pré-existente não é sobrescrito em dry-run"

  local backups
  backups="$(compgen -G "$home_dir/.zshrc.bak.*" || true)"
  assert_eq "" "$backups" "nenhum backup .bak.* é criado em dry-run"

  local is_symlink="nao"
  [[ -L "$home_dir/.zshrc" ]] && is_symlink="sim"
  assert_eq "nao" "$is_symlink" ".zshrc pré-existente não vira symlink em dry-run"
}

test_dotfiles_dry_run_no_prior_file() {
  local home_dir
  home_dir="$(mktemp -d)"
  trap 'rm -rf "$home_dir"' RETURN

  local out exit_code
  out="$(
    HOME="$home_dir" \
    SCRIPT_DIR="$REPO_DIR" \
    DRY_RUN=true \
    bash -c '
      source "'"$REPO_DIR"'/lib/dotfiles.sh"
      apply_dotfiles
    ' 2>&1
  )"
  exit_code=$?

  assert_true "$exit_code" "apply_dotfiles em dry-run (sem arquivo prévio) sai com status 0"
  assert_contains "$out" "[dry-run]" "apply_dotfiles em dry-run (sem arquivo prévio) imprime [dry-run]"
  assert_file_absent "$home_dir/.zshrc" \
    "nenhum symlink .zshrc é criado em dry-run quando não havia arquivo prévio"
  assert_file_absent "$home_dir/.p10k.zsh" \
    "nenhum symlink .p10k.zsh é criado em dry-run quando não havia arquivo prévio"
}

test_dotfiles_dry_run_preserves_existing_file
test_dotfiles_dry_run_no_prior_file

test_suite_summary
exit $?
