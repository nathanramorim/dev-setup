# Comando: tutorial

**Uso:** Peça "/tutorial" ou "me ensine o ciclo SDD"

**Ação:**
Guie o usuário por um ciclo completo e fictício do método SDD, sem tocar nos dados reais do projeto:
1. Crie um discovery de exemplo em `sdd/discovery/_tutorial/` (`discovery-demo.md`, `criteria-demo.md`, `plan-demo.md`), usando uma demanda fictícia simples (ex: "adicionar um endpoint de health-check").
2. Quebre esse plano em 1-2 features de exemplo dentro de `sdd/features/_tutorial/`, explicando cada seção enquanto cria.
3. Simule o ciclo `PLAN → ACT → CLOSE` de uma dessas features, narrando o que o Orquestrador, o Builder e o Revisor fariam em cada fase.
4. Ao final, explique a analogia com o ciclo real e deixe claro que os arquivos de exemplo ficam isolados em `sdd/discovery/_tutorial/` e `sdd/features/_tutorial/`.

**Guardrail:** NUNCA escreva ou modifique `sdd/features/index.md`, `sdd/memory/progress.md` ou `sdd/.metrics/` durante o tutorial — este é um ambiente isolado e descartável, criado apenas para ensino.

**Handoff:** Ao concluir, sugira ao usuário rodar `/discovery` com uma demanda real do projeto.
