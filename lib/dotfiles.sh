#!/usr/bin/env bash
# Restauração da configuração de zsh (dotfiles versionados neste repo).

_dotfiles_backup_and_link() {
  local src="$1" dest="$2"
  local timestamp
  timestamp="$(date +%Y%m%d%H%M%S)"

  if [[ -e "$dest" || -L "$dest" ]]; then
    if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
      echo "[ok] $dest já aponta para $src"
      return 0
    fi
    mv "$dest" "$dest.bak.$timestamp"
    echo "[backup] $dest -> $dest.bak.$timestamp"
  fi

  ln -s "$src" "$dest"
  echo "[link] $dest -> $src"
}

apply_dotfiles() {
  local repo_dotfiles="$SCRIPT_DIR/dotfiles"

  _dotfiles_backup_and_link "$repo_dotfiles/zshrc" "$HOME/.zshrc"
  _dotfiles_backup_and_link "$repo_dotfiles/p10k.zsh" "$HOME/.p10k.zsh"
  _dotfiles_backup_and_link "$repo_dotfiles/aliases.zsh" "$HOME/.aliases.zsh"
}
