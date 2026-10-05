:: ============================================================
:: BATLAB | SleepTimer.bat | v1.0.0
:: @desc      Dorme o PC em N minutos (rundll32.exe powrprof.dll,SetSuspendState)
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
:: @restart none
:: @undo      Feche a janela antes do fim da espera; apos dormir acorde com o teclado
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - SleepTimer
echo ============================================
echo  BATLAB - SleepTimer
echo ============================================
set "MIN=%~1"
if not defined MIN set /p "MIN=Minutos para o PC entrar em suspensao: "
if not defined MIN (echo [ERRO] Valor nao informado. & goto :fim)
for /f "delims=0123456789" %%a in ("%MIN%") do set "MIN=INVALID"
if "%MIN%"=="INVALID" (echo [ERRO] Informe somente numeros (ex.: 10). & goto :fim)
:zeroloop
if not "%MIN%"=="0" if "%MIN:~0,1%"=="0" (set "MIN=%MIN:~1%" & goto :zeroloop)
set /a SECS=MIN*60
if not defined SECS (echo [ERRO] Nao foi possivel converter o tempo. & goto :fim)
echo [PLANO] Suspender o PC em %MIN% minuto(s) = %SECS% segundos.
echo [PLANO] Programas ficam abertos na memoria (nao serao fechados).
echo [ATENCAO] Deixe esta janela aberta; feche-a para cancelar.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
echo Aguardando... nao feche esta janela.
powershell -NoProfile -Command "Start-Sleep -Seconds %SECS%"
if errorlevel 1 (echo [ERRO] Falha na espera. & goto :fim)
rundll32.exe powrprof.dll,SetSuspendState 0,1,0
if errorlevel 1 (echo [ERRO] Falha ao solicitar a suspensao. & goto :fim)
echo [OK] Suspensao solicitada.
:fim
echo.
pause
