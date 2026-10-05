:: ============================================================
:: BATLAB | UpdateConnectivityTest.bat | v1.0.0
:: @desc      Testa conexao com servidores de atualizacao
:: @category  windows-update
:: @platform  windows
:: @admin     no
:: @risk      low
:: @writes none
:: @deletes none
:: @registry none
:: @services none
:: @tasks none
:: @network read
:: @restart none
:: @undo      Somente leitura: nada a desfazer
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - UpdateConnectivityTest
echo ============================================
echo  BATLAB - UpdateConnectivityTest
echo ============================================
powershell -NoProfile -Command "Write-Host 'Teste de conexao com servidores de atualizacao:'; foreach($h in @('update.microsoft.com','download.windowsupdate.com','ctldl.windowsupdate.com')){ try { $ips=[Net.Dns]::GetHostAddresses($h); $ip=$ips | Where-Object { $_.AddressFamily -eq 'InterNetwork' } | Select-Object -First 1; if(-not $ip){ $ip=$ips | Select-Object -First 1 }; $c=New-Object Net.Sockets.TcpClient; $t=[Diagnostics.Stopwatch]::StartNew(); $ok=$c.ConnectAsync($h,443).Wait(4000); $t.Stop(); $c.Close(); if($ok){ Write-Host ('  [OK]      '+$h+' | '+$ip+' | '+$t.ElapsedMilliseconds+' ms') } else { Write-Host ('  [TIMEOUT] '+$h+' | porta 443 sem resposta em 4s') } } catch { $er=$_.Exception; if($er.InnerException){ $er=$er.InnerException }; Write-Host ('  [FALHA]   '+$h+' | '+$er.Message) } }; Write-Host ''; try { $c=New-Object Net.Sockets.TcpClient; $ok=$c.ConnectAsync('1.1.1.1',443).Wait(3000); $c.Close(); if($ok){ Write-Host 'Internet geral: OK - 1.1.1.1 respondeu.' } else { Write-Host 'Internet geral: sem resposta - problema de rede local.' } } catch { Write-Host ('Internet geral: '+$_.Exception.Message) }"
:fim
echo.
pause
endlocal
