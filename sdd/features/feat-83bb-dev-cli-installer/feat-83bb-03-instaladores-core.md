# feat-83bb-03-instaladores-core

**Branch:** `feat/83bb-dev-cli-installer`
**Fase:** 2
**Depende de:** `feat-83bb-02-motor-menu`
**Status:** `todo`

## Objetivo
Implementar os instaladores idempotentes das ferramentas "core" do dia a dia: Node.js (via `nvm`), .NET SDK, GitHub CLI, VS Code, DBeaver, Bruno, iTerm2 e `uv` (Python).

## Critério de conclusão
```bash
./setup.sh --only node && ./setup.sh --only node     # roda 2x sem erro (idempotência)
./setup.sh --only gh && ./setup.sh --only gh
./setup.sh --only uv && ./setup.sh --only uv
nvm --version    # instalado e funcional após ./setup.sh --only node
uv --version     # instalado e funcional após ./setup.sh --only uv
```

## Tarefas
- [ ] **83bb-03-1** `installers/node.sh` — instala `nvm`; ao final, imprime instruções básicas de uso (`nvm install --lts`, `nvm use`)
- [ ] **83bb-03-2** `installers/dotnet.sh` — Homebrew cask `dotnet-sdk`
- [ ] **83bb-03-3** `installers/gh.sh` — Homebrew formula `gh`
- [ ] **83bb-03-4** `installers/vscode.sh` — Homebrew cask `visual-studio-code`
- [ ] **83bb-03-5** `installers/dbeaver.sh` — Homebrew cask `dbeaver-community`
- [ ] **83bb-03-6** `installers/bruno.sh` — Homebrew cask `bruno`
- [ ] **83bb-03-7** `installers/iterm2.sh` — Homebrew cask `iterm2`
- [ ] **83bb-03-8** `installers/uv.sh` — instala `uv` (Homebrew formula `uv`, ou script oficial `astral.sh` como fallback)

## Arquivos gerados
```
installers/node.sh
installers/dotnet.sh
installers/gh.sh
installers/vscode.sh
installers/dbeaver.sh
installers/bruno.sh
installers/iterm2.sh
installers/uv.sh
```

## Skills relevantes
(consultar `skills/index.md`)
