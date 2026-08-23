# feat-83bb-06-hardening-docs

**Branch:** `feat/83bb-dev-cli-installer`
**Fase:** 4
**Depende de:** `feat-83bb-03-instaladores-core`, `feat-83bb-04-instaladores-ia`, `feat-83bb-05-dotfiles-zsh`
**Status:** `todo`

## Objetivo
Garantir idempotência ponta a ponta de todos os instaladores e documentar o uso do CLI para o próprio usuário retomar o projeto após uma formatação futura.

## Critério de conclusão
```bash
./setup.sh --all --dry-run                      # lista tudo que seria feito, sem erros
for i in node dotnet gh vscode dbeaver bruno iterm2 uv claude-code antigravity; do
  ./setup.sh --only "$i" && ./setup.sh --only "$i" || exit 1
done
test -f ./README.md
```

## Tarefas
- [ ] **83bb-06-1** Rodar todos os instaladores 2x seguidas e confirmar que nenhum falha na segunda execução (idempotência ponta a ponta)
- [ ] **83bb-06-2** Escrever `README.md`: como rodar, flags disponíveis, lista de ferramentas cobertas, como estender com um novo instalador
- [ ] **83bb-06-3** Validar todos os critérios de aceitação executáveis descritos em `sdd/discovery/criteria-83bb-dev-cli-installer.md`

## Arquivos gerados
```
README.md
```

## Skills relevantes
(consultar `skills/index.md`)
