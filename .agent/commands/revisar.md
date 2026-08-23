Revise o código produzido na feature atual (`sdd/features/feat-XX.md` com status `in-progress`):

1. Leia o critério de conclusão da feature
2. Execute os comandos do critério e verifique se Exit 0
3. Verifique: cobertura de testes, tratamento de erros, segurança (OWASP Top 10)
4. Reporte aprovação ou lista de problemas a corrigir
5. **Gravação de Métricas:** Se a telemetria estiver habilitada em `sdd/.sddrc`, execute `forge-sdd session record --feature "<feature ativa>" --outcome approved|rejected --criterio-atendido=true|false` — garante telemetria mesmo quando a sessão não chega a `/proxima-feature`.

Não modifique código — apenas reporte.
