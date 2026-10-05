# Seguranca e diagnostico / Security & diagnostics

> 20 ferramentas • Auditoria de seguranca, portas, eventos e programas. / Security audit, ports, events and installed programs.

| Arquivo / File | Descricao | Admin | Risco / Risk | Desfazer / Undo |
|---|---|---|---|---|
| [ActiveSessions.bat](ActiveSessions.bat) | Sessoes ativas (qwinsta) | no | 🟢 `low` | N/A |
| [AdminUsers.bat](AdminUsers.bat) | Membros do grupo administradores (net localgroup administrators) | no | 🟢 `low` | N/A |
| [DiskHealthReport.bat](DiskHealthReport.bat) | Status e SMART dos discos (Get-PhysicalDisk / Win32_DiskDrive) | no | 🟢 `low` | N/A |
| [FirewallRules.bat](FirewallRules.bat) | Exporta as regras do firewall (netsh advfirewall export) | sim | 🟢 `low` | netsh advfirewall import <arquivo exportado> |
| [FirewallStatus.bat](FirewallStatus.bat) | Estado do firewall por perfil (netsh advfirewall show allprofiles) | no | 🟢 `low` | N/A |
| [FullDiagnostic.bat](FullDiagnostic.bat) | Bateria de verificacoes somente-leitura salvas em Relatorios\AAAA-MM-DD | sim | 🟡 `medium` | N/A - somente leitura; apague a pasta Relatorios gerada |
| [InstalledPrograms.bat](InstalledPrograms.bat) | Programas instalados (registro de desinstalar) em TXT e CSV | no | 🟢 `low` | N/A |
| [ListeningPorts.bat](ListeningPorts.bat) | Portas em escuta (netstat -ano -p tcp \| findstr LISTENING) | no | 🟢 `low` | N/A |
| [LoggedUsers.bat](LoggedUsers.bat) | Usuarios logados (query user) | no | 🟢 `low` | N/A |
| [OpenConnections.bat](OpenConnections.bat) | Conexoes abertas (netstat -ano) | no | 🟢 `low` | N/A |
| [ProcessNetworkConnections.bat](ProcessNetworkConnections.bat) | netstat + processo dono (tasklist) | no | 🟢 `low` | N/A |
| [RecentFilesAudit.bat](RecentFilesAudit.bat) | Arquivos recentes do usuario (%APPDATA%\Microsoft\Windows\Recent) | no | 🟢 `low` | N/A |
| [RecentlyInstalled.bat](RecentlyInstalled.bat) | Programas instalados recentemente, ordenados por data | no | 🟢 `low` | N/A |
| [ScheduledTaskAudit.bat](ScheduledTaskAudit.bat) | Tarefas agendadas suspeitas ou ocultas (schtasks /query /fo LIST) | sim | 🟢 `low` | N/A |
| [SecurityEventReport.bat](SecurityEventReport.bat) | Eventos de seguranca dos ultimos 7 dias em TXT | sim | 🟢 `low` | N/A |
| [StartupAudit.bat](StartupAudit.bat) | O que inicia com o Windows (reg Run + schtasks) | no | 🟢 `low` | N/A |
| [SystemEventReport.bat](SystemEventReport.bat) | Erros e avisos do log Sistema dos ultimos 7 dias em TXT | no | 🟢 `low` | N/A |
| [SystemHealthReport.bat](SystemHealthReport.bat) | Relatorio de saude consolidado (disco, RAM, uptime, servicos) em TXT | no | 🟢 `low` | N/A |
| [UserAccounts.bat](UserAccounts.bat) | Contas locais (net user) | no | 🟢 `low` | N/A |
| [WindowsDefenderStatus.bat](WindowsDefenderStatus.bat) | Status do Windows Defender (Get-MpComputerStatus) | no | 🟢 `low` | N/A |

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