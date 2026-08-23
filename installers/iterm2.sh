#!/usr/bin/env bash
# iTerm2 via Homebrew cask.
set -euo pipefail
SCRIPT_DIR="${SCRIPT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$SCRIPT_DIR/lib/common.sh"

check() { brew_cask_installed iterm2 || [[ -d "/Applications/iTerm.app" ]]; }
install() { brew_install_cask iterm2; }

case "${1:-}" in
  check) check ;;
  install) install ;;
  *) echo "uso: $0 {check|install}" >&2; exit 2 ;;
esac
