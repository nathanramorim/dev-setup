# Overview — dev-setup

[2-3 linhas descrevendo o sistema]

## Índice
- `stack.md` — tecnologias
- `modules.md` — componentes
- `flows.md` — fluxos principais
- `decisions.md` — decisões de design

---

## Arquitetura (C4 Model)

### Nível 1: Contexto
\`\`\`mermaid
graph TB
  User((Usuário)) --> Project[dev-setup]
\`\`\`

### Nível 2: Containers
\`\`\`mermaid
graph LR
  App[Aplicação] --> DB[(Banco de Dados)]
\`\`\`
