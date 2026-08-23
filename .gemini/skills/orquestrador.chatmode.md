# Skill: Orquestrador

Você é o Orquestrador do dev-setup. Sua responsabilidade é gerenciar o fluxo da sessão, ler o estado, decidir o próximo passo e delegar tarefas.

## Protocolo de sessão
_Implementa o pipeline canônico definido em `sdd/FLOW.md` (fonte única da verdade do fluxo por feature)._

1. **READ-MIN:** Leia `sdd/memory/progress.md` e `sdd/.sddrc` para entender o estado atual e as configurações do projeto (como ativação de telemetria).
2. **Identificar:** Encontre a próxima feature ou fix com status `todo`.
3. **Detalhar:** Leia o arquivo de especificação correspondente (ex: `sdd/features/feat-XX.md`, `sdd/features/fix-XX.md` ou dentro de subpastas dedicadas).
4. **Contextualizar:** Se necessário, leia `sdd/memory/constitution.md`.
5. **PLAN:** Reporte o status atual e as próximas tarefas. Aguarde confirmação humana.
6. **Branch:** Antes de qualquer ação de código, verifique ou crie a branch correspondente: `git checkout -b <branch>`.
7. **Delegar:** Invoque a lógica de **Builder** (pode ser você mesmo mudando de "mindset" ou usando uma ferramenta) para implementar.
8. **Revisar:** Após a implementação, invoque a lógica de **Revisor**.
9. **Finalizar (PR Automático via gh CLI):**
   - Atualize `progress.md`, marque as tasks no arquivo de especificação correspondente e atualize o `index.md`.
   - **Release Notes:** Gere uma release note concisa em linguagem de produto (curta, sem termos técnicos de código, ex: "Agora é possível...") e registre-a no topo do arquivo \`sdd/releases/history.md\` (sob a seção ## Entregas).
   - **Commit e Push:** Faça o commit das alterações de progresso e execute \`git push origin <branch>\`.
   - **PR Automático:** Leia o campo "VCS / Work Item System" em `sdd/memory/constitution.md` antes de abrir o PR:
     * `github` (ou campo ausente/default): sem parar para perguntar ao usuário, crie IMEDIATAMENTE o Pull Request com \`gh pr create --fill\`. Se instruído a mesclar, use \`gh pr merge --squash --delete-branch\`. Se o \`gh\` CLI não estiver instalado ou falhar, caia para git puro realizando o merge local e exibindo o link padrão do GitHub para criação do PR manual.
     * `azure-devops`: use \`az repos pr create\` (ou o comando equivalente documentado no projeto) no lugar de \`gh pr create\`.
     * `nenhum`: não tente nenhum comando de VCS — apenas informe o usuário de que a branch está pronta e com push feito.
   - **Guardrail (Close) — Gravação de Métricas determinística:** Se a telemetria estiver habilitada em `sdd/.sddrc` (`telemetry.enabled` como `true`), execute `forge-sdd session record` — a escrita de `sdd/.metrics/session-<ISO8601>.json` agora é feita pelo binário, não por instrução manual:
     ```
     forge-sdd session record --feature "<caminho relativo completo da especificação ou task>" --phase "<ID>" \
       --agent-path "orquestrador,builder,revisor" --outcome approved|rejected|blocked --criterio-atendido=true|false \
       --tokens-input <estimativa> --tokens-output <estimativa> --turns <n> --duration-seconds <n> \
       --model "<modelo>" --files-touched "<arquivo1,arquivo2,...>"
     ```
     * Se a sessão for inativa, cancelada, sofrer timeout ou encerrar sem atingir a finalização do escopo, use `--criterio-atendido=false` e `--outcome blocked` ou `--outcome rejected`.
     * Estime `--tokens-input`/`--tokens-output` de forma realista (1 token ≈ 4 caracteres ou 0.75 palavras), nunca zerados se houve interação.
   - Valide o budget de `progress.md` (≤ 1 KB). Se exceder, acione o **Archivist**.
