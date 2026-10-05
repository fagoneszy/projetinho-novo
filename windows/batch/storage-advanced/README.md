# Saude e espaco de discos / Disk health & space

> 23 ferramentas • Saude SMART, temperatura e espaco dos discos. / SMART health, temperature and disk space.

| Arquivo / File | Descricao | Admin | Risco / Risk | Desfazer / Undo |
|---|---|---|---|---|
| [BackupSizeEstimator.bat](BackupSizeEstimator.bat) | Estima o tamanho de um backup | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [BackupVerification.bat](BackupVerification.bat) | Compara backup com a pasta original | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [CacheSizeReport.bat](CacheSizeReport.bat) | Tamanho de caches conhecidos | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [DiskTemperatureReport.bat](DiskTemperatureReport.bat) | Temperatura dos discos | sim | 🟢 `low` | Somente leitura: nada a desfazer |
| [DriveHealthCheck.bat](DriveHealthCheck.bat) | Saude dos discos: SMART, tipo, temperatura e espaco livre | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [DriveLetterManager.bat](DriveLetterManager.bat) | Letras de disco em uso e disponiveis | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [FreeSpaceThreshold.bat](FreeSpaceThreshold.bat) | Verifica espaco livre contra limites | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [HDDHealthReport.bat](HDDHealthReport.bat) | Saude e setores realocados de HDs | sim | 🟢 `low` | Somente leitura: nada a desfazer |
| [LargestFilesByExtension.bat](LargestFilesByExtension.bat) | Maiores arquivos por extensao | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [LargestFolders.bat](LargestFolders.bat) | Maiores pastas da unidade | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [LowDiskSpaceAlert.bat](LowDiskSpaceAlert.bat) | Alerta de volumes com pouco espaco | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [MountPointReport.bat](MountPointReport.bat) | Pontos de montagem e discos | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [PartitionReport.bat](PartitionReport.bat) | Relatorio de particoes do disco | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [RecycleBinAnalyzer.bat](RecycleBinAnalyzer.bat) | Analise do conteudo da lixeira | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [SMARTInfo.bat](SMARTInfo.bat) | Informacoes SMART dos discos | sim | 🟢 `low` | Somente leitura: nada a desfazer |
| [SSDHealthReport.bat](SSDHealthReport.bat) | Saude e desgaste de SSDs | sim | 🟢 `low` | Somente leitura: nada a desfazer |
| [StorageCleanupPreview.bat](StorageCleanupPreview.bat) | Previa do que a limpeza apagaria | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [StorageDeviceInventory.bat](StorageDeviceInventory.bat) | Inventario de dispositivos de armazenamento | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [StorageEmergencyReport.bat](StorageEmergencyReport.bat) | Relatorio de emergencia de armazenamento | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [StorageTrendLogger.bat](StorageTrendLogger.bat) | Registra uso de disco em CSV | no | 🟡 `medium` | Apague o UsoDisco.csv gerado |
| [TemporaryFileAnalyzer.bat](TemporaryFileAnalyzer.bat) | Analisa o tamanho dos temporarios | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [UnusedFiles.bat](UnusedFiles.bat) | Arquivos nao acessados ha muito tempo | no | 🟢 `low` | Somente leitura: nada a desfazer |
| [VolumeReport.bat](VolumeReport.bat) | Relatorio de volumes e espaco | no | 🟢 `low` | Somente leitura: nada a desfazer |

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