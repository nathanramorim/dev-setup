# feat-83bb-04-instaladores-ia

**Branch:** `feat/83bb-dev-cli-installer`
**Fase:** 2
**Depende de:** `feat-83bb-02-motor-menu`
**Status:** `done`

## Objetivo
Implementar os instaladores idempotentes das CLIs de IA usadas no dia a dia: Claude Code CLI e Antigravity CLI.

## Critério de conclusão
```bash
./setup.sh --only claude-code && ./setup.sh --only claude-code   # idempotente
./setup.sh --only antigravity && ./setup.sh --only antigravity   # idempotente
claude --version
```

## Tarefas
- [ ] **83bb-04-1** `installers/claude_code.sh` — instala a Claude Code CLI pelo canal oficial suportado (Homebrew ou instalador oficial, a validar na implementação)
- [ ] **83bb-04-2** `installers/antigravity.sh` — instala via `curl -fsSL https://antigravity.google/cli/install.sh | bash`; exibir aviso ao usuário antes de executar script remoto
- [ ] **83bb-04-3** Checagem de idempotência (`check()`) para ambos, evitando reinstalação desnecessária

## Arquivos gerados
```
installers/claude_code.sh
installers/antigravity.sh
```

## Skills relevantes
(consultar `skills/index.md`)
