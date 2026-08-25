#!/usr/bin/env bash
# Node.js via nvm (Node Version Manager): instala a LTS mais recente e a define
# como alias "default", para que node/npm fiquem disponíveis em novos shells.
set -euo pipefail
SCRIPT_DIR="${SCRIPT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$SCRIPT_DIR/lib/common.sh"

export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"

check() {
  load_default_node
}

install() {
  if [[ ! -s "$NVM_DIR/nvm.sh" ]]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
  fi

  set +eu
  # shellcheck disable=SC1091
  source "$NVM_DIR/nvm.sh"
  nvm install --lts
  nvm alias default 'lts/*'
  set -eu

  if ! load_default_node; then
    echo "falha ao ativar Node/npm via nvm após a instalação." >&2
    return 1
  fi

  echo
  echo "Node.js $(node --version) (LTS) instalado via nvm e definido como 'default'."
  echo "npm $(npm --version) disponível."
  echo "Novos terminais já terão node/npm no PATH (via nvm.sh no seu shell rc)."
}

case "${1:-}" in
  check) check ;;
  install) install ;;
  *) echo "uso: $0 {check|install}" >&2; exit 2 ;;
esac
