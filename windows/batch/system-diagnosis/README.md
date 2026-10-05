# Diagnostico de inicializacao e eventos / Startup & event diagnosis

> 1 ferramentas • Boot, eventos criticos e historico de falhas. / Boot, critical events and failure history.

| Arquivo / File | Descricao | Admin | Risco / Risk | Desfazer / Undo |
|---|---|---|---|---|
| [BootTimeReport.bat](BootTimeReport.bat) | Ultimos boots, hora da inicializacao e tempo ligado | sim | 🟢 `low` | Somente leitura: nada a desfazer |

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