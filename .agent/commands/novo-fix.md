# Comando: novo-fix

**Uso:** Peça "/novo-fix <descrição do bug>"

**Ação:**
1. **PASSO 1 MANDATÓRIO — Branch:**
   - **Branch de partida:** Pergunte ao usuário qual branch usar como ponto de partida (default `main`). Só prossiga sem perguntar se o usuário já indicou explicitamente nesta mesma solicitação.
   - **Retomada:** Rode `git branch --list fix/*` para esse fix. Se já existir uma branch correspondente de uma sessão anterior, pergunte se deve continuar a partir dela em vez de criar uma nova.
   - Crie a branch do fix localmente no terminal (`git checkout -b fix/<nome>`, a partir da branch de partida escolhida) **antes** de criar qualquer especificação ou logs.
2. **Nomenclatura:** Siga a lógica única descrita em `sdd/memory/naming-convention.md`.
3. **Criação:** Crie o arquivo `sdd/features/fix-ID-<nome>.md`. Se o fix for complexo, crie uma subpasta `sdd/features/fix-ID-<nome>/` e salve as subtasks lá dentro. **A subpasta inteira é a unidade de execução: uma única branch (a criada no passo 1) agrupa todas as subtarefas — nunca crie uma branch por subtarefa.** Atualize o progresso e índice.
4. **Gravação de Métricas:** Se a telemetria estiver habilitada em `sdd/.sddrc`, execute `forge-sdd session record --feature "<arquivo fix criado>" --outcome blocked --criterio-atendido=false` (o fix ainda não foi implementado) — garante telemetria mesmo se a sessão terminar aqui.

**Handoff:** Gere um resumo para o comando `proxima-feature`.
