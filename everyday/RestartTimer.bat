:: ============================================================
:: BATLAB | RestartTimer.bat | v1.0.0
:: @desc      Reiniciar o PC em N minutos (shutdown /r /t N)
:: @category  everyday
:: @admin     no
:: @risk      medium
:: @undo      shutdown /a
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - RestartTimer
echo ============================================
echo  BATLAB - RestartTimer
echo ============================================
set "MIN=%~1"
if not defined MIN set /p "MIN=Minutos para reiniciar o PC: "
if not defined MIN (echo [ERRO] Valor nao informado. & goto :fim)
for /f "delims=0123456789" %%a in ("%MIN%") do set "MIN=INVALID"
if "%MIN%"=="INVALID" (echo [ERRO] Informe somente numeros (ex.: 10). & goto :fim)
:zeroloop
if not "%MIN%"=="0" if "%MIN:~0,1%"=="0" (set "MIN=%MIN:~1%" & goto :zeroloop)
set /a SECS=MIN*60
if not defined SECS (echo [ERRO] Nao foi possivel converter o tempo. & goto :fim)
echo [PLANO] Reiniciar o PC em %MIN% minuto(s) = %SECS% segundos.
echo [PLANO] A agenda e a sessao serao encerradas na hora marcada.
echo [ATENCAO] Salve seu trabalho; dados nao salvos serao perdidos.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
shutdown /r /t %SECS%
if errorlevel 1 (echo [ERRO] Falha ao agendar o reinicio. & goto :fim)
echo [OK] Reinicio agendado.
echo [OK] Cancele com: shutdown /a
:fim
echo.
pause