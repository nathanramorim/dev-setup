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
**Iniciar:** revisar/mergear `fix/6b3f-node-install-incompleto` (fix: instalador `node` só instalava o `nvm`, sem Node/npm de fato).
**Bloqueios:** —

## Handoff extra
- `feat/83bb-dev-cli-installer` (PR #1), `fix/faa0-selecao-nao-funciona` (PR #2, menu navegável por setas), PR #4 (fix pendente para `main`) e `claude/dry-run-mode-fix-9v8dlq` (PR #8, `--dry-run` sem efeitos reais) já foram mergeados.
- `fix/6b3f-node-install-incompleto`: `installers/node.sh` agora roda `nvm install --lts` + `nvm alias default 'lts/*'` de fato (antes só instalava o `nvm` e imprimia instruções). Novo helper `load_default_node` (lib/common.sh) carrega o Node "default" do nvm em qualquer installer — necessário porque cada `installers/*.sh` roda em subprocesso isolado (lib/registry.sh), então `claude_code.sh` precisa carregar o ambiente por conta própria em vez de depender de PATH herdado. `check()` de `node.sh` agora valida a cadeia completa (nvm+node+npm), não só a existência do `nvm.sh`. Testado com instalação real (rede) além dos mocks em `tests/test_node_install.sh`.

## Handoff da última sessão
- CLI `dev-setup` implementado por completo (setup.sh, lib/, installers/, dotfiles/, README.md) na branch `feat/83bb-dev-cli-installer`, compatível com bash 3.2 (padrão do macOS).
- Todos os critérios executáveis de `sdd/discovery/criteria-83bb-dev-cli-installer.md` validados manualmente (--about, --list, --dry-run, idempotência, dotfiles com backup/symlink).
- Dotfiles reais do usuário (`.zshrc`, `.p10k.zsh`) importados e adaptados (nvm no lugar de nvs, oh-my-zsh instalado de fato, paths portáveis via `brew --prefix`).

## Última sessão

> Histórico completo em `progress-log.md`
