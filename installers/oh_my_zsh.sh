#!/usr/bin/env bash
# oh-my-zsh — framework de configuração de zsh (usado pelos dotfiles versionados).
set -euo pipefail
SCRIPT_DIR="${SCRIPT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$SCRIPT_DIR/lib/common.sh"

check() {
  [[ -d "$HOME/.oh-my-zsh" ]] \
    && brew_formula_installed romkatv/powerlevel10k/powerlevel10k \
    && brew_formula_installed zsh-autosuggestions \
    && brew_formula_installed zsh-syntax-highlighting
}

install() {
  if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    KEEP_ZSHRC=yes RUNZSH=no CHSH=no \
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi
  brew_formula_installed romkatv/powerlevel10k/powerlevel10k || brew_install_formula romkatv/powerlevel10k/powerlevel10k
  brew_formula_installed zsh-autosuggestions || brew_install_formula zsh-autosuggestions
  brew_formula_installed zsh-syntax-highlighting || brew_install_formula zsh-syntax-highlighting
}

case "${1:-}" in
  check) check ;;
  install) install ;;
  *) echo "uso: $0 {check|install}" >&2; exit 2 ;;
esac
