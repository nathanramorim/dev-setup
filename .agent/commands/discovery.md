# Comando: discovery

**Uso:** Peça "/discovery <descrição da demanda>"

**Ação:**
Assuma o papel de **Analista de Produto Sênior** e **Engenheiro de Software Sênior**.

1. **Discovery de Produto:** Identifique o "porquê", o "para quem" e o "como" macro.
2. **Discovery Técnico:** Identifique restrições, integridade e critérios de aceitação. Utilize o **C4 Model (Mermaid)** para visualizar a solução técnica.

**Nomenclatura e ID do Discovery:** Siga a lógica única descrita em `sdd/memory/naming-convention.md` (aplicada ao prefixo `discovery-`).

**Entrega:**
Gere três arquivos em `sdd/discovery/`:
- `discovery-ID-<nome>.md`: Visão Produto/Negócio.
- `criteria-ID-<nome>.md`: Visão Técnica/Engenharia.
- `plan-ID-<nome>.md`: Roadmap preliminar e estimativa de quebra de tarefas/features.

Mantenha o padrão Forge-SDD de escrita limpa e objetiva.

Verifique `Nível de Linguagem` em `sdd/memory/constitution.md`: se `iniciante`, explique conceitos como "C4 Model" ou "critério de aceitação" com exemplos concretos e linguagem simples, sem alterar os critérios de aceitação em si.

**Handoff:** Gere um resumo para o próximo passo (`/split-features`), listando os arquivos criados e instruindo a quebrar as features geradas organizando-as dentro de uma subpasta de feature com o nome deste discovery (`sdd/features/feat-ID-<nome-do-discovery>/`).
