# Rede avancada e conectividade / Advanced network & connectivity

> 30 ferramentas • DNS, DHCP, Wi-Fi, VPN, rotas e reset de rede. / DNS, DHCP, Wi-Fi, VPN, routes and network reset.

| Arquivo / File | Descricao | Admin | Risco / Risk | Desfazer / Undo |
|---|---|---|---|---|
| [CaptivePortalDetector.bat](CaptivePortalDetector.bat) | Detecta portal cativo em redes de hotel, aeroporto e cafe | no | 🟢 `low` | N/A |
| [DefaultRouteCheck.bat](DefaultRouteCheck.bat) | Verifica as rotas padrao e o caminho de saida para a Internet | no | 🟢 `low` | N/A |
| [DHCPDiagnostic.bat](DHCPDiagnostic.bat) | Diagnostica problemas de DHCP na configuracao dos adaptadores | no | 🟢 `low` | N/A |
| [DHCPLeaseReport.bat](DHCPLeaseReport.bat) | Mostra os leases DHCP e os servidores de cada adaptador | no | 🟢 `low` | N/A |
| [DNSConsistencyTest.bat](DNSConsistencyTest.bat) | Compara as respostas do DNS do sistema com um DNS publico | no | 🟢 `low` | N/A |
| [DNSHealthCheck.bat](DNSHealthCheck.bat) | Verifica a saude do servico e dos servidores DNS do Windows | no | 🟢 `low` | N/A |
| [DNSLatencyTest.bat](DNSLatencyTest.bat) | Mede a latencia de resolucao do DNS em varios testes | no | 🟢 `low` | N/A |
| [DualStackTest.bat](DualStackTest.bat) | Testa a conectividade IPv4 e IPv6 lado a lado | no | 🟢 `low` | N/A |
| [EthernetDiagnostic.bat](EthernetDiagnostic.bat) | Diagnostica a conexao de rede com cabo e o estado do link | no | 🟢 `low` | N/A |
| [GatewayReachability.bat](GatewayReachability.bat) | Testa se o gateway padrao da rede responde ao ping | no | 🟢 `low` | N/A |
| [InternetRouteAnalyzer.bat](InternetRouteAnalyzer.bat) | Analisa o caminho de rota usado para chegar a Internet | no | 🟢 `low` | N/A |
| [IPv4Diagnostic.bat](IPv4Diagnostic.bat) | Diagnostica a configuracao IPv4 dos adaptadores | no | 🟢 `low` | N/A |
| [IPv6Diagnostic.bat](IPv6Diagnostic.bat) | Diagnostica a configuracao IPv6 dos adaptadores | no | 🟢 `low` | N/A |
| [JitterMonitor.bat](JitterMonitor.bat) | Monitora a variacao de latencia chamada jitter | no | 🟢 `low` | N/A |
| [LatencyLogger.bat](LatencyLogger.bat) | Registra a latencia medida em um arquivo CSV | no | 🟡 `medium` | Apagar o arquivo batlab-logs\latency.csv |
| [LocalNetworkScanner.bat](LocalNetworkScanner.bat) | Varre a faixa de enderecos da rede local e lista os ativos | no | 🟡 `medium` | N/A - somente leitura; o scan apenas envia pacotes de ping |
| [MTUTest.bat](MTUTest.bat) | Testa o maior pacote que passa sem fragmentacao na conexao | no | 🟢 `low` | N/A |
| [NetworkEmergencyReset.bat](NetworkEmergencyReset.bat) | Reset de emergencia da pilha de rede do Windows | sim | 🔴 `high` | Reiniciar o computador; em ultimo caso use um ponto de restauracao do sistema |
| [NetworkIncidentReport.bat](NetworkIncidentReport.bat) | Relatorio de erros e avisos de rede dos ultimos 7 dias | sim | 🟡 `medium` | Apagar o arquivo batlab-logs\incident-report.txt |
| [NetworkProfileReport.bat](NetworkProfileReport.bat) | Relatorio dos perfis de rede guardados pelo Windows | no | 🟢 `low` | N/A |
| [PacketLossMonitor.bat](PacketLossMonitor.bat) | Monitora a perda de pacotes em um destino de rede | no | 🟢 `low` | N/A |
| [PrivateNetworkCheck.bat](PrivateNetworkCheck.bat) | Verifica se o perfil de rede atual esta como Privado | no | 🟢 `low` | N/A |
| [ProxyConfigurationReport.bat](ProxyConfigurationReport.bat) | Relatorio completo das configuracoes de proxy do sistema | no | 🟢 `low` | N/A |
| [ProxyDetector.bat](ProxyDetector.bat) | Detecta se existe proxy configurado no Windows | no | 🟢 `low` | N/A |
| [PublicNetworkCheck.bat](PublicNetworkCheck.bat) | Verifica se algum perfil de rede esta como Publico | no | 🟢 `low` | N/A |
| [VPNConnectivityTest.bat](VPNConnectivityTest.bat) | Testa se a VPN esta ativa e se o trafego passa por ela | no | 🟢 `low` | N/A |
| [VPNInterfaceDetector.bat](VPNInterfaceDetector.bat) | Detecta interfaces e servicos de VPN instalados | no | 🟢 `low` | N/A |
| [WiFiAdapterReset.bat](WiFiAdapterReset.bat) | Reinicia o servico e o adaptador Wi-Fi para destravar conexao | sim | 🟡 `medium` | O Windows reinicia o WlanSvc ao religar o adaptador, so reconecte a rede |
| [WiFiDisconnectLogger.bat](WiFiDisconnectLogger.bat) | Registra as quedas e reconexoes do Wi-Fi em um relatorio | sim | 🟡 `medium` | Apagar o arquivo batlab-logs\wifi-disconnects.txt |
| [WiFiReconnectHelper.bat](WiFiReconnectHelper.bat) | Desconecta e reconecta o Wi-Fi em uma rede ja salva | no | 🟡 `medium` | Conectar manualmente pela lista do Windows ou por netsh wlan connect |

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