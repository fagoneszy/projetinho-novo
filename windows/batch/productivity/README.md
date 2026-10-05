# Produtividade / Productivity

> 30 ferramentas • Pastas, anotacoes, foco e atalhos do dia a dia de trabalho. / Folders, notes, focus and daily work shortcuts.

| Arquivo / File | Descricao | Admin | Risco / Risk | Desfazer / Undo |
|---|---|---|---|---|
| [BreakReminder.bat](BreakReminder.bat) | Lembrete de pausa periodico (padrao: 20 min) | no | 🟢 `low` | N/A |
| [ClientFolder.bat](ClientFolder.bat) | Cria a estrutura de pastas de um cliente | no | 🟢 `low` | Apague a pasta criada |
| [CopyClipboardToFile.bat](CopyClipboardToFile.bat) | Salva o conteudo da area de transferencia em um arquivo | no | 🟢 `low` | Apague o arquivo Clipboard.txt |
| [Countdown.bat](Countdown.bat) | Contagem regressiva com alerta sonoro no final | no | 🟢 `low` | N/A |
| [DailyFolder.bat](DailyFolder.bat) | Cria a pasta do dia (AAAA-MM-DD) e abre | no | 🟢 `low` | Apague a pasta criada |
| [FocusMode.bat](FocusMode.bat) | Fecha aplicativos de distracao e abre ferramentas de foco | no | 🟡 `medium` | Abra manualmente o que foi fechado |
| [InvoiceFolder.bat](InvoiceFolder.bat) | Cria a estrutura de documentos financeiros do mes | no | 🟢 `low` | Apague a pasta criada |
| [MeetingFolder.bat](MeetingFolder.bat) | Cria a pasta de uma reuniao com Ata, Pauta e Apresentacao | no | 🟢 `low` | Apague a pasta criada |
| [MeetingMode.bat](MeetingMode.bat) | Prepara os aplicativos para uma reuniao | no | 🟢 `low` | N/A |
| [MonthlyFolder.bat](MonthlyFolder.bat) | Cria a estrutura do mes (AAAA-MM com 31 pastas de dias) | no | 🟢 `low` | Apague a pasta criada |
| [NormalizeFileNames.bat](NormalizeFileNames.bat) | Padroniza nomes: minusculas e sem espacos (usa underscore) | no | 🟡 `medium` | Renomeie manualmente para voltar ao original |
| [OpenDailyApps.bat](OpenDailyApps.bat) | Abre os aplicativos diarios listados em daily-apps.txt | no | 🟢 `low` | N/A |
| [OpenLastModified.bat](OpenLastModified.bat) | Abre o arquivo mais recentemente alterado da pasta | no | 🟢 `low` | N/A |
| [OpenMultipleFolders.bat](OpenMultipleFolders.bat) | Abre varias pastas de uma vez (recebe caminhos como argumento) | no | 🟢 `low` | N/A |
| [OpenProject.bat](OpenProject.bat) | Abre a pasta do projeto no Explorer, VS Code e terminal | no | 🟢 `low` | N/A |
| [Pomodoro.bat](Pomodoro.bat) | Temporizador Pomodoro (25 min foco / 5 min pausa, com alerta sonoro) | no | 🟢 `low` | N/A |
| [PresentationMode.bat](PresentationMode.bat) | Prepara o PC para apresentacao (sem sono, tela em 15 min) | sim | 🟡 `medium` | powercfg /change standby-timeout-ac 30 |
| [ProjectStructure.bat](ProjectStructure.bat) | Cria a estrutura basica de um projeto (src, docs, tests) | no | 🟢 `low` | Apague a pasta criada |
| [QuickCalculator.bat](QuickCalculator.bat) | Calculadora rapida pelo terminal (aceita 1+2*3, parenteses e decimais) | no | 🟢 `low` | N/A |
| [QuickNotes.bat](QuickNotes.bat) | Cria uma nota rapida na area de trabalho | no | 🟢 `low` | Apague a linha do arquivo Notas.txt |
| [QuickSearch.bat](QuickSearch.bat) | Pesquisa arquivos por nome na pasta atual | no | 🟢 `low` | N/A |
| [QuickWorkspace.bat](QuickWorkspace.bat) | Abre todos os programas de trabalho de uma vez | no | 🟢 `low` | N/A |
| [RecentFiles.bat](RecentFiles.bat) | Mostra os arquivos modificados nos ultimos N dias | no | 🟢 `low` | N/A |
| [RemoveSpacesFromNames.bat](RemoveSpacesFromNames.bat) | Remove os espacos dos nomes dos arquivos | no | 🟡 `medium` | Renomeie manualmente para voltar ao original |
| [RenameByDate.bat](RenameByDate.bat) | Adiciona a data de modificacao no inicio dos nomes dos arquivos | no | 🟡 `medium` | Remova o prefixo AAAA-MM-DD_ dos nomes |
| [RenameSequentially.bat](RenameSequentially.bat) | Renomeia arquivos em sequencia numerica (001, 002...) | no | 🟡 `medium` | Os nomes originais nao sao restaurados - faca backup antes |
| [StudyMode.bat](StudyMode.bat) | Abre navegador, editor e musica para estudos | no | 🟢 `low` | N/A |
| [TimestampNote.bat](TimestampNote.bat) | Cria uma nota com data e hora no nome do arquivo | no | 🟢 `low` | N/A |
| [WeeklyFolder.bat](WeeklyFolder.bat) | Cria a pasta da semana com subpastas Seg..Dom | no | 🟢 `low` | Apague a pasta criada |
| [WorkMode.bat](WorkMode.bat) | Configura o ambiente de trabalho (pasta + aplicativos) | no | 🟢 `low` | N/A |

## Legenda / Legend

* **Admin** — `sim`: rode como Administrador / run as Administrator.
* **Risco / Risk** — 🟢 `low`: somente leitura / read-only. 🟡 `medium`:
  modifica algo e pede confirmacao / changes something and asks first.
  🔴 `high`: exclui ou altera o sistema com confirmacao dupla / destructive,
  double confirmation.
* **Desfazer / Undo** — como reverter / how to revert.

Veja tambem / see also: [RISCOS.md](../../docs/RISCOS.md) •
[TEMPLATE.md](../../docs/TEMPLATE.md) • [indice geral](../../README.md)