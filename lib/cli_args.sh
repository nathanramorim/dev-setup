#!/usr/bin/env bash
# Parsing de flags do setup.sh

DRY_RUN=false
ALL=false
ONLY=""
DOTFILES=false
SHOW_LIST=false
SHOW_ABOUT=false

usage() {
  cat <<'EOF'
Uso: ./setup.sh [flags]

  --list              Lista todas as ferramentas disponíveis e sai
  --about             Mostra o banner do autor e sai
  --all               Instala todas as ferramentas (sem menu interativo)
  --only a,b,c        Instala apenas as ferramentas informadas (ids de --list)
  --dry-run           Mostra o que seria instalado, sem instalar nada
  --dotfiles          Restaura a configuração de zsh (dotfiles versionados)
  -h, --help          Mostra esta ajuda
EOF
}

parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --list) SHOW_LIST=true; shift ;;
      --about) SHOW_ABOUT=true; shift ;;
      --all) ALL=true; shift ;;
      --only) ONLY="$2"; shift 2 ;;
      --only=*) ONLY="${1#*=}"; shift ;;
      --dry-run) DRY_RUN=true; shift ;;
      --dotfiles) DOTFILES=true; shift ;;
      -h|--help) usage; exit 0 ;;
      *) echo "Flag desconhecida: $1" >&2; usage >&2; exit 1 ;;
    esac
  done
}
