# Plano preliminar 83bb — CLI de reinstalação do ambiente de dev

**ID:** `83bb` (hash)
**Refs:** `discovery-83bb-dev-cli-installer.md`, `criteria-83bb-dev-cli-installer.md`

## Roadmap por fase

### Fase 0 — Fundação
- Estrutura de pastas do script (`setup.sh`, `lib/`, `installers/`, `dotfiles/`).
- Detecção de SO/arquitetura (`lib/detect_os.sh`).
- Bootstrap do Homebrew se ausente.
- Contrato padrão de instalador (`check()` / `install()`) documentado.

### Fase 1 — Motor do CLI
- Parsing de flags (`--list`, `--dry-run`, `--only`, `--all`, `--dotfiles`).
- Menu interativo de seleção por categoria.
- Orquestração: rodar apenas os instaladores selecionados, com log de sucesso/erro por item.

### Fase 2 — Instaladores de ferramentas
- Node.js, .NET SDK, GitHub CLI, VS Code, DBeaver, Bruno, iTerm2 (via Homebrew).
- `uv` (Python).
- Claude Code CLI e Antigravity CLI (canal de instalação a confirmar antes de iniciar).

### Fase 3 — Configuração de zsh
- Dotfiles versionados, importados dos arquivos reais do usuário (`.zshrc`, `.p10k.zsh`), com paths tornados portáveis e `nvs` trocado por `nvm`.
- Instalador de `oh-my-zsh` (hoje referenciado mas ausente) e de `pnpm`.
- Aplicação via symlink + backup automático do que já existir na máquina.

### Fase 4 — Robustez e documentação
- Idempotência validada em todos os instaladores (rodar 2x sem erro).
- `README.md` de uso do CLI.
- Critérios de aceitação executáveis (ver `criteria-83bb`) rodando verde.

## Quebra estimada de features
| Feature (rascunho) | Fase | Depende de |
|---|---|---|
| feat-83bb-fundacao-cli | 0 | — |
| feat-83bb-motor-menu | 1 | feat-83bb-fundacao-cli |
| feat-83bb-instaladores-core | 2 | feat-83bb-motor-menu |
| feat-83bb-instaladores-ia | 2 | feat-83bb-motor-menu |
| feat-83bb-dotfiles-zsh | 3 | feat-83bb-fundacao-cli |
| feat-83bb-hardening-docs | 4 | todas as anteriores |

Essa quebra é uma estimativa inicial — a decisão final de escopo/granularidade de cada feature acontece em `/split-features`.

## Bloqueios — todos resolvidos em 2026-08-23
1. ~~Antigravity CLI~~ → instalador oficial `curl -fsSL https://antigravity.google/cli/install.sh | bash`.
2. ~~Node.js~~ → via `nvm`, com onboarding de uso no output do CLI.
3. ~~Dotfiles de zsh~~ → criados do zero nesta iniciativa.
4. ~~Divergência de stack~~ → `sdd/memory/constitution.md` atualizada: `Runtime: shell (bash/zsh)`, decisão registrada em "Decisões resolvidas".

## Handoff para `/split-features`
Arquivos criados/atualizados nesta rodada de discovery:
- `sdd/discovery/discovery-83bb-dev-cli-installer.md`
- `sdd/discovery/criteria-83bb-dev-cli-installer.md`
- `sdd/discovery/plan-83bb-dev-cli-installer.md`
- `sdd/memory/constitution.md` (Stack/Decisões resolvidas)

Sem bloqueios pendentes. Próximo passo: rodar `/split-features` referenciando o discovery `83bb`, quebrando as features do roadmap acima dentro de `sdd/features/feat-83bb-dev-cli-installer/` (subpasta nomeada a partir deste discovery, conforme `CLAUDE.md`).
