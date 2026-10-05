:: ============================================================
:: BATLAB | CaptivePortalDetector.bat | v1.0.0
:: @desc      Detecta portal cativo em redes de hotel, aeroporto e cafe
:: @category  network-advanced
:: @platform windows
:: @admin     no
:: @risk      low
:: @writes    none
:: @deletes   none
:: @registry  none
:: @services  none
:: @tasks     none
:: @network   read
:: @restart   none
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - CaptivePortalDetector
echo ============================================
echo  BATLAB - CaptivePortalDetector
echo ============================================
echo Este script detecta portais cativos, como em hotel e aeroporto.
echo O sinal aparece conectado, mas a Internet so funciona apos o login.
echo.
echo Teste HTTP do arquivo de verificacao da Microsoft:
powershell -NoProfile -Command "try { $r = Invoke-WebRequest -Uri 'http://www.msftconnecttest.com/connecttest.txt' -UseBasicParsing -TimeoutSec 8 -ErrorAction Stop; 'Resposta direta: HTTP ' + [int]$r.StatusCode } catch { 'Redirecionado ou bloqueado: ' + $_.Exception.Message }"
echo.
echo Mesmo teste sem seguir redirecionamento:
powershell -NoProfile -Command "try { $r = Invoke-WebRequest -Uri 'http://neverssl.com' -UseBasicParsing -MaximumRedirection 0 -TimeoutSec 8 -ErrorAction Stop; 'Resposta direta: HTTP ' + [int]$r.StatusCode } catch { 'Redirecionado ou bloqueado: ' + $_.Exception.Message }"
echo.
echo Resolucao de nome, que costuma funcionar mesmo no portal:
powershell -NoProfile -Command "if (Resolve-DnsName -Name 'www.microsoft.com' -ErrorAction SilentlyContinue) { 'DNS OK' } else { 'DNS FALHOU' }"
echo.
echo [i] Portal cativo responde com a pagina de login ao abrir qualquer site.
:fim
echo.
pause
