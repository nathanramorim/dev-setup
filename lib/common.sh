#!/usr/bin/env bash
# Helpers compartilhados pelos installers/*.sh

has_cmd() { command -v "$1" >/dev/null 2>&1; }

brew_formula_installed() { brew list --formula "$1" >/dev/null 2>&1; }

brew_cask_installed() { brew list --cask "$1" >/dev/null 2>&1; }

brew_install_formula() { brew install "$1"; }

brew_install_cask() { brew install --cask "$1"; }

# Carrega, no shell atual, o Node.js "default" gerenciado pelo nvm (se existir).
# Usado por installers/node.sh (check) e installers/claude_code.sh (check/install),
# já que cada installer roda como subprocesso isolado (veja lib/registry.sh) — o
# PATH ajustado por um installer nunca chega ao próximo, então quem depender de
# node/npm precisa refazer esse load por conta própria.
#
# Sempre "best-effort" e nunca aborta o script chamador: nvm.sh não foi escrito
# para rodar sob `set -euo pipefail` (usa variáveis não definidas e retornos
# não-zero como parte do fluxo normal), então relaxamos errexit/nounset só
# durante o load e restauramos o estado exato de antes ao final.
#
# Retorna 0 se, depois do load, `node` e `npm` resolvem no PATH; 1 caso contrário
# (nvm ausente, ou presente mas sem alias "default" com uma versão instalada).
load_default_node() {
  export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
  [[ -s "$NVM_DIR/nvm.sh" ]] || return 1

  local prev_flags
  prev_flags="$(set +o | grep -E 'errexit|nounset')"
  set +e
  set +u
  # shellcheck disable=SC1091
  source "$NVM_DIR/nvm.sh" >/dev/null 2>&1
  nvm use default >/dev/null 2>&1
  eval "$prev_flags"

  has_cmd node && has_cmd npm
}
