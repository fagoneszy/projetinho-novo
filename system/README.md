# Sistema e manutencao / System & maintenance

> 30 ferramentas • Informacao, caches, discos e ferramentas do Windows. / Info, caches, disks and Windows tools.

| Arquivo / File | Descricao | Admin | Risco / Risk | Desfazer / Undo |
|---|---|---|---|---|
| [AdminCheck.bat](AdminCheck.bat) | Verifica se o script esta rodando como administrador | no | 🟢 `low` | N/A (somente leitura) |
| [BatteryInfo.bat](BatteryInfo.bat) | Status e carga da bateria | no | 🟢 `low` | N/A (somente leitura) |
| [CheckDisk.bat](CheckDisk.bat) | Verifica integridade do disco (chkdsk /f) | sim | 🟡 `medium` | N/A - as correcoes do chkdsk nao tem desfazer; faca backup antes |
| [ClearDNSCache.bat](ClearDNSCache.bat) | Limpa o cache de DNS | no | 🟢 `low` | N/A - o cache DNS e reconstruido nas proximas consultas |
| [ClearTemp.bat](ClearTemp.bat) | Limpa os arquivos temporarios do usuario e do Windows | no | 🟡 `medium` | N/A - arquivos temporarios sao recriados pelo Windows |
| [ClearThumbnailCache.bat](ClearThumbnailCache.bat) | Limpa o cache de miniaturas do Explorer | no | 🟡 `medium` | N/A - o cache de miniaturas e recriado automaticamente |
| [ClearWindowsCache.bat](ClearWindowsCache.bat) | Limpa caches do Windows (prefetch e similares) | sim | 🟡 `medium` | N/A - os caches serao recriados pelo Windows |
| [CPUInfo.bat](CPUInfo.bat) | Processador: modelo, nucleos e frequencia | no | 🟢 `low` | N/A (somente leitura) |
| [DiskInfo.bat](DiskInfo.bat) | Informacoes dos discos fisicos | no | 🟢 `low` | N/A (somente leitura) |
| [DiskSpace.bat](DiskSpace.bat) | Espaco total e livre por unidade | no | 🟢 `low` | N/A (somente leitura) |
| [DriverList.bat](DriverList.bat) | Lista os drivers instalados | no | 🟢 `low` | N/A (somente leitura) |
| [EnvironmentVariables.bat](EnvironmentVariables.bat) | Mostra todas as variaves de ambiente | no | 🟢 `low` | N/A (somente leitura) |
| [EventLogExport.bat](EventLogExport.bat) | Exporta os logs de eventos do sistema para arquivo | sim | 🟢 `low` | Apague o arquivo .evtx exportado |
| [GPUInfo.bat](GPUInfo.bat) | Placas de video instaladas | no | 🟢 `low` | N/A (somente leitura) |
| [HardwareInfo.bat](HardwareInfo.bat) | Hardware: placas, modulos e perifericos | no | 🟢 `low` | N/A (somente leitura) |
| [KillProcess.bat](KillProcess.bat) | Lista processos e encerra o escolhido | no | 🟡 `medium` | Abra o programa novamente pelo Menu Iniciar ou atalho |
| [MemoryInfo.bat](MemoryInfo.bat) | Modulos de memoria e total de RAM | no | 🟢 `low` | N/A (somente leitura) |
| [PathBackup.bat](PathBackup.bat) | Salva o PATH atual em um arquivo de backup | no | 🟢 `low` | Apague o arquivo de backup do PATH gerado |
| [PathRestore.bat](PathRestore.bat) | Restaura o PATH a partir de um arquivo de backup | sim | 🟡 `medium` | Restaure o PATH de outro arquivo de backup com PathBackup |
| [PathViewer.bat](PathViewer.bat) | Mostra o PATH do sistema formatado, uma pasta por linha | no | 🟢 `low` | N/A (somente leitura) |
| [RepairSystemFiles.bat](RepairSystemFiles.bat) | Verifica e repara arquivos do sistema (sfc /scannow) | sim | 🟡 `medium` | N/A - o sfc restaura arquivos a partir do proprio Windows |
| [RestartComputer.bat](RestartComputer.bat) | Reinicia o computador apos N segundos (padrao 60, cancelavel com /a) | no | 🟡 `medium` | Cancele com shutdown /a antes do reinicio |
| [RestartExplorer.bat](RestartExplorer.bat) | Reinicia o Explorer do Windows | no | 🟢 `low` | N/A (o Explorer e recriado pelo proprio Windows) |
| [RunningProcesses.bat](RunningProcesses.bat) | Processos ativos com uso de memoria | no | 🟢 `low` | N/A (somente leitura) |
| [StartupApps.bat](StartupApps.bat) | Programas que iniciam com o Windows | no | 🟢 `low` | N/A (somente leitura) |
| [SystemInfo.bat](SystemInfo.bat) | Informacoes completas do computador | no | 🟢 `low` | N/A (somente leitura) |
| [SystemReport.bat](SystemReport.bat) | Gera um relatorio completo do sistema em TXT | no | 🟢 `low` | Apague o arquivo TXT do relatorio |
| [WindowsUpdateCheck.bat](WindowsUpdateCheck.bat) | Forca a busca de atualizacoes do Windows | sim | 🟢 `low` | N/A - apenas dispara uma busca de atualizacoes |
| [WindowsUpdateTools.bat](WindowsUpdateTools.bat) | Menu de manutencao do Windows Update (buscar/baixar/instalar/reiniciar) | sim | 🟡 `medium` | N/A - acoes do Windows Update sao gerenciadas pelo proprio Windows |
| [WindowsVersion.bat](WindowsVersion.bat) | Versao, edicao e build do Windows | no | 🟢 `low` | N/A (somente leitura) |

## Legenda / Legend

* **Admin** — `sim`: rode como Administrador / run as Administrator.
* **Risco / Risk** — 🟢 `low`: somente leitura / read-only. 🟡 `medium`:
  modifica algo e pede confirmacao / changes something and asks first.
  🔴 `high`: exclui ou altera o sistema com confirmacao dupla / destructive,
  double confirmation.
* **Desfazer / Undo** — como reverter / how to revert.

Veja tambem / see also: [RISCOS.md](../../docs/RISCOS.md) •
[TEMPLATE.md](../../docs/TEMPLATE.md) • [indice geral](../../README.md)