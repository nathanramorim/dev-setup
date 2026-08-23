# GEMINI.md — dev-setup

## Contexto do projeto
dev-setup — stack principal: go.

## Lifecycle (todo agente)
_Protocolo por comando. O pipeline por feature (Discovery → ... → PR) está em `sdd/FLOW.md` — fonte única da verdade._

1. **READ-MIN:** ler `sdd/memory/progress.md` (Builder e Revisor também leem `sdd/memory/lessons.md` — padrões de erro já corrigidos, antes de implementar/revisar)
2. **PLAN:** reportar intenção, aguardar confirmação
3. **ACT:** executar no escopo do papel (use as skills em `.gemini/skills/`)
4. **WRITE:** editar apenas arquivos do escopo
5. **CLOSE** (Orquestrador): atualizar progress, métricas, archive se necessário

## Arquivos críticos
- `sdd/memory/progress.md` — estado ativo (leia primeiro a cada sessão)
- `sdd/memory/constitution.md` — regras imutáveis
- `sdd/features/feat-XX-*.md` — tarefa atual
- `.agent/rules/*.md` — regras de domínio do projeto (design system, arquitetura, acessibilidade, ...). Antes de agir sobre código ou design, consulte os arquivos relevantes à tarefa corrente.

## MCPs
- O Gemini utiliza as configurações de MCP em `.gemini/mcp.json`.
- **context7** — obrigatório antes de qualquer `go get` ou uso de lib externa, desde que `sdd/memory/mcps.md` o liste como `ativo`; se `indisponível`, use a documentação oficial da lib em vez de assumir resposta do MCP.
- **git** — consultar status antes de iniciar/encerrar feature.

## Orçamentos
- `progress.md` ≤ 1 KB
- Resposta de planejamento ≤ 500 tokens — detalhe vai para `sdd/skills/`

## Regras
- Nunca commite direto em `main`
- Consulte `sdd/memory/constitution.md` antes de decisões arquiteturais
- Use ferramentas de leitura antes de editar qualquer arquivo
- Siga rigorosamente a responsabilidade única por artefato (Specifier escreve specs, Builder escreve código, etc.)

## Skills & Papéis
Este projeto define papéis específicos em `.gemini/skills/`. Carregue a instrução correspondente ao iniciar uma fase:
- **Orquestrador:** `.gemini/skills/orquestrador.chatmode.md`
- **Builder:** `.gemini/skills/builder.chatmode.md`
- **Revisor:** `.gemini/skills/revisor.chatmode.md`
- **Archivist:** `.gemini/skills/archivist.chatmode.md`
- **Specifier:** `.gemini/skills/specifier.chatmode.md`
- **Migrator:** `.gemini/skills/migrator.chatmode.md`
- **Architect:** `.gemini/skills/c4-architecture.chatmode.md`

## Prompts (Comandos)
Para executar uma tarefa, peça pelo nome do comando ou utilize uma das frases de exemplo. Eu consultarei a instrução correspondente em `.gemini/prompts/`:

- **Status:** "rodar o status", "qual o progresso?" → `status.prompt.md`
- **Próxima Feature:** "iniciar próxima tarefa", "proxima-feature" → `proxima-feature.prompt.md`
- **Nova Feature:** "criar nova feature [descrição]", "nova-feature" → `nova-feature.prompt.md`
- **Novo Fix:** "criar fix para [descrição do bug]", "novo-fix" → `novo-fix.prompt.md`
- **Revisar:** "validar feature", "rodar o revisar" → `revisar.prompt.md`
- **Discovery:** "discovery [ideia]", "fazer discovery de..." → `discovery.prompt.md`
- **Constitution:** "alinhar arquitetura", "rodar constitution" → `constitution.prompt.md`
- **C4 Architecture:** "gerar diagrama C4", "desenhar arquitetura" → `c4-architecture.prompt.md`
- **Split Features:** "quebrar plano em features", "split-features" → `split-features.prompt.md`
- **Doctor:** "check-up do projeto", "rodar doctor" → `doctor.prompt.md`
- **Archive:** "limpar progresso", "rodar archive" → `archive.prompt.md`
- **Upgrade:** "atualizar sdd para vX", "upgrade-sdd" → `upgrade-sdd.prompt.md`
