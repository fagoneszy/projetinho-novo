:: ============================================================
:: BATLAB | QuickShutdown.bat | v1.0.0
:: @desc      Desliga agora (shutdown /s /t 0)
:: @category  everyday
:: @admin     no
:: @risk      medium
:: @undo      N/A - desligamento imediato, nao reversivel
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - QuickShutdown
echo ============================================
echo  BATLAB - QuickShutdown
echo ============================================
echo [PLANO] Desligar o PC imediatamente (shutdown /s /t 0).
echo [PLANO] Sessao e todos os programas serao encerrados agora.
echo [ATENCAO] Dados nao salvos em qualquer programa serao perdidos.
choice /c SN /m "Primeira confirmacao - desligar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
echo [ATENCAO] Ultima chance: o desligamento comeca logo apos o Sim.
choice /c SN /m "Segunda confirmacao - agora? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
shutdown /s /t 0
if errorlevel 1 (echo [ERRO] Falha ao solicitar o desligamento. & goto :fim)
echo [OK] Desligamento solicitado.
:fim
echo.
pause