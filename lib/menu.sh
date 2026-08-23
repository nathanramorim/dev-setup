#!/usr/bin/env bash
# Menu interativo de seleção de ferramentas.
# Compatível com bash 3.2: a seleção é mantida como uma string " id1 id2 "
# em vez de um array associativo.

interactive_menu() {
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
