# Saude e espaco de discos / Disk health & space

> 1 ferramentas • Saude SMART, temperatura e espaco dos discos. / SMART health, temperature and disk space.

| Arquivo / File | Descricao | Admin | Risco / Risk | Desfazer / Undo |
|---|---|---|---|---|
| [DriveHealthCheck.bat](DriveHealthCheck.bat) | Saude dos discos: SMART, tipo, temperatura e espaco livre | no | 🟢 `low` | Somente leitura: nada a desfazer |

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