# Windows Update / Windows Update

> 25 ferramentas • Status, reparo e manutencao do Windows Update. / Windows Update status, repair and maintenance.

| Arquivo / File | Descricao | Admin | Risco / Risk | Desfazer / Undo |
|---|---|---|---|---|
| [BootConfigurationBackup.bat](BootConfigurationBackup.bat) | Backup da configuracao de inicializacao | sim | 🟡 `medium` | Apague o arquivo de backup (o BCD original nao foi alterado) |
| [BootConfigurationReport.bat](BootConfigurationReport.bat) | Mostra a configuracao de inicializacao | sim | 🟢 `low` | Somente leitura: nada a desfazer |
| [ComponentStoreCheck.bat](ComponentStoreCheck.bat) | Verifica integridade do component store | sim | 🟢 `low` | Somente leitura: nada a desfazer |
| [ComponentStoreReport.bat](ComponentStoreReport.bat) | Saude do component store (WinSxS) | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [FailedUpdateFinder.bat](FailedUpdateFinder.bat) | Localiza atualizacoes que falharam | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [OfflineRepairGuide.bat](OfflineRepairGuide.bat) | Guia de reparo offline passo a passo | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [PendingRestartDetector.bat](PendingRestartDetector.bat) | Detecta reinicio pendente do Windows | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [RecoveryEnvironmentCheck.bat](RecoveryEnvironmentCheck.bat) | Verifica o ambiente de recuperacao (WinRE) | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [RecoveryPartitionInfo.bat](RecoveryPartitionInfo.bat) | Informacoes da particao de recuperacao | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [RecoverySnapshot.bat](RecoverySnapshot.bat) | Exporta configuracoes antes de reparo | no | 🟡 `medium` | Apague o arquivo gerado |
| [RecoveryToolsMenu.bat](RecoveryToolsMenu.bat) | Menu com as ferramentas de recuperacao | no | 🟢 `low` | Abre ferramentas do BATLAB; cada uma tem seu proprio desfazer |
| [RestorePointCreator.bat](RestorePointCreator.bat) | Cria um ponto de restauracao | sim | 🟡 `medium` | Ponto de restauracao criado; remova em Painel > Restauracao do sistema |
| [RestorePointList.bat](RestorePointList.bat) | Lista pontos de restauracao | sim | 🟢 `low` | Somente leitura: nada a desfazer |
| [SafeModeHelper.bat](SafeModeHelper.bat) | Agenda entrada em modo seguro com confirmacao | sim | 🟡 `medium` | bcdedit /deletevalue {current} safeboot (rode a opcao desativar) |
| [SystemImageHealthCheck.bat](SystemImageHealthCheck.bat) | Verifica saude da imagem do sistema | sim | 🟢 `low` | Somente leitura: nada a desfazer |
| [UpdateCacheInspector.bat](UpdateCacheInspector.bat) | Inspeciona a cache do Windows Update | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [UpdateConnectivityTest.bat](UpdateConnectivityTest.bat) | Testa conexao com servidores de atualizacao | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [UpdateErrorCodes.bat](UpdateErrorCodes.bat) | Consulta codigos de erro de atualizacao | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [UpdateHistoryReport.bat](UpdateHistoryReport.bat) | Historico de atualizacoes instaladas | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [UpdateServiceCheck.bat](UpdateServiceCheck.bat) | Status dos servicos do Windows Update | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [UpdateServiceRepair.bat](UpdateServiceRepair.bat) | Reinicia os servicos do Windows Update para destravar atualizacoes | sim | 🟡 `medium` | Servicos reiniciados: estado volta ao normal em segundos, nada permanente mudou |
| [UpdateStorageAnalyzer.bat](UpdateStorageAnalyzer.bat) | Espaco usado pelo Windows Update | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [UpdateTroubleshooter.bat](UpdateTroubleshooter.bat) | Abre o solucionador do Windows Update | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [WindowsRepairBundle.bat](WindowsRepairBundle.bat) | Executa reparos basicos em sequencia | sim | 🔴 `high` | Arquivos substituidos sao restaurados pelo proprio Windows; reinicie ao final |
| [WindowsUpdateLogCollector.bat](WindowsUpdateLogCollector.bat) | Coleta o log do Windows Update | no | 🟢 `low` | Somente leitura: nada a desfazer |

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