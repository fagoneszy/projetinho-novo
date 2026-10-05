# Diagnostico de inicializacao e eventos / Startup & event diagnosis

> 25 ferramentas • Boot, eventos criticos e historico de falhas. / Boot, critical events and failure history.

| Arquivo / File | Descricao | Admin | Risco / Risk | Desfazer / Undo |
|---|---|---|---|---|
| [BlueScreenHistory.bat](BlueScreenHistory.bat) | Localiza evidencias de BSOD | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [BootDiagnostic.bat](BootDiagnostic.bat) | Diagnostica problemas de inicializacao | sim | 🟢 `low` | Somente leitura: nada a desfazer |
| [BootTimeReport.bat](BootTimeReport.bat) | Ultimos boots, hora da inicializacao e tempo ligado | sim | 🟢 `low` | Somente leitura: nada a desfazer |
| [CrashHistory.bat](CrashHistory.bat) | Historico de falhas do sistema | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [CriticalEvents.bat](CriticalEvents.bat) | Mostra eventos criticos recentes | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [DiskQueueReport.bat](DiskQueueReport.bat) | Relatorio de fila de disco | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [DiskUsageAnalyzer.bat](DiskUsageAnalyzer.bat) | Analisa uso do armazenamento | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [DriverCrashReport.bat](DriverCrashReport.bat) | Procura indicios de falha de driver | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [DriverSnapshotDiff.bat](DriverSnapshotDiff.bat) | Compara drivers instalados | no | 🟢 `low` | Arquivo temporario na pasta TEMP do usuario (batlab-*.txt) |
| [EmergencyDiagnostics.bat](EmergencyDiagnostics.bat) | Coleta relatorios em um pacote ZIP | sim | 🟡 `medium` | Apague o ZIP gerado na pasta atual |
| [HighCPUDetector.bat](HighCPUDetector.bat) | Detecta CPU em uso anormal | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [HighMemoryDetector.bat](HighMemoryDetector.bat) | Detecta consumo anormal de RAM | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [HungProcessDetector.bat](HungProcessDetector.bat) | Identifica processos travados | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [IOLatencyReport.bat](IOLatencyReport.bat) | Diagnostico de latencia de I/O | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [ProcessSnapshotDiff.bat](ProcessSnapshotDiff.bat) | Compara processos entre momentos | no | 🟢 `low` | Arquivo temporario na pasta TEMP do usuario (batlab-*.txt) |
| [ResourceSnapshot.bat](ResourceSnapshot.bat) | Tira snapshot de CPU/RAM/disco | no | 🟢 `low` | Arquivo temporario na pasta TEMP do usuario (batlab-*.txt) |
| [ServiceDependencyCheck.bat](ServiceDependencyCheck.bat) | Verifica dependencias de servicos | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [ServiceFailureReport.bat](ServiceFailureReport.bat) | Servicos que falharam recentemente | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [ServiceSnapshotDiff.bat](ServiceSnapshotDiff.bat) | Compara servicos entre momentos | no | 🟢 `low` | Arquivo temporario na pasta TEMP do usuario (batlab-*.txt) |
| [ShutdownDiagnostic.bat](ShutdownDiagnostic.bat) | Analisa desligamentos lentos | sim | 🟢 `low` | Somente leitura: nada a desfazer |
| [SystemLoadMonitor.bat](SystemLoadMonitor.bat) | Monitor de carga do sistema | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [SystemSnapshotDiff.bat](SystemSnapshotDiff.bat) | Compara dois snapshots do sistema | no | 🟢 `low` | Arquivo temporario na pasta TEMP do usuario (batlab-*.txt) |
| [UnexpectedShutdowns.bat](UnexpectedShutdowns.bat) | Identifica desligamentos inesperados | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [WindowsErrorReport.bat](WindowsErrorReport.bat) | Coleta erros do Windows Error Reporting | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [WindowsHealthScore.bat](WindowsHealthScore.bat) | Cria um score de saude do Windows | no | 🟢 `low` | Somente leitura: nada a desfazer |

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