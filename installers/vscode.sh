#!/usr/bin/env bash
# VS Code via Homebrew cask.
set -euo pipefail
SCRIPT_DIR="${SCRIPT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$SCRIPT_DIR/lib/common.sh"

check() { has_cmd code || brew_cask_installed visual-studio-code; }
install() { brew_install_cask visual-studio-code; }

case "${1:-}" in
  check) check ;;
  install) install ;;
  *) echo "uso: $0 {check|install}" >&2; exit 2 ;;
esac
