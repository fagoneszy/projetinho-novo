:: ============================================================
:: BATLAB | PathBackup.bat | v1.0.0
:: @desc      Salva o PATH atual em um arquivo de backup
:: @category  system
:: @admin     no
:: @risk      low
:: @undo      Apague o arquivo de backup do PATH gerado
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - PathBackup
echo ============================================
echo  BATLAB - PathBackup
echo ============================================
for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd_HHmm"') do set "D=%%i"
set "OUT=%~1"
if not defined OUT set "OUT=%CD%\path_backup_%D%.txt"
echo Salvando o PATH atual em:
echo   %OUT%
echo [INFO] Linha 1 = PATH da maquina, linha 2 = PATH do usuario.
echo [INFO] Use PathRestore.bat para voltar ao estado salvo.
echo.
powershell -NoProfile -Command "[IO.File]::WriteAllText('%OUT%', [Environment]::GetEnvironmentVariable('PATH','Machine') + [Environment]::NewLine + [Environment]::GetEnvironmentVariable('PATH','User'))"
if errorlevel 1 (echo [ERRO] Falha ao gravar %OUT%) else (echo Feito. PATH salvo em %OUT%)
:fim
echo.
pause