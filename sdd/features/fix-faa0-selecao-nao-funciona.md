# fix/faa0-selecao-nao-funciona

**Branch:** `fix/faa0-selecao-nao-funciona`
**Base:** `feat/83bb-dev-cli-installer`
**Status:** `done`

## Bug reportado → esclarecido como melhoria de UX
"A seleção não está funcionando" — esclarecido pelo usuário: o toggle por número (digitar `1`, `2`... + Enter) **funciona**, mas a UX desejada é outra: navegação pelas **setas (↑/↓)** e marcar/desmarcar com **espaço**, estilo checkbox interativo (como `inquirer`/`gum choose --no-limit`).

## Investigação inicial (Orquestrador)
- `interactive_menu` (lib/menu.sh:6-39) foi testado isoladamente com bash 3.2 e `set -euo pipefail` — o toggle por número funciona corretamente (confirmado pelo usuário).
- Escopo do fix redefinido: reescrever `interactive_menu` para um menu navegável por teclado (setas para mover cursor, espaço para marcar/desmarcar, enter para confirmar), mantendo compatibilidade com bash 3.2 (macOS) e sem novas dependências externas (sem `gum`/`fzf`/`whiptail`, já que o CLI não assume essas ferramentas instaladas).
- Abordagem técnica: usar `read -rsn1` para capturar teclas uma a uma, detectar sequências de escape ANSI (`\x1b[A` cima, `\x1b[B` baixo) para as setas, espaço (`' '`) para toggle, enter (`''`/`$'\n'`) para confirmar; redesenhar o menu movendo o cursor com `tput cuu`/`\033[<n>A` em vez de reimprimir do zero (ou reimprimir limpando com `tput cuu`+`tput ed`).
- Manter fallback: se `read -rsn1`/terminal não suportar (ex.: stdin não é um TTY, execução via pipe/CI), cair para o modo antigo por número — importante para não quebrar `--dry-run` scriptado ou testes automatizados.

## Critério de conclusão
```bash
./setup.sh
# no menu interativo:
# - setas para cima/baixo movem o cursor entre as ferramentas
# - espaço marca/desmarca o item sob o cursor
# - enter confirma a seleção e prossegue
# - a lista final instalada corresponde exatamente ao que foi marcado
```

## Tarefas
- [x] **faa0-1** Reescrever `interactive_menu` em `lib/menu.sh` para navegação por setas + espaço, compatível com bash 3.2
- [x] **faa0-2** Manter fallback para stdin não-TTY (`interactive_menu_numbered`, usado quando `[[ ! -t 0 ]]`)
- [x] **faa0-3** Validar via PTY simulado (script Python + `pty.openpty`) — setas movem cursor, espaço marca/desmarca, enter confirma; fallback numérico e sintaxe (`bash -n`) revalidados

## Implementação
- `lib/menu.sh`: `interactive_menu` agora lê teclas com `read -rsn1`, detecta `\x1b[A`/`\x1b[B` (setas) para mover `cursor` com wrap-around, espaço faz toggle do item sob o cursor, enter (string vazia) confirma. Redesenho via `\033[<n>A\033[J` (sobe N+1 linhas e limpa até o fim da tela).
- Lógica antiga (seleção por número) preservada em `interactive_menu_numbered`, usada automaticamente quando stdin não é TTY (pipe/CI/`--dry-run` scriptado) — evita quebrar fluxos não interativos.
- **Bug encontrado e corrigido durante validação:** `read -rsn2 -t 0.01 rest` falhava com `invalid timeout specification` no bash 3.2 (macOS não suporta timeout fracionário), o que impedia a leitura dos 2 bytes finais da sequência de escape e quebrava a detecção das setas. Corrigido removendo o timeout (leitura bloqueante dos 2 bytes seguintes ao ESC).

## Arquivos prováveis
```
lib/menu.sh
lib/cli_args.sh
setup.sh
```

## Skills relevantes
(consultar `skills/index.md`)
