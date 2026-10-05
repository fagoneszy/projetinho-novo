# Automacao / Automation & tasks

> 30 ferramentas • Backups, tarefas agendadas e monitores automaticos. / Backups, scheduled tasks and automatic monitors.

| Arquivo / File | Descricao | Admin | Risco / Risk | Desfazer / Undo |
|---|---|---|---|---|
| [AutoArchive.bat](AutoArchive.bat) | Compacta em ZIP e remove arquivos antigos da pasta | no | 🟡 `medium` | Extraia os arquivos do ZIP Arquivo_AAAA-MM-DD.zip |
| [AutoBackup.bat](AutoBackup.bat) | Menu de backups simples com robocopy | no | 🟡 `medium` | Apague ou mova o destino para desfazer |
| [AutoCleanup.bat](AutoCleanup.bat) | Remove do %TEMP% os arquivos com mais de N dias | no | 🟡 `medium` | Irreversivel - arquivos de temp raramente sao necessarios |
| [AutoDownloadOrganizer.bat](AutoDownloadOrganizer.bat) | Organiza a pasta Downloads em subpastas, repetindo | no | 🟡 `medium` | Mova os arquivos de volta de Downloads |
| [AutoGitBackup.bat](AutoGitBackup.bat) | Tarefa diaria que faz commit e push de um repositorio | sim | 🟡 `medium` | schtasks /delete /tn BATLAB_GitBackup /f |
| [AutoGitCommit.bat](AutoGitCommit.bat) | Commit periodico automatico de um repositorio | sim | 🟡 `medium` | schtasks /delete /tn BATLAB_GitCommit /f |
| [AutoLogGenerator.bat](AutoLogGenerator.bat) | Registra linhas de log com data/hora em arquivo | no | 🟢 `low` | Apague o arquivo batlab_log.txt |
| [AutomationMenu.bat](AutomationMenu.bat) | Menu com os utilitarios de automatizacao | no | 🟢 `low` | N/A |
| [AutoNetworkMonitor.bat](AutoNetworkMonitor.bat) | Monitora a internet e registra quando cai ou volta | no | 🟢 `low` | N/A |
| [AutoOrganize.bat](AutoOrganize.bat) | Organiza os arquivos da pasta em Imagens, Videos, Documentos e Outros | no | 🟡 `medium` | Mova os arquivos de volta para a raiz |
| [AutoProcessMonitor.bat](AutoProcessMonitor.bat) | Monitora se um processo esta aberto e avisa na mudanca | no | 🟢 `low` | N/A |
| [AutoProjectBackup.bat](AutoProjectBackup.bat) | Backup versionado (pasta por data) de um projeto | sim | 🟡 `medium` | Apague as pastas de backup em DESTINO |
| [AutoReportGenerator.bat](AutoReportGenerator.bat) | Gera relatorio de sistema em arquivo de texto | no | 🟢 `low` | Apague o arquivo Relatorio_*.txt |
| [AutoStartupManager.bat](AutoStartupManager.bat) | Lista e remove itens da inicializacao do Windows | sim | 🟡 `medium` | Rode novamente e readicione o valor do registro |
| [AutoSystemReport.bat](AutoSystemReport.bat) | Tarefa diaria que salva relatorio de sistema em log | sim | 🟡 `medium` | schtasks /delete /tn BATLAB_SystemReport /f |
| [AutoWebsiteMonitor.bat](AutoWebsiteMonitor.bat) | Monitora se um site esta no ar e registra mudancas | no | 🟢 `low` | N/A |
| [DailyTaskCreator.bat](DailyTaskCreator.bat) | Assistente para criar uma tarefa diaria no Agendador | sim | 🟡 `medium` | schtasks /delete /tn NOME /f |
| [FileWatcher.bat](FileWatcher.bat) | Monitora um arquivo e avisa quando ele muda | no | 🟢 `low` | N/A |
| [FolderWatcher.bat](FolderWatcher.bat) | Monitora uma pasta e avisa quando arquivos mudam | no | 🟢 `low` | N/A |
| [ScheduledBackup.bat](ScheduledBackup.bat) | Cria tarefa agendada diaria de backup (schtasks) | sim | 🟡 `medium` | schtasks /delete /tn BATLAB_Backup /f |
| [ScheduledCleanup.bat](ScheduledCleanup.bat) | Cria tarefa agendada semanal de limpeza de temporarios | sim | 🟡 `medium` | schtasks /delete /tn BATLAB_Cleanup /f |
| [ScheduledProgram.bat](ScheduledProgram.bat) | Agenda qualquer programa para rodar todo dia | sim | 🟡 `medium` | schtasks /delete /tn BATLAB_Programa /f |
| [ScheduledRestart.bat](ScheduledRestart.bat) | Agenda a reinicializacao do PC em N minutos | no | 🟡 `medium` | shutdown /a |
| [ScheduledShutdown.bat](ScheduledShutdown.bat) | Agenda o desligamento do PC em N minutos | no | 🟡 `medium` | shutdown /a |
| [TaskDelete.bat](TaskDelete.bat) | Exclui uma tarefa agendada | sim | 🔴 `high` | Recrie a tarefa via TaskManager.bat ou DailyTaskCreator.bat |
| [TaskDisable.bat](TaskDisable.bat) | Desativa uma tarefa agendada | sim | 🟡 `medium` | schtasks /change /enable para reativar |
| [TaskEnable.bat](TaskEnable.bat) | Ativa uma tarefa agendada | sim | 🟡 `medium` | schtasks /change /disable para desativar |
| [TaskList.bat](TaskList.bat) | Lista as tarefas agendadas do Windows | no | 🟢 `low` | N/A |
| [TaskManager.bat](TaskManager.bat) | Hub para listar, ativar, desativar e excluir tarefas | sim | 🟡 `medium` | schtasks /delete /f para excluir |
| [WeeklyTaskCreator.bat](WeeklyTaskCreator.bat) | Assistente para criar uma tarefa semanal no Agendador | sim | 🟡 `medium` | schtasks /delete /tn NOME /f |

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