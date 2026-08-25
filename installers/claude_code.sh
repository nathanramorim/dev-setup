#!/usr/bin/env bash
# Claude Code CLI via npm (canal oficial documentado: pacote @anthropic-ai/claude-code).
# Requer Node.js/npm disponíveis. Cada installer roda em um subprocesso isolado
# (veja lib/registry.sh), então não dá pra contar com o PATH ter sido alterado
# pelo installer `node` numa execução anterior — carregamos o Node "default" do
# nvm aqui de novo via load_default_node (lib/common.sh), de forma best-effort.
set -euo pipefail
SCRIPT_DIR="${SCRIPT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$SCRIPT_DIR/lib/common.sh"

check() {
  load_default_node >/dev/null 2>&1 || true
  has_cmd claude
}

install() {
  load_default_node >/dev/null 2>&1 || true
  if ! has_cmd npm; then
    echo "npm não encontrado. Instale o Node.js primeiro (./setup.sh --only node)." >&2
    return 1
  fi
  npm install -g @anthropic-ai/claude-code
}

case "${1:-}" in
  check) check ;;
  install) install ;;
  *) echo "uso: $0 {check|install}" >&2; exit 2 ;;
esac
