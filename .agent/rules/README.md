# `.agent/rules/` — Regras de Domínio Compartilhadas

Pasta neutra, fora de `.claude/`, `.gemini/`, `.github/` ou `.openai/` — qualquer agente de IA configurado neste projeto consulta os arquivos aqui antes de agir, sem depender de sintaxe específica de nenhuma ferramenta.

## Convenção

- Um arquivo Markdown por domínio de regra, nomeado pelo assunto (ex: `design-system.md`, `frontend.md`, `architecture.md`, `accessibility.md`).
- Conteúdo livre — forge-sdd só garante a pasta e a convenção; o que declarar aqui é decisão do projeto.
- Cada agente lê os arquivos relevantes à tarefa corrente sob demanda (mesmo mecanismo já usado para `sdd/memory/progress.md`/`lessons.md`) — não é necessário carregar tudo o tempo todo.
- `forge-sdd update` nunca sobrescreve ou remove arquivos aqui — só cria a pasta se estiver ausente.

Veja `example.md.example` para um ponto de partida (renomeie/edite para `.md` real quando começar a declarar regras).
