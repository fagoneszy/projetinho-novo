# Arquivos e pastas / Files & folders

> 30 ferramentas • Organizar, copiar, comparar e limpar arquivos e pastas. / Organize, copy, compare and clean files and folders.

| Arquivo / File | Descricao | Admin | Risco / Risk | Desfazer / Undo |
|---|---|---|---|---|
| [ArchiveFolder.bat](ArchiveFolder.bat) | Compacta a pasta atual em um arquivo ZIP | no | 🟢 `low` | Apague o arquivo ZIP gerado |
| [BackupFolder.bat](BackupFolder.bat) | Backup simples de uma pasta com robocopy | no | 🟡 `medium` | Apague a pasta de destino do backup |
| [BulkCopy.bat](BulkCopy.bat) | Copia arquivos em massa conforme criterio | no | 🟡 `medium` | Apague os arquivos copiados no destino |
| [BulkMove.bat](BulkMove.bat) | Move arquivos em massa conforme criterio | no | 🟡 `medium` | Mova os arquivos de volta para a pasta de origem |
| [BulkRename.bat](BulkRename.bat) | Renomeia arquivos em massa aplicando um padrao | no | 🟡 `medium` | Renomeie os arquivos de volta para os nomes originais |
| [CleanDownloads.bat](CleanDownloads.bat) | Remove da pasta Downloads arquivos mais antigos que N dias | no | 🔴 `high` | Irreversivel - use /dryrun antes |
| [CompareFolders.bat](CompareFolders.bat) | Compara duas pastas e lista as diferencas | no | 🟢 `low` | N/A (somente listagem) |
| [DuplicateFinder.bat](DuplicateFinder.bat) | Lista arquivos duplicados (mesmo tamanho e conteudo) | no | 🟢 `low` | N/A (somente listagem) |
| [EmptyFolder.bat](EmptyFolder.bat) | Esvazia o conteudo da pasta atual | no | 🔴 `high` | Irreversivel - use /dryrun antes |
| [EmptyFolders.bat](EmptyFolders.bat) | Lista pastas vazias | no | 🟢 `low` | N/A (somente listagem) |
| [ExportFileList.bat](ExportFileList.bat) | Exporta a lista de arquivos para TXT | no | 🟢 `low` | Apague o arquivo TXT gerado |
| [ExportFileListCSV.bat](ExportFileListCSV.bat) | Exporta nome;tamanho;data para CSV | no | 🟢 `low` | Apague o arquivo CSV gerado |
| [ExtensionReport.bat](ExtensionReport.bat) | Relatorio: quantidade e tamanho por extensao | no | 🟢 `low` | N/A (somente listagem) |
| [FileCounter.bat](FileCounter.bat) | Conta arquivos e pastas da pasta atual | no | 🟢 `low` | N/A (somente contagem) |
| [FolderSize.bat](FolderSize.bat) | Calcula o tamanho total da pasta atual | no | 🟢 `low` | N/A (somente calculo) |
| [FolderTree.bat](FolderTree.bat) | Gera a arvore de diretorios | no | 🟢 `low` | N/A (somente listagem) |
| [LargeFiles.bat](LargeFiles.bat) | Lista arquivos maiores que N MB (padrao 100) | no | 🟢 `low` | N/A (somente listagem) |
| [MergeFolders.bat](MergeFolders.bat) | Mescla o conteudo de duas pastas | no | 🟡 `medium` | Mova os arquivos copiados de volta para a pasta de origem |
| [MirrorFolder.bat](MirrorFolder.bat) | Espelha uma pasta apagando no destino o que nao existe na origem (robocopy /MIR) | no | 🔴 `high` | Irreversivel para os arquivos apagados no destino - use /dryrun antes |
| [OldFiles.bat](OldFiles.bat) | Lista arquivos mais antigos que N dias (padrao 365) | no | 🟢 `low` | N/A (somente listagem) |
| [RestoreBackup.bat](RestoreBackup.bat) | Restaura um backup para a pasta de origem | no | 🔴 `high` | A substituicao nao tem desfazer - use /dryrun antes |
| [SmartBackup.bat](SmartBackup.bat) | Backup incremental com robocopy (nao reprocessa iguais) | no | 🟡 `medium` | Apague a pasta de destino do backup incremental |
| [SortByDate.bat](SortByDate.bat) | Organiza os arquivos em pastas por ano e mes | no | 🟡 `medium` | Mova os arquivos das pastas Ano\Mes de volta para a pasta raiz |
| [SortByExtension.bat](SortByExtension.bat) | Organiza os arquivos em pastas por extensao | no | 🟡 `medium` | Mova os arquivos das subpastas de volta para a pasta raiz |
| [SortBySize.bat](SortBySize.bat) | Separa os arquivos por faixa de tamanho | no | 🟡 `medium` | Mova os arquivos das pastas de faixa de volta para a pasta raiz |
| [SortDocuments.bat](SortDocuments.bat) | Separa os documentos em uma pasta Documentos | no | 🟡 `medium` | Mova os arquivos da pasta Documentos de volta |
| [SortDownloads.bat](SortDownloads.bat) | Organiza a pasta Downloads por tipo de arquivo | no | 🟡 `medium` | Mova os arquivos das subpastas de volta para Downloads |
| [SortImages.bat](SortImages.bat) | Separa as imagens em uma pasta Imagens | no | 🟡 `medium` | Mova os arquivos da pasta Imagens de volta |
| [SortMusic.bat](SortMusic.bat) | Separa as musicas em uma pasta Musicas | no | 🟡 `medium` | Mova os arquivos da pasta Musicas de volta |
| [SortVideos.bat](SortVideos.bat) | Separa os videos em uma pasta Videos | no | 🟡 `medium` | Mova os arquivos da pasta Videos de volta |

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