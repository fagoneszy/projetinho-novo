# Windows Update / Windows Update

> 1 ferramentas • Status, reparo e manutencao do Windows Update. / Windows Update status, repair and maintenance.

| Arquivo / File | Descricao | Admin | Risco / Risk | Desfazer / Undo |
|---|---|---|---|---|
| [UpdateServiceRepair.bat](UpdateServiceRepair.bat) | Reinicia os servicos do Windows Update para destravar atualizacoes | sim | 🟡 `medium` | Servicos reiniciados: estado volta ao normal em segundos, nada permanente mudou |

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