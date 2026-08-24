#!/usr/bin/env bash
# Menu interativo de seleção de ferramentas.
# Compatível com bash 3.2: a seleção é mantida como uma string " id1 id2 "
# em vez de um array associativo.

# Desenha o menu de navegação por setas.
# Lê `picked` e `cursor` do escopo da função chamadora (interactive_menu).
_menu_draw() {
  echo "Selecione as ferramentas a instalar (setas para navegar, espaço para marcar/desmarcar, enter para confirmar):" >&2
  local i tool mark
  for ((i = 0; i < ${#TOOL_IDS[@]}; i++)); do
    tool="${TOOL_IDS[$i]}"
    mark=" "
    case " $picked " in
      *" $tool "*) mark="x" ;;
    esac
    if [[ $i -eq $cursor ]]; then
      printf '\033[7m> [%s] %-12s %s\033[0m\n' "$mark" "$tool" "$(tool_desc "$tool")" >&2
    else
      printf '  [%s] %-12s %s\n' "$mark" "$tool" "$(tool_desc "$tool")" >&2
    fi
  done
}

# Menu navegável por setas (↑/↓), espaço marca/desmarca, enter confirma.
interactive_menu() {
  # stdin não interativo (pipe/CI): usa o modo por número, que não depende de TTY.
  if [[ ! -t 0 ]]; then
    interactive_menu_numbered
    return
  fi

  local picked="" cursor=0 key rest tool n=${#TOOL_IDS[@]}

  _menu_draw
  while true; do
    IFS= read -rsn1 key
    if [[ "$key" == $'\x1b' ]]; then
      # bash 3.2 (macOS) não suporta timeout fracionário em `read -t`;
      # como as setas enviam a sequência inteira de uma vez, lemos os
      # 2 bytes seguintes sem timeout (bloqueia apenas se ESC for
      # pressionado isoladamente, o que não é um atalho usado aqui).
      IFS= read -rsn2 rest
      key="$key$rest"
    fi
    case "$key" in
      $'\x1b[A') cursor=$(( (cursor - 1 + n) % n )) ;;
      $'\x1b[B') cursor=$(( (cursor + 1) % n )) ;;
      ' ')
        tool="${TOOL_IDS[$cursor]}"
        case " $picked " in
          *" $tool "*) picked="${picked/ $tool/}" ;;
          *) picked="$picked $tool" ;;
        esac
        ;;
      '') break ;;
    esac
    printf '\033[%dA\033[J' "$((n + 1))" >&2
    _menu_draw
  done

  echo "$picked"
}

# Fallback: seleção digitando o número do item (usado quando stdin não é TTY).
interactive_menu_numbered() {
  local picked="" choice tool i mark

  while true; do
    echo >&2
    echo "Selecione as ferramentas a instalar (número para marcar/desmarcar, 0 para concluir):" >&2
    i=1
    for tool in "${TOOL_IDS[@]}"; do
      mark=" "
      case " $picked " in
        *" $tool "*) mark="x" ;;
      esac
      printf '  %2d) [%s] %-12s %s\n' "$i" "$mark" "$tool" "$(tool_desc "$tool")" >&2
      i=$((i + 1))
    done
    printf '  %2d) concluir seleção\n' 0 >&2
    read -rp "> " choice

    if [[ "$choice" == "0" ]]; then
      break
    fi
    if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice <= ${#TOOL_IDS[@]} )); then
      tool="${TOOL_IDS[$((choice - 1))]}"
      case " $picked " in
        *" $tool "*) picked="${picked/ $tool/}" ;;
        *) picked="$picked $tool" ;;
      esac
    else
      echo "Opção inválida: $choice" >&2
    fi
  done

  echo "$picked"
}
