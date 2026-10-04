# Customizacao / Customization

> 25 ferramentas • Aparencia, opcoes do Explorer e atalhos de sistema. / Appearance, Explorer options and system shortcuts.

| Arquivo / File | Descricao | Admin | Risco / Risk | Desfazer / Undo |
|---|---|---|---|---|
| [CreateDesktopShortcut.bat](CreateDesktopShortcut.bat) | Cria um atalho na area de trabalho (arg: caminho do alvo) | no | 🟢 `low` | Exclua o arquivo .lnk criado na area de trabalho |
| [CreateStartMenuShortcut.bat](CreateStartMenuShortcut.bat) | Cria um atalho no Menu Iniciar (arg: caminho do alvo) | no | 🟢 `low` | Exclua o arquivo .lnk criado na pasta Programs do Menu Iniciar |
| [DarkMode.bat](DarkMode.bat) | Ativa o tema escuro do Windows | no | 🟡 `medium` | Execute LightMode.bat (AppsUseLightTheme=1 e SystemUsesLightTheme=1) |
| [DesktopRefresh.bat](DesktopRefresh.bat) | Atualiza os icones da area de trabalho | no | 🟢 `low` | N/A |
| [DisableDeveloperMode.bat](DisableDeveloperMode.bat) | Desativa o Modo de Desenvolvedor | sim | 🟡 `medium` | Execute EnableDeveloperMode.bat (AllowDevelopmentWithoutDevLicense=1) |
| [EnableDeveloperMode.bat](EnableDeveloperMode.bat) | Ativa o Modo de Desenvolvedor do Windows | sim | 🟡 `medium` | Execute DisableDeveloperMode.bat (AllowDevelopmentWithoutDevLicense=0) |
| [HideFileExtensions.bat](HideFileExtensions.bat) | Oculta as extensoes de arquivo | no | 🟡 `medium` | Execute ShowFileExtensions.bat (valor HideFileExt=0) |
| [HideHiddenFiles.bat](HideHiddenFiles.bat) | Oculta arquivos ocultos no Explorer | no | 🟡 `medium` | Execute ShowHiddenFiles.bat (valor Hidden=1) |
| [LightMode.bat](LightMode.bat) | Ativa o tema claro do Windows | no | 🟡 `medium` | Execute DarkMode.bat (AppsUseLightTheme=0 e SystemUsesLightTheme=0) |
| [OpenAppData.bat](OpenAppData.bat) | Abre a pasta AppData | no | 🟢 `low` | N/A |
| [OpenControlPanel.bat](OpenControlPanel.bat) | Abre o Painel de Controle | no | 🟢 `low` | N/A |
| [OpenDeviceManager.bat](OpenDeviceManager.bat) | Abre o Gerenciador de Dispositivos | no | 🟢 `low` | N/A |
| [OpenEnvironmentSettings.bat](OpenEnvironmentSettings.bat) | Abre as configuracoes de variaveis de ambiente | no | 🟢 `low` | N/A |
| [OpenHostsFile.bat](OpenHostsFile.bat) | Abre o arquivo hosts no Bloco de Notas como administrador | sim | 🟡 `medium` | Feche o Bloco de Notas sem salvar ou restaure o backup manual do arquivo hosts |
| [OpenServices.bat](OpenServices.bat) | Abre o console de Servicos | no | 🟢 `low` | N/A |
| [OpenSettings.bat](OpenSettings.bat) | Abre as Configuracoes do Windows | no | 🟢 `low` | N/A |
| [OpenStartupFolder.bat](OpenStartupFolder.bat) | Abre a pasta de inicializacao (shell:startup) | no | 🟢 `low` | N/A |
| [OpenSystem32.bat](OpenSystem32.bat) | Abre a pasta System32 | no | 🟢 `low` | N/A |
| [OpenTaskScheduler.bat](OpenTaskScheduler.bat) | Abre o Agendador de Tarefas | no | 🟢 `low` | N/A |
| [OpenTemp.bat](OpenTemp.bat) | Abre a pasta de temporarios | no | 🟢 `low` | N/A |
| [OpenWindowsFolder.bat](OpenWindowsFolder.bat) | Abre a pasta do Windows | no | 🟢 `low` | N/A |
| [RestartPrintSpooler.bat](RestartPrintSpooler.bat) | Reinicia o servico de impressao (spooler) | sim | 🟡 `medium` | Execute net start spooler ou reinicie o servico Spooler pelo console Services.msc |
| [ShowFileExtensions.bat](ShowFileExtensions.bat) | Mostra as extensoes de arquivo | no | 🟡 `medium` | Execute HideFileExtensions.bat (valor HideFileExt=1) |
| [ShowHiddenFiles.bat](ShowHiddenFiles.bat) | Mostra arquivos ocultos no Explorer | no | 🟡 `medium` | Execute HideHiddenFiles.bat (valor Hidden=2) |
| [ToggleDarkMode.bat](ToggleDarkMode.bat) | Alterna entre tema escuro e claro | no | 🟡 `medium` | Execute DarkMode.bat ou LightMode.bat conforme o tema desejado |

## Legenda / Legend

* **Admin** — `sim`: rode como Administrador / run as Administrator.
* **Risco / Risk** — 🟢 `low`: somente leitura / read-only. 🟡 `medium`:
  modifica algo e pede confirmacao / changes something and asks first.
  🔴 `high`: exclui ou altera o sistema com confirmacao dupla / destructive,
  double confirmation.
* **Desfazer / Undo** — como reverter / how to revert.

Veja tambem / see also: [RISCOS.md](../../docs/RISCOS.md) •
[TEMPLATE.md](../../docs/TEMPLATE.md) • [indice geral](../../README.md)