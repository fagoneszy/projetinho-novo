:: ============================================================
:: BATLAB | RestartComputer.bat | v1.0.0
:: @desc      Reinicia o computador apos N segundos (padrao 60, cancelavel com /a)
:: @category  system
:: @admin     no
:: @risk      medium
:: @undo      Cancele com shutdown /a antes do reinicio
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - RestartComputer
echo ============================================
echo  BATLAB - RestartComputer
echo ============================================
set "SEG=%~1"
if not defined SEG set /p "SEG=Segundos ate o reinicio (padrao 60): "
if not defined SEG set "SEG=60"
echo(%SEG%| findstr /r /c:"^[0-9][0-9]*$" >nul || set "SEG=60"
echo [ATENCAO] O computador sera REINICIADO em %SEG% segundos.
echo Depois de agendado, cancele a qualquer momento com: shutdown /a
echo Nao ha desfazer apos o reinicio - salve seu trabalho.
choice /c SN /m "Agendar o reinicio? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
shutdown /r /t %SEG% /c "BATLAB: reinicio agendado"
if errorlevel 1 (echo [ERRO] Falha ao agendar o reinicio.) else (echo Feito. Reinicio em %SEG% segundos - cancele com: shutdown /a)
:fim
echo.
pause