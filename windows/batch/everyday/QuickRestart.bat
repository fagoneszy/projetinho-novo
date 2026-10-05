:: ============================================================
:: BATLAB | QuickRestart.bat | v1.0.0
:: @desc      Reinicia agora (shutdown /r /t 0)
:: @category  everyday
:: @platform windows
:: @admin     no
:: @risk      medium
:: @writes none
:: @deletes none
:: @registry none
:: @services none
:: @tasks none
:: @network none
:: @restart os
:: @undo      N/A - reinicio imediato, nao reversivel
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - QuickRestart
echo ============================================
echo  BATLAB - QuickRestart
echo ============================================
echo [PLANO] Reiniciar o PC imediatamente (shutdown /r /t 0).
echo [PLANO] Sessao e todos os programas serao encerrados agora.
echo [ATENCAO] Dados nao salvos em qualquer programa serao perdidos.
choice /c SN /m "Primeira confirmacao - reiniciar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
echo [ATENCAO] Ultima chance: o reboot comeca logo apos o Sim.
choice /c SN /m "Segunda confirmacao - agora? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
shutdown /r /t 0
if errorlevel 1 (echo [ERRO] Falha ao solicitar o reinicio. & goto :fim)
echo [OK] Reinicio solicitado.
:fim
echo.
pause
