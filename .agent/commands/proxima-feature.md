Leia `sdd/memory/progress.md`, identifique a próxima feature com status `todo`, reporte as tasks e aguarde confirmação.

Quando confirmado:
1. **Branch:**
   - Se `sdd/features/feat-XX.md` for um arquivo único, use o nome de branch definido no campo **Branch** desse arquivo.
   - Se a feature corrente for uma subpasta (`sdd/features/feat-XX-nome/*.md`, agrupando várias subtarefas), trate a pasta inteira como unidade de execução: **uma única branch cobre todas as subtarefas da pasta** — nunca crie uma branch por subtarefa.
   - **Branch de partida:** pergunte ao usuário qual branch usar como ponto de partida (default `main`), a menos que já tenha sido indicada explicitamente nesta sessão.
   - **Retomada:** rode `git branch --list <prefixo>/*` para essa feature; se já existir uma branch dela (de sessão anterior, possivelmente com subtarefas parcialmente concluídas), pergunte se deve continuar a partir dela em vez de recriar.
   - Execute `git checkout -b <branch>` (ou `git checkout <branch>` se estiver retomando).
2. Implemente as tasks listadas (todas as subtarefas da pasta, se for o caso, antes de finalizar a branch).
3. Ao concluir, gere um **Handoff** para a revisão, marque as tasks como concluídas em `progress.md` e `index.md`, e escreva uma release note concisa em linguagem de produto (curta, sem termos técnicos de código, ex: "Agora é possível...") registrando-a no topo de `sdd/releases/history.md` (sob a seção ## Entregas).
4. **PR Automático:** Faça o commit das alterações de progresso e execute `git push origin <branch>`. Leia o campo "VCS / Work Item System" em `sdd/memory/constitution.md` antes de abrir o PR:
   - `github` (ou campo ausente/default): crie IMEDIATAMENTE o PR com `gh pr create --fill`.
   - `azure-devops`: use `az repos pr create` (ou o comando equivalente documentado no projeto) no lugar de `gh pr create`.
   - `nenhum`: não tente nenhum comando de VCS — apenas informe o usuário de que a branch está pronta e com push feito.
5. **Gravação de Métricas (determinística):** Se a telemetria estiver habilitada em `sdd/.sddrc` (`telemetry.enabled` como `true`), execute `forge-sdd session record` — a escrita de `sdd/.metrics/session-<ISO8601>.json` agora é feita pelo binário (não depende de você montar o JSON manualmente):
   ```
   forge-sdd session record --feature "<caminho relativo completo da feature/fix ou task>" --phase "<ID>" \
     --agent-path "orquestrador,builder" --outcome approved|rejected|blocked --criterio-atendido=true|false \
     --tokens-input <estimativa> --tokens-output <estimativa> --turns <n> --duration-seconds <n> \
     --model "<modelo>" --files-touched "<arquivo1,arquivo2,...>"
   ```
   - Se a sessão for inativa, cancelada, sofrer timeout ou encerrar sem atingir a finalização da feature/fix, use `--criterio-atendido=false` e `--outcome blocked` ou `--outcome rejected` para registrar o esforço parcial.
   - Estime `--tokens-input`/`--tokens-output` de forma realista (1 token ≈ 4 caracteres ou 0.75 palavras), nunca zerados se houve interação.
6. **Fallbacks:** Se o `gh` não estiver disponível, faça o merge local na main: `git checkout main && git merge --no-ff <branch>` e informe o usuário.
