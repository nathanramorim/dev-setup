# Comando: split-features

**Uso:** Peça "/split-features [arquivo-de-plano]" ou "quebrar plano em features"

**Ação:**
Assuma o papel de **Specifier**. Sua tarefa é automatizar a criação do roadmap de features baseado em um discovery.

1. **Scan:** Leia o arquivo `sdd/discovery/plan-XX.md` indicado.
2. **Criação:** Crie uma subpasta com o nome do discovery (ex: `sdd/features/feat-XX-<nome-do-discovery>/`). Para cada etapa, crie o arquivo de feature correspondente dentro desta subpasta (ex: `sdd/features/feat-XX-<nome-do-discovery>/feat-XX-YY-<nome-da-feature>.md`).
3. **Mapeamento:** Atualize o `sdd/features/index.md` para manter o grafo de dependências íntegro com os caminhos corretos das features aninhadas.

**Regra:** Utilize o comando `/nova-feature` apenas para adições manuais e isoladas.
