# feat-83bb-05-dotfiles-zsh

**Branch:** `feat/83bb-dev-cli-installer`
**Fase:** 3
**Depende de:** `feat-83bb-01-fundacao-cli`
**Status:** `done`

## Objetivo
Versionar a configuração real de zsh do usuário (importada de `~/.zshrc` e `~/.p10k.zsh`), adaptada para ser portável (paths via `brew --prefix` em vez de hardcoded) e alinhada às decisões do discovery (nvm no lugar de nvs, oh-my-zsh instalado de fato), e implementar a restauração via CLI com backup automático.

## Origem
Importado de `~/.zshrc` e `~/.p10k.zsh` da máquina atual (levantado em 2026-08-23). Ajustes em relação ao original:
- **Node:** troca `nvs` por `nvm` (decisão do discovery 83bb).
- **oh-my-zsh:** hoje `ZSH_THEME`/`plugins` estão declarados no `.zshrc` mas o framework nunca é de fato instalado/sourced (`~/.oh-my-zsh` não existe) — o novo dotfile deve instalar o oh-my-zsh e sourceá-lo corretamente, mantendo Powerlevel10k como tema e os plugins já usados (`git`, `brew`, `macos`, `zsh-autosuggestions`, `zsh-syntax-highlighting`).
- **pnpm:** mantido (já presente no `.zshrc` atual, mesmo fora da lista original de ferramentas).
- **Rancher Desktop:** removido — fora do escopo combinado com o usuário.
- **Paths do Homebrew:** `powerlevel10k`, `zsh-autosuggestions`, `zsh-syntax-highlighting` hoje são sourceados de `/usr/local/share/...` (Homebrew Intel); trocar para `$(brew --prefix)/share/...` para funcionar tanto em `arm64` (`/opt/homebrew`) quanto Intel (`/usr/local`).
- Blocos gerados por instaladores de terceiros (Rancher Desktop, VS Code shell integration, `~/.local/bin/env`) são recriados dinamicamente pelos próprios instaladores da feature `feat-83bb-03`/`feat-83bb-04`, não hardcoded no dotfile versionado.

## Critério de conclusão
```bash
./setup.sh --dotfiles
test -f ~/.zshrc.bak.<timestamp>   # backup criado antes de sobrescrever
readlink ~/.zshrc | grep -q "dotfiles/zshrc"   # symlink aplicado corretamente
zsh -c 'source ~/.zshrc; command -v nvm && command -v pnpm'   # nvm e pnpm funcionais
```

## Tarefas
- [ ] **83bb-05-1** Criar `dotfiles/zshrc` a partir do `.zshrc` real do usuário, com os ajustes listados em "Origem" (nvm em vez de nvs, paths via `brew --prefix`, sem Rancher Desktop)
- [ ] **83bb-05-2** Criar `dotfiles/p10k.zsh` a partir do `~/.p10k.zsh` real do usuário (1705 linhas — copiado como está)
- [ ] **83bb-05-3** Criar `dotfiles/aliases.zsh` com os aliases atuais (`ll`, `update`, `alias python=python3`)
- [ ] **83bb-05-4** `installers/oh_my_zsh.sh` — instala o oh-my-zsh de fato (framework hoje ausente apesar de referenciado no `.zshrc`)
- [ ] **83bb-05-5** `installers/pnpm.sh` — instala pnpm (mantido do `.zshrc` atual, fora da lista original mas já em uso)
- [ ] **83bb-05-6** Implementar `lib/dotfiles.sh`: aplica `dotfiles/zshrc` → `~/.zshrc` e `dotfiles/p10k.zsh` → `~/.p10k.zsh` via symlink, com backup automático (`~/.zshrc.bak.<timestamp>`) antes de sobrescrever qualquer arquivo existente

## Arquivos gerados
```
dotfiles/zshrc
dotfiles/p10k.zsh
dotfiles/aliases.zsh
lib/dotfiles.sh
installers/oh_my_zsh.sh
installers/pnpm.sh
```

## Skills relevantes
(consultar `skills/index.md`)
