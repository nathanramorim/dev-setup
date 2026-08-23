#!/usr/bin/env bash
# Antigravity CLI — instalador remoto oficial informado pelo usuário no discovery 83bb.
set -euo pipefail
SCRIPT_DIR="${SCRIPT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$SCRIPT_DIR/lib/common.sh"

check() { has_cmd antigravity; }

install() {
  echo "Aviso: isto vai baixar e executar um script remoto de https://antigravity.google/cli/install.sh"
  curl -fsSL https://antigravity.google/cli/install.sh | bash
}

case "${1:-}" in
  check) check ;;
  install) install ;;
  *) echo "uso: $0 {check|install}" >&2; exit 2 ;;
esac
