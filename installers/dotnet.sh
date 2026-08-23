#!/usr/bin/env bash
# .NET SDK via Homebrew cask.
set -euo pipefail
SCRIPT_DIR="${SCRIPT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$SCRIPT_DIR/lib/common.sh"

check() { has_cmd dotnet || brew_cask_installed dotnet-sdk; }
install() { brew_install_cask dotnet-sdk; }

case "${1:-}" in
  check) check ;;
  install) install ;;
  *) echo "uso: $0 {check|install}" >&2; exit 2 ;;
esac
