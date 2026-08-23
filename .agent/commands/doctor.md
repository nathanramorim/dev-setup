# Comando: doctor

**Uso:** Peça "/doctor" ou "check-up do projeto"

**Ação:**
1. Verifique se os budgets de tokens estão sendo respeitados (`sdd/memory/progress.md` ≤ 1 KB?).
2. Verifique se todos os comandos personalizados do agente existem (adaptadores em `.claude/commands/`, `.gemini/prompts/` ou `.github/prompts/`, conforme o agente) e se `.agent/commands/` correspondente existe para cada um.
3. Verifique se a configuração do agente possui `context7` e `git` configurados (conforme orientações no arquivo de instruções do agente).
4. Verifique se há alguma feature `in-progress` sem branch ativa no git.
5. Verifique se `sdd/.metrics/schema.json` está presente.
6. Verifique se o nome do projeto no `.sddrc` ainda está como o padrão ('meu-projeto'). Se sim, sugira ao usuário renomeá-lo em todos os locais onde ainda estiver como default (ex: no `.sddrc`, nos cabeçalhos dos arquivos de agentes, e no `sdd/memory/progress.md`).
7. Execute `forge-sdd doctor` no terminal e inclua o resumo agregado de telemetria (sessões approved/rejected/blocked) que ele imprime.

Reporte verde ✓ ou vermelho ✗ para cada item. Não execute correções.
