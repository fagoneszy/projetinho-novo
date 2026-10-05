:: ============================================================
:: BATLAB | ShutdownTimer.bat | v1.0.0
:: @desc      Desligar o PC em N minutos (shutdown /s /t N)
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
:: @undo      shutdown /a
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - ShutdownTimer
echo ============================================
echo  BATLAB - ShutdownTimer
echo ============================================
set "MIN=%~1"
if not defined MIN set /p "MIN=Minutos para desligar o PC: "
if not defined MIN (echo [ERRO] Valor nao informado. & goto :fim)
for /f "delims=0123456789" %%a in ("%MIN%") do set "MIN=INVALID"
if "%MIN%"=="INVALID" (echo [ERRO] Informe somente numeros (ex.: 10). & goto :fim)
:zeroloop
if not "%MIN%"=="0" if "%MIN:~0,1%"=="0" (set "MIN=%MIN:~1%" & goto :zeroloop)
set /a SECS=MIN*60
if not defined SECS (echo [ERRO] Nao foi possivel converter o tempo. & goto :fim)
echo [PLANO] Desligar o PC em %MIN% minuto(s) = %SECS% segundos.
echo [PLANO] Apenas agendar - nenhum programa sera fechado agora.
echo [ATENCAO] Salve seu trabalho; dados nao salvos serao perdidos.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
shutdown /s /t %SECS%
if errorlevel 1 (echo [ERRO] Falha ao agendar o desligamento. & goto :fim)
echo [OK] Desligamento agendado.
echo [OK] Cancele com: shutdown /a
:fim
echo.
pause
