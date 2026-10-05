# Acoes de emergencia / Emergency actions

> 1 ferramentas • Relatorios rapidos quando algo quebrou. / Quick reports when something broke.

| Arquivo / File | Descricao | Admin | Risco / Risk | Desfazer / Undo |
|---|---|---|---|---|
| [EmergencyDiskReport.bat](EmergencyDiskReport.bat) | Emergencia: espaco livre dos discos e maiores arquivos da pasta | no | 🟢 `low` | Somente leitura: nada a desfazer |

## Legenda / Legend

* **Admin** — `sim`: rode como Administrador / run as Administrator.
* **Risco / Risk** — 🟢 `low`: somente leitura / read-only. 🟡 `medium`:
  modifica algo e pede confirmacao / changes something and asks first.
  🔴 `high`: exclui ou altera o sistema com confirmacao dupla / destructive,
  double confirmation. ⚫ `critical`: exige digitar a confirmacao /
  requires typed confirmation.
* **Desfazer / Undo** — como reverter / how to revert.

Veja tambem / see also: [RISCOS.md](../../docs/RISCOS.md) •
[TEMPLATE.md](../../docs/TEMPLATE.md) • [indice geral](../../README.md)