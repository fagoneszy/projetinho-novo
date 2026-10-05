# Rede e Internet / Network & Internet

> 30 ferramentas • Diagnostico e informacao de rede, Wi-Fi e Internet. / Network, Wi-Fi and Internet info and diagnostics.

| Arquivo / File | Descricao | Admin | Risco / Risk | Desfazer / Undo |
|---|---|---|---|---|
| [ConnectionList.bat](ConnectionList.bat) | Mostra conexoes TCP ativas e os processos do sistema | no | 🟢 `low` | N/A |
| [ConnectionLogger.bat](ConnectionLogger.bat) | Registra em log o status da conexao com o DNS do Google | no | 🟢 `low` | N/A |
| [DNSFlush.bat](DNSFlush.bat) | Limpa o cache de resolucao DNS do Windows | no | 🟢 `low` | N/A |
| [DNSLookup.bat](DNSLookup.bat) | Consulta os registros DNS de um dominio informado | no | 🟢 `low` | N/A |
| [GatewayInfo.bat](GatewayInfo.bat) | Exibe o gateway padrao usado para saida da rede | no | 🟢 `low` | N/A |
| [InternetSpeedLauncher.bat](InternetSpeedLauncher.bat) | Abre o teste de velocidade speedtest.net no navegador | no | 🟢 `low` | N/A |
| [InternetTest.bat](InternetTest.bat) | Testa a conectividade da internet com varios destinos | no | 🟢 `low` | N/A |
| [IPInfo.bat](IPInfo.bat) | Exibe o IP local IPv4 e o gateway padrao da rede | no | 🟢 `low` | N/A |
| [LocalIP.bat](LocalIP.bat) | Exibe apenas o endereco IPv4 local do adaptador | no | 🟢 `low` | N/A |
| [NetworkAdapters.bat](NetworkAdapters.bat) | Lista as interfaces de rede com netsh interface show | no | 🟢 `low` | N/A |
| [NetworkDiagnostics.bat](NetworkDiagnostics.bat) | Menu de diagnostico de rede: ping, DNS, IP e adaptadores | no | 🟢 `low` | N/A |
| [NetworkInfo.bat](NetworkInfo.bat) | Exibe todas as configuracoes de rede com ipconfig /all | no | 🟢 `low` | N/A |
| [NetworkReport.bat](NetworkReport.bat) | Gera um relatorio TXT com todas as informacoes de rede | no | 🟢 `low` | N/A |
| [NetworkReset.bat](NetworkReset.bat) | Reseta Winsock e TCP/IP do Windows (requer Administrador) | sim | 🔴 `high` | Reiniciar o computador; para desfazer use um ponto de restauracao do sistema |
| [OpenPorts.bat](OpenPorts.bat) | Lista as portas em escuta no sistema com netstat | no | 🟢 `low` | N/A |
| [PingMonitor.bat](PingMonitor.bat) | Ping continuo (-t) para um host ate o usuario cancelar | no | 🟢 `low` | N/A |
| [PingTest.bat](PingTest.bat) | Ping parametrizado para o host informado como argumento | no | 🟢 `low` | N/A |
| [PortCheck.bat](PortCheck.bat) | Testa se uma porta TCP esta aberta em um host | no | 🟢 `low` | N/A |
| [PublicIP.bat](PublicIP.bat) | Consulta o IP publico via servidor ifconfig.me | no | 🟢 `low` | N/A |
| [RestartNetwork.bat](RestartNetwork.bat) | Desabilita e reabilita um adaptador de rede selecionado | sim | 🟡 `medium` | Enable-NetAdapter para reabilitar o adaptador manualmente |
| [RouteTable.bat](RouteTable.bat) | Exibe a tabela de rotas do sistema com route print | no | 🟢 `low` | N/A |
| [TraceRoute.bat](TraceRoute.bat) | Rastreia as rotas ate um host com tracert -d | no | 🟢 `low` | N/A |
| [WebsiteAvailability.bat](WebsiteAvailability.bat) | Testa a disponibilidade de uma lista de sites com curl | no | 🟢 `low` | N/A |
| [WebsiteMonitor.bat](WebsiteMonitor.bat) | Monitora uma URL a cada N segundos ate o usuario cancelar | no | 🟢 `low` | N/A |
| [WifiInfo.bat](WifiInfo.bat) | Exibe os detalhes da conexao Wi-Fi ativa | no | 🟢 `low` | N/A |
| [WifiNetworks.bat](WifiNetworks.bat) | Lista as redes Wi-Fi visiveis no ambiente | no | 🟢 `low` | N/A |
| [WifiPasswordBackup.bat](WifiPasswordBackup.bat) | Exporta as senhas dos perfis Wi-Fi salvas para um TXT | no | 🟡 `medium` | Apagar o arquivo TXT gerado com as senhas |
| [WifiProfileExport.bat](WifiProfileExport.bat) | Exporta os perfis Wi-Fi para arquivos XML em uma pasta | no | 🟡 `medium` | Apagar a pasta de exportacao com os XMLs |
| [WifiProfileImport.bat](WifiProfileImport.bat) | Importa perfis Wi-Fi a partir de XMLs de uma pasta | no | 🟡 `medium` | netsh wlan delete profile name do perfil importado |
| [WifiSignal.bat](WifiSignal.bat) | Exibe apenas o nivel de sinal do Wi-Fi atual | no | 🟢 `low` | N/A |

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