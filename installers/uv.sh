#!/usr/bin/env bash
# uv (gerenciador de pacotes/ambientes Python) — preferência do usuário sobre pip/venv/conda.
set -euo pipefail
SCRIPT_DIR="${SCRIPT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$SCRIPT_DIR/lib/common.sh"

check() { has_cmd uv || brew_formula_installed uv; }

install() {
  if has_cmd brew; then
    brew_install_formula uv
  else
    curl -LsSf https://astral.sh/uv/install.sh | sh
  fi
}

case "${1:-}" in
  check) check ;;
  install) install ;;
  *) echo "uso: $0 {check|install}" >&2; exit 2 ;;
esac
