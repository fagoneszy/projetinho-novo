# Auditoria e postura de seguranca / Security audit & posture

> 29 ferramentas • Firewall, contas, logs, BitLocker, TPM e postura. / Firewall, accounts, logs, BitLocker, TPM and posture.

| Arquivo / File | Descricao | Admin | Risco / Risk | Desfazer / Undo |
|---|---|---|---|---|
| [AccountLockoutReport.bat](AccountLockoutReport.bat) | Relatorio de bloqueios de conta por politica de lockout | sim | 🟡 `medium` | Nenhuma alteração é feita |
| [AntivirusInventory.bat](AntivirusInventory.bat) | Inventario de antivirus e provedores de seguranca instalados | no | 🟢 `low` | Nenhuma alteração é feita |
| [AuditPolicyReport.bat](AuditPolicyReport.bat) | Relatorio das politicas de auditoria configuradas no sistema | sim | 🟡 `medium` | Nenhuma alteração é feita |
| [BitLockerStatus.bat](BitLockerStatus.bat) | Status do BitLocker em volumes e discos | sim | 🟢 `low` | Nenhuma alteração é feita |
| [DefenderPreferenceAudit.bat](DefenderPreferenceAudit.bat) | Auditoria das preferencias e configuracoes do Windows Defender | sim | 🟡 `medium` | Nenhuma alteração é feita |
| [DeviceEncryptionStatus.bat](DeviceEncryptionStatus.bat) | Status da criptografia de dispositivo e requisitos | sim | 🟢 `low` | Nenhuma alteração é feita |
| [FailedLoginReport.bat](FailedLoginReport.bat) | Relatorio de tentativas de login com falha | sim | 🟡 `medium` | Nenhuma alteração é feita |
| [FirewallAudit.bat](FirewallAudit.bat) | Auditoria das regras e estado do Firewall do Windows | sim | 🟡 `medium` | Nenhuma alteração é feita |
| [FirewallChangeReport.bat](FirewallChangeReport.bat) | Mostra mudancas recentes nas regras do Firewall | sim | 🟡 `medium` | Nenhuma alteração é feita |
| [GuestAccountAudit.bat](GuestAccountAudit.bat) | Auditoria da conta Convidado e contas de convidado | sim | 🟡 `medium` | Nenhuma alteração é feita |
| [InactiveAccountsReport.bat](InactiveAccountsReport.bat) | Lista contas locais inativas por ultimo login | sim | 🟡 `medium` | Nenhuma alteração é feita |
| [LocalAdminAudit.bat](LocalAdminAudit.bat) | Auditoria de usuarios no grupo Administradores locais | sim | 🟡 `medium` | Nenhuma alteração é feita |
| [PasswordPolicyReport.bat](PasswordPolicyReport.bat) | Relatorio de politica de senhas do dominio/local | sim | 🟡 `medium` | Nenhuma alteração é feita |
| [RecentLoginReport.bat](RecentLoginReport.bat) | Logins recentes em contas locais | sim | 🟡 `medium` | Nenhuma alteração é feita |
| [SecureBootStatus.bat](SecureBootStatus.bat) | Status do Secure Boot na UEFI | sim | 🟢 `low` | Nenhuma alteração é feita |
| [SecurityBaselineReport.bat](SecurityBaselineReport.bat) | Verifica baseline de seguranca do sistema | sim | 🟡 `medium` | Nenhuma alteração é feita |
| [SecurityLogSummary.bat](SecurityLogSummary.bat) | Resumo dos logs de seguranca do Event Viewer | sim | 🟡 `medium` | Nenhuma alteração é feita |
| [SecurityPostureReport.bat](SecurityPostureReport.bat) | Postura geral de seguranca do sistema | sim | 🟡 `medium` | Nenhuma alteração é feita |
| [SecurityProviderInventory.bat](SecurityProviderInventory.bat) | Inventario de provedores de seguranca instalados | no | 🟢 `low` | Nenhuma alteração é feita |
| [SecuritySnapshot.bat](SecuritySnapshot.bat) | Snapshot da configuracao de seguranca atual | sim | 🟡 `medium` | Nenhuma alteração é feita |
| [SuspiciousScheduledTasks.bat](SuspiciousScheduledTasks.bat) | Tarefas agendadas com caracteristicas suspeitas | sim | 🟡 `medium` | Nenhuma alteração é feita |
| [SuspiciousServices.bat](SuspiciousServices.bat) | Servicos com configuracoes incomuns ou suspeitos | sim | 🟡 `medium` | Nenhuma alteração é feita |
| [SuspiciousStartupReport.bat](SuspiciousStartupReport.bat) | Itens de inicializacao suspeitos ou nao reconhecidos | sim | 🟡 `medium` | Nenhuma alteração é feita |
| [TPMStatus.bat](TPMStatus.bat) | Status do TPM e prontidao para uso | sim | 🟢 `low` | Nenhuma alteração é feita |
| [UACStatusReport.bat](UACStatusReport.bat) | Status e nivel do Controle de Conta de Usuario | sim | 🟢 `low` | Nenhuma alteração é feita |
| [UnsignedDriverReport.bat](UnsignedDriverReport.bat) | Drivers sem assinatura digital instalados | sim | 🟡 `medium` | Nenhuma alteração é feita |
| [UnsignedExecutableReport.bat](UnsignedExecutableReport.bat) | Executaveis sem assinatura em pastas criticas | sim | 🟡 `medium` | Nenhuma alteração é feita |
| [UnusualListeningPorts.bat](UnusualListeningPorts.bat) | Portas em escuta com processos incomuns | no | 🟡 `medium` | Nenhuma alteração é feita |
| [UnusualOutboundConnections.bat](UnusualOutboundConnections.bat) | Conexoes de saida para processos e portas incomuns | sim | 🟡 `medium` | Nenhuma alteração é feita |

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