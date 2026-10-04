:: ============================================================
:: BATLAB | LocalIP.bat | v1.0.0
:: @desc      Exibe apenas o endereco IPv4 local do adaptador
:: @category  network
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - LocalIP
echo ============================================
echo  BATLAB - LocalIP
echo ============================================
set "IP="
for /f "tokens=1,* delims=:" %%a in ('ipconfig ^| findstr /i "IPv4"') do set "IP=%%b"
if not defined IP (echo [ERRO] Nenhum adaptador com IPv4 encontrado. & goto :fim)
echo.
echo IPv4 local:%IP%
echo Host: %COMPUTERNAME%
echo.
echo [i] Mostra somente o IPv4 do adaptador ativo.
echo [i] Para ver tudo use NetworkInfo.bat.
echo Feito.
:fim
echo.
pause