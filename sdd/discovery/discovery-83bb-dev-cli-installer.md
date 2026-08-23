# Discovery 83bb — CLI de reinstalação do ambiente de dev

**ID:** `83bb` (hash)
**Data:** 2026-08-23
**Autor:** nathan.ramorim@gmail.com

## Problema
O usuário vai formatar o Mac e precisa reconfigurar manualmente todo o ambiente de desenvolvimento (linguagens, CLIs, apps, dotfiles do zsh). Esse processo é repetitivo, propenso a esquecimento de passos e consome tempo toda vez que a máquina é reinstalada.

## Para quem
Uso pessoal — o próprio usuário, desenvolvedor(a) full stack que atua hoje com Node.js, .NET, GitHub CLI, Antigravity CLI, Claude Code CLI, VS Code, DBeaver, Bruno (testes de API/E2E), iTerm2, configuração completa de zsh, Homebrew como gerenciador de pacotes principal, e eventualmente Python (via `uv`, não pip/venv/conda tradicional).

Máquina de referência observada nesta sessão: macOS 15.7.4, arquitetura `arm64` (Apple Silicon).

## Como (visão macro)
Um CLI em shell script (bash/zsh), versionado neste repositório, que:
1. Detecta o sistema operacional e a arquitetura para garantir compatibilidade (hoje: macOS/Apple Silicon; deixar aberto para macOS Intel).
2. Garante que o Homebrew está instalado (bootstrap se necessário).
3. Apresenta um menu interativo permitindo ao usuário selecionar quais ferramentas/categorias deseja instalar (todas, ou um subconjunto).
4. Instala cada item selecionado de forma idempotente (não reinstala/não quebra se já existir).
5. Restaura a configuração de zsh (dotfiles, aliases, plugins, tema) a partir dos arquivos versionados neste repo.
6. Pode ser reexecutado com segurança após uma formatação, sem exigir que o usuário lembre manualmente de cada ferramenta.

## Escopo

**Dentro do escopo:**
- Instalação via Homebrew (formulae e casks) para: Node.js, .NET SDK, GitHub CLI, Claude Code CLI, VS Code, DBeaver, Bruno, iTerm2.
- Instalação/bootstrap do `uv` para gestão de Python.
- Restauração de configuração de zsh (dotfiles) versionada no repo.
- Seleção interativa do que instalar (menu, não "tudo ou nada").
- Detecção de SO/arquitetura antes de instalar.
- Banner de abertura do CLI com identidade do autor: `nathanramorim`, LinkedIn (`linkedin.com/in/nathanramorim`) e Instagram (`instagram.com/nathanramorim`).

**Fora do escopo (nesta rodada):**
- Suporte a Linux/Windows (documentar como possível evolução futura, não implementar agora).
- Sincronização de licenças/configurações internas de cada aplicativo (ex: temas, extensões do VS Code) — apenas instalação do binário/app, salvo indicação contrária.
- Gestão de secrets/credenciais (login em GitHub CLI, autenticação de ferramentas) — o CLI prepara o terreno, mas o login manual continua sendo do usuário.

## Critérios de sucesso (negócio)
- Após formatar o Mac, o usuário consegue rodar um único comando e escolher visualmente o que quer instalar.
- O tempo de reconfiguração de um ambiente de dev completo cai de "várias horas manuais" para "um script + poucos minutos de interação".
- O script pode ser executado mais de uma vez sem causar erros ou duplicar instalações (idempotência).
- A configuração do zsh volta ao estado desejado sem o usuário precisar copiar arquivos manualmente.

## Riscos e premissas
- Algumas ferramentas (.NET SDK, Bruno) podem não ter cask estável no Homebrew em todas as versões — precisa validação técnica (`criteria-83bb`).
- O usuário roda hoje em Apple Silicon; se também usar Intel em outra máquina, o script precisa lidar com o path do Homebrew (`/opt/homebrew` vs `/usr/local`).
- O instalador do Antigravity CLI (`curl | bash` de `antigravity.google`) baixa e executa script remoto — validar no momento da implementação se há flag de verificação/checksum, e informar o usuário antes de rodar.

## Perguntas em aberto — respondidas em 2026-08-23
1. ~~"Antigravity CLI" — qual é o pacote/instalador exato?~~ **Resolvido:** instalador oficial via `curl -fsSL https://antigravity.google/cli/install.sh | bash`.
2. ~~Node.js: Homebrew direto ou version manager?~~ **Resolvido:** via `nvm`. O instalador deve, além de instalar o `nvm`, ensinar o uso básico (help/onboarding no output do CLI).
3. ~~Dotfiles de zsh já existem em algum lugar?~~ **Resolvido:** criar do zero nesta iniciativa (não há dotfiles pré-existentes a importar).
4. Confirmar se o VCS/work item system permanece `github` (conforme `constitution.md`) para abertura de PRs das features. **Segue aberto** — assumir `github` (valor atual da constitution) salvo indicação contrária.
