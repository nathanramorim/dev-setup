# feat-83bb-01-fundacao-cli

**Branch:** `feat/83bb-dev-cli-installer` (branch única para toda a feature `83bb`, conforme regra 7 da constitution)
**Fase:** 0
**Depende de:** —
**Status:** `done`

## Objetivo
Criar a estrutura base do CLI de reinstalação do ambiente de dev: entry point, detecção de SO/arquitetura, bootstrap do Homebrew e o contrato padrão que todo instalador vai seguir.

## Critério de conclusão
```bash
test -x ./setup.sh
./lib/detect_os.sh   # imprime SO + arch (arm64/x86_64) + path do brew, exit 0
which brew || ./setup.sh --bootstrap-brew   # garante Homebrew instalado
```

## Tarefas
- [ ] **83bb-01-1** Criar `setup.sh` (entry point) e estrutura de pastas `lib/`, `installers/`, `dotfiles/`
- [ ] **83bb-01-2** Implementar `lib/detect_os.sh` (SO, arquitetura, path do Homebrew: `/opt/homebrew` vs `/usr/local`)
- [ ] **83bb-01-3** Implementar bootstrap do Homebrew (instala se ausente, idempotente)
- [ ] **83bb-01-4** Documentar/implementar o contrato padrão de instalador (`check()` / `install()`) usado por todos os módulos em `installers/`

## Arquivos gerados
```
setup.sh
lib/detect_os.sh
installers/.gitkeep
dotfiles/.gitkeep
```

## Skills relevantes
(consultar `skills/index.md`)
