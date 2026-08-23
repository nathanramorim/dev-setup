#!/usr/bin/env bash
# Claude Code CLI via npm (canal oficial documentado: pacote @anthropic-ai/claude-code).
# Requer Node.js/npm já disponíveis — depende do installer `node` (nvm) ter rodado antes.
set -euo pipefail
SCRIPT_DIR="${SCRIPT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$SCRIPT_DIR/lib/common.sh"

check() { has_cmd claude; }

install() {
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
