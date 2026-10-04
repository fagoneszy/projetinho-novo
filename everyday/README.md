# Usuarios comuns / Everyday users

> 20 ferramentas • Acoes simples de todo dia para usuarios comuns. / Simple everyday actions for regular users.

| Arquivo / File | Descricao | Admin | Risco / Risk | Desfazer / Undo |
|---|---|---|---|---|
| [EmptyRecycleBin.bat](EmptyRecycleBin.bat) | Esvazia a Lixeira (PowerShell Clear-RecycleBin -Force) | no | 🔴 `high` | Irreversivel - use /dryrun antes |
| [LockComputer.bat](LockComputer.bat) | Trava a estacao (rundll32.exe user32.dll,LockWorkStation) | no | 🟢 `low` | Ctrl+Alt+Del e informe a senha |
| [OpenAppsSettings.bat](OpenAppsSettings.bat) | Abre apps instalados (ms-settings:appsfeatures) | no | 🟢 `low` | N/A - somente abre uma janela |
| [OpenBluetoothSettings.bat](OpenBluetoothSettings.bat) | Abre Bluetooth (ms-settings:bluetooth) | no | 🟢 `low` | N/A - somente abre uma janela |
| [OpenDisplaySettings.bat](OpenDisplaySettings.bat) | Abre tela (desk.cpl) | no | 🟢 `low` | N/A - somente abre uma janela |
| [OpenMouseSettings.bat](OpenMouseSettings.bat) | Abre as configuracoes do mouse (main.cpl) | no | 🟢 `low` | N/A - somente abre uma janela |
| [OpenNetworkSettings.bat](OpenNetworkSettings.bat) | Abre rede nas Configuracoes (ms-settings:network) | no | 🟢 `low` | N/A - somente abre uma janela |
| [OpenPrivacySettings.bat](OpenPrivacySettings.bat) | Abre privacidade (ms-settings:privacy) | no | 🟢 `low` | N/A - somente abre uma janela |
| [OpenRecycleBin.bat](OpenRecycleBin.bat) | Abre a Lixeira (explorer shell:RecycleBinFolder) | no | 🟢 `low` | N/A - somente abre uma janela |
| [OpenSoundSettings.bat](OpenSoundSettings.bat) | Abre som (mmsys.cpl) | no | 🟢 `low` | N/A - somente abre uma janela |
| [OpenStorageSettings.bat](OpenStorageSettings.bat) | Abre armazenamento (ms-settings:storagesense) | no | 🟢 `low` | N/A - somente abre uma janela |
| [OpenTaskManager.bat](OpenTaskManager.bat) | Abre o Gerenciador de Tarefas (taskmgr) | no | 🟢 `low` | N/A - somente abre uma janela |
| [OpenWindowsUpdate.bat](OpenWindowsUpdate.bat) | Abre atualizacao do Windows (ms-settings:windowsupdate) | no | 🟢 `low` | N/A - somente abre uma janela |
| [QuickRestart.bat](QuickRestart.bat) | Reinicia agora (shutdown /r /t 0) | no | 🟡 `medium` | N/A - reinicio imediato, nao reversivel |
| [QuickShutdown.bat](QuickShutdown.bat) | Desliga agora (shutdown /s /t 0) | no | 🟡 `medium` | N/A - desligamento imediato, nao reversivel |
| [RestartTimer.bat](RestartTimer.bat) | Reiniciar o PC em N minutos (shutdown /r /t N) | no | 🟡 `medium` | shutdown /a |
| [ShutdownTimer.bat](ShutdownTimer.bat) | Desligar o PC em N minutos (shutdown /s /t N) | no | 🟡 `medium` | shutdown /a |
| [SignOut.bat](SignOut.bat) | Fecha a sessao (shutdown /l) | no | 🟡 `medium` | Refaca o login com sua senha |
| [SleepTimer.bat](SleepTimer.bat) | Dorme o PC em N minutos (rundll32.exe powrprof.dll,SetSuspendState) | no | 🟡 `medium` | Feche a janela antes do fim da espera; apos dormir acorde com o teclado |
| [WindowsQuickTools.bat](WindowsQuickTools.bat) | Menu estilo Win+X: Tarefas, Dispositivos, Disco, Terminal, Configuracoes | no | 🟢 `low` | N/A - somente abre ferramentas |

## Legenda / Legend

* **Admin** — `sim`: rode como Administrador / run as Administrator.
* **Risco / Risk** — 🟢 `low`: somente leitura / read-only. 🟡 `medium`:
  modifica algo e pede confirmacao / changes something and asks first.
  🔴 `high`: exclui ou altera o sistema com confirmacao dupla / destructive,
  double confirmation.
* **Desfazer / Undo** — como reverter / how to revert.

Veja tambem / see also: [RISCOS.md](../../docs/RISCOS.md) •
[TEMPLATE.md](../../docs/TEMPLATE.md) • [indice geral](../../README.md)