# Constituição — dev-setup

## Missão
CLI em shell script que reinstala e configura o ambiente de desenvolvimento do usuário (ferramentas, apps e dotfiles de zsh) após formatação do Mac.

## Stack
| Camada | Escolha | Motivo |
|--------|---------|--------|
| Runtime | shell (bash/zsh) | Sem dependências externas para bootstrap em macOS recém-formatado; alinhado à decisão 83bb |
| DB | none | |
| Config | flags de CLI + dotfiles versionados em `dotfiles/` | |
| Secrets | nenhum manipulado pelo script (login interativo do usuário) | |

## Decisões resolvidas
| Decisão | Resolução |
|---------|-----------|
| Runtime do projeto (discovery 83bb) | Shell script (bash/zsh), substituindo o placeholder `go` — confirmado pelo usuário em 2026-08-23 |

## Ferramentas e Integrações
| Campo | Valor |
|-------|-------|
| VCS / Work Item System | github |

Consulte `sdd/memory/mcps.md` para o status real de cada MCP configurado (`ativo`/`indisponível`) antes de assumir que ele responde. Se "VCS / Work Item System" for `azure-devops`, use `az repos pr create` (ou instrução equivalente documentada) em vez de `gh pr create`. Se `nenhum`, deixe a branch pronta e informe o usuário, sem tentar nenhum comando de VCS.

## Regras (máx. 10)
1. Sem commits diretos em main
2. Branch por feature
3. Config centralizado em <arquivo>
4. Secrets em .env (nunca commit)
5. Antes de usar lib externa, consultar context7 com versão exata — desde que `sdd/memory/mcps.md` o liste como `ativo`; se `indisponível`, usar a documentação oficial da lib
6. Toda feature tem critério executável
7. Feature quebrada em subpasta (`sdd/features/<prefixo>-ID-<nome>/`) usa uma única branch agrupando todas as subtarefas — nunca uma branch por subtarefa. Antes de criar a branch, pergunte a branch de partida (default `main`) e verifique (`git branch --list <prefixo>/ID-*`) se já existe uma branch da mesma feature/fix a retomar.
