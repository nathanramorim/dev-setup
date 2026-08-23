# CLAUDE.md — dev-setup

## Contexto do projeto
dev-setup — stack principal: go.

## Lifecycle (todo agente)
_Protocolo por comando. O pipeline por feature (Discovery → ... → PR) está em `sdd/FLOW.md` — fonte única da verdade._

1. **READ-MIN:** ler `sdd/memory/progress.md` (Builder e Revisor também leem `sdd/memory/lessons.md` — padrões de erro já corrigidos, antes de implementar/revisar)
2. **PLAN:** reportar intenção, aguardar confirmação
3. **ACT:** executar no escopo do papel
4. **WRITE:** editar apenas arquivos do escopo
5. **CLOSE** (Orquestrador): atualizar progress, gravar telemetria em `sdd/.metrics/session-<ISO8601>.json` (se `telemetry.enabled`), archive se necessário

## Arquivos críticos
- `sdd/memory/progress.md` — estado ativo (leia primeiro a cada sessão)
- `sdd/memory/constitution.md` — regras imutáveis
- `sdd/features/feat-XX-*.md` (ou aninhados em subpastas) — tarefa atual
- `.agent/rules/*.md` — regras de domínio do projeto (design system, arquitetura, acessibilidade, ...). Antes de agir sobre código ou design, consulte os arquivos relevantes à tarefa corrente.

## MCPs
O Claude Desktop utiliza a configuração global em `~/Library/Application Support/Claude/claude_desktop_config.json` (macOS) ou `%APPDATA%\Claude\claude_desktop_config.json` (Windows).
Recomenda-se configurar os seguintes MCPs:
- **context7** (`npx -y @upstash/context7-mcp`)
- **git** (`uvx mcp-server-git --repository <caminho-do-projeto>`)

## Orçamentos
- `progress.md` ≤ 1 KB
- Resposta de planejamento ≤ 500 tokens — detalhe vai para `sdd/skills/`

## Regras
- Nunca commite direto em `main`
- Consulte `sdd/memory/constitution.md` antes de decisões arquiteturais
- Use ferramentas de leitura antes de editar qualquer arquivo
- Siga rigorosamente a responsabilidade única por artefato (Specifier escreve specs, Builder escreve código, etc.)
- Ao quebrar features em tasks ou discovery em features, agrupar arquivos em subpastas sob `sdd/features/` (a pasta da feature gerada pelo discovery deve refletir o nome do discovery).

## Comandos Customizados
Este projeto define comandos em `.claude/commands/`. Use-os para tarefas recorrentes:
- `/status` -> `.claude/commands/status.prompt.md`
- `/proxima-feature` -> `.claude/commands/proxima-feature.prompt.md`
- `/nova-feature` -> `.claude/commands/nova-feature.prompt.md`
- `/novo-fix` -> `.claude/commands/novo-fix.prompt.md`
- `/revisar` -> `.claude/commands/revisar.prompt.md`
- `/archive` -> `.claude/commands/archive.prompt.md`
- `/doctor` -> `.claude/commands/doctor.prompt.md`
- `/upgrade-sdd` -> `.claude/commands/upgrade-sdd.prompt.md`
- `/discovery` -> `.claude/commands/discovery.prompt.md`
- `/constitution` -> `.claude/commands/constitution.prompt.md`
- `/c4-architecture` -> `.claude/commands/c4-architecture.prompt.md`
- `/split-features` -> `.claude/commands/split-features.prompt.md`
