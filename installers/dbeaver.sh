#!/usr/bin/env bash
# DBeaver via Homebrew cask.
set -euo pipefail
SCRIPT_DIR="${SCRIPT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$SCRIPT_DIR/lib/common.sh"

check() { brew_cask_installed dbeaver-community || [[ -d "/Applications/DBeaver.app" ]]; }
install() { brew_install_cask dbeaver-community; }

case "${1:-}" in
  check) check ;;
  install) install ;;
  *) echo "uso: $0 {check|install}" >&2; exit 2 ;;
esac
