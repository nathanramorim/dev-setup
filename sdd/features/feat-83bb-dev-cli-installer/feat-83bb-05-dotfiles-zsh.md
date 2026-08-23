# feat-83bb-05-dotfiles-zsh

**Branch:** `feat/83bb-dev-cli-installer`
**Fase:** 3
**Depende de:** `feat-83bb-01-fundacao-cli`
**Status:** `todo`

## Objetivo
Criar do zero e versionar a configuração completa de zsh do usuário (dotfiles, aliases, tema, plugins) e implementar a restauração via CLI, com backup automático do que já existir na máquina.

## Critério de conclusão
```bash
./setup.sh --dotfiles
test -f ~/.zshrc.bak.<timestamp>   # backup criado antes de sobrescrever
readlink ~/.zshrc | grep -q "dotfiles/zshrc"   # symlink aplicado corretamente
```

## Tarefas
- [ ] **83bb-05-1** Levantar com o usuário o conteúdo desejado do `.zshrc` (aliases, tema, plugins) — não há dotfiles pré-existentes a importar
- [ ] **83bb-05-2** Criar `dotfiles/zshrc`, `dotfiles/aliases.zsh` e demais arquivos de configuração versionados
- [ ] **83bb-05-3** Implementar `lib/dotfiles.sh`: aplica via symlink e faz backup automático (`~/.zshrc.bak.<timestamp>`) antes de sobrescrever qualquer arquivo existente

## Arquivos gerados
```
dotfiles/zshrc
dotfiles/aliases.zsh
lib/dotfiles.sh
```

## Skills relevantes
(consultar `skills/index.md`)
