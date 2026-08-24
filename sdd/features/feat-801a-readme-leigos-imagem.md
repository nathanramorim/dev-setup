# feat/801a-readme-leigos-imagem

**Branch:** `feat/801a-readme-leigos-imagem`
**Base:** `main` (via `feat/83bb-dev-cli-installer`, já mergeada)
**Status:** `done`

## Objetivo
Tornar o `README.md` acolhedor para quem não é dev (comunicação em linguagem simples), adicionar uma imagem/banner visual, contar a motivação pessoal do projeto e indicar como contribuir/entrar em contato.

## Pedido do usuário (literal)
- Melhorar a comunicação para leigos.
- Colocar imagem no README (decidido: banner SVG gerado localmente, sem depender de arquivo externo do usuário).
- Incluir a história: precisou formatar o PC, bateu a preguiça de reinstalar tudo manualmente, então criou o CLI para ajudar pelo menos com o básico e "ser feliz no mundo dev".
- Convite para sugestões via issue do GitHub ou contato no LinkedIn, com link de apresentação: https://tremdelinks.vercel.app/nathan-amorim

## Critério de conclusão
```bash
# README.md deve conter, nesta ordem:
# 1. Banner/imagem no topo
# 2. Seção "O que é isso?" em linguagem simples (não-técnica)
# 3. Seção com a história pessoal (motivação)
# 4. Seção de uso técnico (já existente, preservada)
# 5. Seção de contato/sugestões com link do LinkedIn/apresentação
test -f docs/banner.svg
grep -q "tremdelinks.vercel.app/nathan-amorim" README.md
grep -q "docs/banner.svg" README.md
```

## Tarefas
- [x] **801a-1** Criar `docs/banner.svg` (banner simples, sem dependências externas)
- [x] **801a-2** Reescrever a introdução do `README.md` em linguagem simples para leigos, com a história pessoal
- [x] **801a-3** Adicionar seção de contato/sugestões (issues + LinkedIn) ao final do README
- [x] **801a-4** Preservar todo o conteúdo técnico existente (Uso, Ferramentas, Estrutura, Compatibilidade)

## Validação
```
test -f docs/banner.svg               # OK
grep tremdelinks.vercel.app README.md # OK
grep docs/banner.svg README.md        # OK
python3 -c "xml.dom.minidom.parse(...)" docs/banner.svg  # SVG válido
```

## Arquivos gerados/alterados
```
README.md
docs/banner.svg
```

## Skills relevantes
(consultar `skills/index.md`)
