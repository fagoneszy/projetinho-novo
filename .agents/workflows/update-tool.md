# Workflow: atualizar ferramenta

1. **Versão** — bump de `version` no cabeçalho (`:: BATLAB | X.bat | v1.1.0`):
   - patch: correção de bug/comando;
   - minor: nova função compatível;
   - major: muda comportamento/saída (quebra scripts que consomem a saída).
2. **Campos de segurança** — se a mudança mexe em risco/admin/enum, atualizar o
   cabeçalho **e** o registro no banco (mesmos valores!). Reavaliar contra
   `docs/RISCOS.md` (media+ = 7 campos completos; critical = confirmação digitada).
3. **Validar + build** — mesma bateria do add-tool (parse, build-manifest exit 0,
   build-readmes, build-problems se slugs mudaram).
4. **Seed** — `npm run seed` atualiza `current_version`/`updated_at`.
5. **Release** — publicar o asset novo (patch/minor conforme o bump):
   `workflows/release-tool.md`; `releases` ganha linha nova; `scripts.current_version`
   passa a apontar para ela.
6. **Diff mínimo** — não reformatar o arquivo inteiro; não mexer em outras ferramentas
   no mesmo commit sem motivo (dificulta revisão de risco).
7. **Commit** — `BATLAB app: …` (se for código do app) ou incluir no lote de ferramentas
   correspondente.

Regressão de segurança: qualquer mudança que **aumente** risco (ex.: passa a apagar
arquivos) precisa de revisão humana antes do commit — o agente não auto-aprova.
