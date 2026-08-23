# Guia de Início Rápido — Forge-SDD

Este guia explica como utilizar o **forge-sdd** de forma eficiente, dependendo do estado atual do seu projeto.

---

## 🆕 Cenário A: Novo Projeto (Do Zero)

Use esta trilha se você está começando um projeto agora e quer que a IA ajude a definir tudo.

1.  **Inicialize:**
    ```bash
    npx @nathanramorim/forge-sdd@latest init
    ```
2.  **Alinhe a Arquitetura (`/constitution`):**
    Peça ao agente para rodar `/constitution`. Como o projeto está vazio, ele proporá uma estrutura base (Pastas, Padrões, Regras) para a stack que você escolheu.
3.  **Realize o Discovery (`/discovery`):**
    ```bash
    /discovery "Quero criar um sistema de [descrição da sua ideia]"
    ```
    O agente gerará a visão de produto e os critérios técnicos em `sdd/discovery/`.
4.  **Mapeie as Tarefas (`/nova-feature`):**
    Com base no discovery, peça para criar as features iniciais.
5.  **Inicie a Execução (`/proxima-feature`):**
    O agente criará a branch e começará a codar.

---

## 🏗️ Cenário B: Projeto Existente (Adoção)

Use esta trilha para trazer a inteligência do SDD para um codebase que já possui código.

1.  **Inicialize:**
    ```bash
    npx @nathanramorim/forge-sdd@latest init --yes
    ```
2.  **Scan de Codebase (`/constitution`):**
    Peça ao agente para rodar `/constitution`. Ele lerá seus arquivos (`package.json`, `go.mod`, pastas `src/`, etc.) e preencherá automaticamente a **Constituição** e a **Stack** com a realidade do seu projeto.
3.  **Sincronize o Status (`/status`):**
    Verifique como o agente enxerga o projeto.
4.  **Mapeie Próximos Passos (`/nova-feature`):**
    Peça ao agente para analisar o código e sugerir a próxima feature ou correção de dívida técnica.

---

## 💡 Comandos Essenciais

| Comando | Quando usar |
|---------|-------------|
| `/status` | Toda vez que abrir o chat para ver onde parou. |
| `/doctor` | Se sentir que o agente está "perdido" ou esquecendo regras. |
| `/archive` | Quando o chat ficar lento ou o agente avisar que o `progress.md` está grande. |
| `/revisar` | Sempre que o agente terminar de codar, antes de fazer o merge. |

---

## 🛠️ Ciclo de Vida da Sessão

Todo trabalho segue o ciclo **READ-MIN -> PLAN -> ACT -> WRITE -> CLOSE**.
O agente **sempre** lê o `progress.md` primeiro. Nunca pule essa etapa!
