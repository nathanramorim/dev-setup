Leia `sdd/memory/progress.md` e reporte:
1. Features concluídas na última sessão
2. Feature ativa (status `in-progress`) e tasks pendentes
3. Próxima feature (status `todo`) e suas tasks
4. Bloqueios registrados
5. **Comando sugerido (obrigatório):** encerre sempre com a linha `Próximo comando sugerido: <comando>`, calculada assim:
   - Nenhum discovery em `sdd/discovery/` e nenhuma feature registrada → `/discovery`
   - Discovery presente sem features correspondentes criadas em `sdd/features/` → `/split-features`
   - Existe feature com status `todo` → `/proxima-feature`
   - Todas as features estão `done` → `/archive` ou `/discovery` (novo ciclo)

Formato de saída: tabela markdown + lista de próximos passos + linha final "Próximo comando sugerido".
