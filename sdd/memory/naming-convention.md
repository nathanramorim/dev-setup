# Convenção de Nomenclatura — dev-setup

Lógica única, referenciada por `/discovery`, `/nova-feature` e `/novo-fix` (nos três agentes) para nomear IDs de discovery/feature/fix — evita a mesma regra duplicada em 9+ prompts.

1. Leia a configuração `naming_convention` em `sdd/.sddrc`.
2. Se `naming_convention` for `workitem`, **pergunte obrigatoriamente ao usuário** qual é o ID do Workitem a usar (ex: prefixo `1024` gerando `feat-1024-<nome>.md`, `discovery-1024-<nome>.md` ou `fix-1024-<nome>.md`).
3. Se `naming_convention` for `hash`, gere um hash de 4 dígitos hexadecimais únicos (ex: `5ae2`).
4. Se `naming_convention` for `sequencial` ou ausente, use o próximo número sequencial (XX) incremental com base no histórico de arquivos em `sdd/features/` ou `sdd/discovery/`.
