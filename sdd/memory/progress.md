# Progress — dev-setup

## Status
```
Fase 0 — Foundation           [ ] todo
Feature 83bb — dev-cli-installer  [x] done
```

## Features ativas
| Feature | Branch | Status |
|---------|--------|--------|
| feat-00-foundation | feat/foundation | todo |
| feat-83bb-01-fundacao-cli | feat/83bb-dev-cli-installer | done |
| feat-83bb-02-motor-menu | feat/83bb-dev-cli-installer | done |
| feat-83bb-03-instaladores-core | feat/83bb-dev-cli-installer | done |
| feat-83bb-04-instaladores-ia | feat/83bb-dev-cli-installer | done |
| feat-83bb-05-dotfiles-zsh | feat/83bb-dev-cli-installer | done |
| feat-83bb-06-hardening-docs | feat/83bb-dev-cli-installer | done |

## Próximo passo
**Iniciar:** revisar/mergear `claude/dry-run-mode-fix-9v8dlq` (fix: `--dry-run` executava efeitos reais em `ensure_homebrew` e `apply_dotfiles`).
**Bloqueios:** —

## Handoff extra
- `feat/83bb-dev-cli-installer` (PR #1), `fix/faa0-selecao-nao-funciona` (PR #2, menu navegável por setas) e o PR #4 (trouxe o fix pendente para `main`) já foram mergeados.
- `claude/dry-run-mode-fix-9v8dlq`: `--dry-run` agora gateia `ensure_homebrew` (lib/detect_os.sh) e `_dotfiles_backup_and_link` (lib/dotfiles.sh) — nenhum efeito colateral real (curl/brew/mv/ln) ocorre em modo simulação. Suíte de testes nova em `tests/` (bash puro, sem framework externo — projeto não tinha testes antes).

## Handoff da última sessão
- CLI `dev-setup` implementado por completo (setup.sh, lib/, installers/, dotfiles/, README.md) na branch `feat/83bb-dev-cli-installer`, compatível com bash 3.2 (padrão do macOS).
- Todos os critérios executáveis de `sdd/discovery/criteria-83bb-dev-cli-installer.md` validados manualmente (--about, --list, --dry-run, idempotência, dotfiles com backup/symlink).
- Dotfiles reais do usuário (`.zshrc`, `.p10k.zsh`) importados e adaptados (nvm no lugar de nvs, oh-my-zsh instalado de fato, paths portáveis via `brew --prefix`).

## Última sessão

> Histórico completo em `progress-log.md`
