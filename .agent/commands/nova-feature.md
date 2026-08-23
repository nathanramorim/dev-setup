# Comando: nova-feature

**Uso:** Peça "/nova-feature <descrição>" ou "/nova-feature fix: <descrição>" (para correções/bugfixes)

**Ação:**
1. **PASSO 1 MANDATÓRIO — Branch:** Defina o prefixo de branch (`feat/` ou `fix/` se for correção/bugfix) e de arquivo (`feat-` ou `fix-`).
   - **Branch de partida:** Pergunte ao usuário qual branch usar como ponto de partida (default `main`). Só prossiga sem perguntar se o usuário já indicou explicitamente nesta mesma solicitação.
   - **Retomada:** Rode `git branch --list <prefixo-branch>/*` para essa feature/fix. Se já existir uma branch correspondente de uma sessão anterior, pergunte se deve continuar a partir dela em vez de criar uma nova.
   - Crie a branch localmente no terminal (`git checkout -b <prefixo-branch>/<nome>`, a partir da branch de partida escolhida) **antes** de criar qualquer especificação ou logs.
2. **Nomenclatura:** Siga a lógica única descrita em `sdd/memory/naming-convention.md`.
3. **Criação:** Crie o arquivo `sdd/features/<prefixo-arquivo>-ID-<nome>.md`. Se a feature for complexa, use uma subpasta `sdd/features/<prefixo-arquivo>-ID-<nome>/` e organize as subtasks (ex: `feat-ID-YY-<nome>.md`) lá dentro. **A subpasta inteira é a unidade de execução: uma única branch (a criada no passo 1) agrupa todas as subtarefas — nunca crie uma branch por subtarefa.** Atualize o progresso e índice.

**Handoff:** Gere um resumo para o comando `proxima-feature`.
