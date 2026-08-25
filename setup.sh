#!/usr/bin/env bash
# dev-setup CLI — reinstala e configura o ambiente de dev do zero.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export SCRIPT_DIR

# shellcheck source=lib/common.sh
source "$SCRIPT_DIR/lib/common.sh"
# shellcheck source=lib/detect_os.sh
source "$SCRIPT_DIR/lib/detect_os.sh"
# shellcheck source=lib/banner.sh
source "$SCRIPT_DIR/lib/banner.sh"
# shellcheck source=lib/registry.sh
source "$SCRIPT_DIR/lib/registry.sh"
# shellcheck source=lib/cli_args.sh
source "$SCRIPT_DIR/lib/cli_args.sh"
# shellcheck source=lib/menu.sh
source "$SCRIPT_DIR/lib/menu.sh"
# shellcheck source=lib/dotfiles.sh
source "$SCRIPT_DIR/lib/dotfiles.sh"

parse_args "$@"

if [[ "$SHOW_ABOUT" == "true" ]]; then
  print_banner
  exit 0
fi

if [[ "$SHOW_LIST" == "true" ]]; then
  list_tools
  exit 0
fi

if [[ "$(os_name)" != "macos" ]]; then
  echo "Aviso: este CLI foi desenhado para macOS. SO detectado: $(os_name)." >&2
fi

print_banner
echo "SO: $(os_name) | Arquitetura: $(os_arch) | Homebrew: $(brew_prefix)"
echo

if [[ "$DRY_RUN" == "true" ]]; then
  echo "[dry-run] nenhuma alteração será realizada."
  echo
fi

if [[ "$DOTFILES" == "true" ]]; then
  apply_dotfiles
  exit 0
fi

ensure_homebrew

selected=()
if [[ "$ALL" == "true" ]]; then
  selected=("${TOOL_IDS[@]}")
elif [[ -n "$ONLY" ]]; then
  IFS=',' read -ra selected <<< "$ONLY"
else
  # shellcheck disable=SC2207
  selected=($(interactive_menu))
fi

if [[ ${#selected[@]} -eq 0 ]]; then
  echo "Nenhuma ferramenta selecionada. Nada a fazer."
  exit 0
fi

status=0
for tool in "${selected[@]}"; do
  run_installer "$tool" || status=1
done

exit "$status"
