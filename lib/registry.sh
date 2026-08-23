#!/usr/bin/env bash
# Registro de ferramentas instaláveis pelo CLI.
# Contrato de cada installers/<tool>.sh: aceita "check" (exit 0 = já instalado)
# ou "install" (idempotente) como único argumento.
#
# Compatível com bash 3.2 (padrão do macOS): sem arrays associativos (`declare -A`),
# por isso os ids e as descrições ficam em dois arrays indexados paralelos.

TOOL_IDS=(node dotnet gh vscode dbeaver bruno iterm2 uv pnpm oh_my_zsh claude_code antigravity)
TOOL_DESCS=(
  "Node.js (via nvm)"
  ".NET SDK"
  "GitHub CLI"
  "VS Code"
  "DBeaver"
  "Bruno (API/E2E)"
  "iTerm2"
  "uv (gerenciador Python)"
  "pnpm"
  "oh-my-zsh"
  "Claude Code CLI"
  "Antigravity CLI"
)

# Imprime a descrição do id em $1, ou retorna 1 se o id não existir.
tool_desc() {
  local id="$1" i
  for i in "${!TOOL_IDS[@]}"; do
    if [[ "${TOOL_IDS[$i]}" == "$id" ]]; then
      echo "${TOOL_DESCS[$i]}"
      return 0
    fi
  done
  return 1
}

list_tools() {
  echo "Ferramentas disponíveis:"
  local tool
  for tool in "${TOOL_IDS[@]}"; do
    printf '  %-12s %s\n' "$tool" "$(tool_desc "$tool")"
  done
}

run_installer() {
  local tool="$1"
  local script="$SCRIPT_DIR/installers/$tool.sh"
  local desc

  if ! desc="$(tool_desc "$tool")"; then
    echo "[skip] '$tool' não é uma ferramenta reconhecida (veja --list)" >&2
    return 1
  fi

  if [[ ! -x "$script" ]]; then
    echo "[erro] installer não encontrado ou não executável: $script" >&2
    return 1
  fi

  if "$script" check; then
    echo "[ok] $tool já instalado — nada a fazer"
    return 0
  fi

  if [[ "${DRY_RUN:-false}" == "true" ]]; then
    echo "[dry-run] instalaria: $tool ($desc)"
    return 0
  fi

  echo "[instalando] $tool ($desc)..."
  "$script" install
}
