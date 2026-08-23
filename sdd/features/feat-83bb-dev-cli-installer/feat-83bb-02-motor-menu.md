# feat-83bb-02-motor-menu

**Branch:** `feat/83bb-dev-cli-installer`
**Fase:** 1
**Depende de:** `feat-83bb-01-fundacao-cli`
**Status:** `todo`

## Objetivo
Implementar o motor do CLI: parsing de flags, menu interativo de seleção por categoria, orquestração dos instaladores selecionados e o banner de branding do autor.

## Critério de conclusão
```bash
./setup.sh --list                                   # lista todas as categorias disponíveis
./setup.sh --dry-run --only node,gh,vscode           # mostra o que seria instalado, sem instalar
./setup.sh --about | grep -q "nathanramorim"
./setup.sh --about | grep -q "linkedin.com/in/nathanramorim"
./setup.sh --about | grep -q "instagram.com/nathanramorim"
```

## Tarefas
- [ ] **83bb-02-1** Parsing de flags: `--list`, `--dry-run`, `--only`, `--all`, `--dotfiles`, `--about`
- [ ] **83bb-02-2** Menu interativo (`select` do bash) para escolher categorias/ferramentas
- [ ] **83bb-02-3** Orquestração: rodar apenas os instaladores selecionados, com log de sucesso/erro por item
- [ ] **83bb-02-4** Banner de abertura (`lib/banner.sh`) exibindo `nathanramorim`, `linkedin.com/in/nathanramorim`, `instagram.com/nathanramorim`

## Arquivos gerados
```
lib/menu.sh
lib/banner.sh
lib/cli_args.sh
```

## Skills relevantes
(consultar `skills/index.md`)
