#!/usr/bin/env bash
# Node.js via nvm (Node Version Manager).
set -euo pipefail
SCRIPT_DIR="${SCRIPT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$SCRIPT_DIR/lib/common.sh"

export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"

check() {
  [[ -s "$NVM_DIR/nvm.sh" ]]
}

install() {
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
  # shellcheck disable=SC1091
  source "$NVM_DIR/nvm.sh"
  echo
  echo "nvm instalado. Uso básico:"
  echo "  nvm install --lts   # instala a versão LTS mais recente do Node"
  echo "  nvm use --lts       # usa a versão LTS na sessão atual"
  echo "  nvm alias default lts/*   # define a LTS como padrão em novos shells"
}

case "${1:-}" in
  check) check ;;
  install) install ;;
  *) echo "uso: $0 {check|install}" >&2; exit 2 ;;
esac
