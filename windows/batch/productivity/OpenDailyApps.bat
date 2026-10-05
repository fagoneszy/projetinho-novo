:: ============================================================
:: BATLAB | OpenDailyApps.bat | v1.0.0
:: @desc      Abre os aplicativos diarios listados em daily-apps.txt
:: @category  productivity
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenDailyApps
echo ============================================
echo  BATLAB - OpenDailyApps
echo ============================================
set "LISTA=%~dp0daily-apps.txt"
if not exist "%LISTA%" (
    >"%LISTA%" echo notepad
    >>"%LISTA%" echo calc
    >>"%LISTA%" echo https://duckduckgo.com
    echo Lista criada: %LISTA%
    echo Edite o arquivo com seus aplicativos/links e execute de novo.
    goto :fim
)
for /f "usebackq delims=" %%A in ("%LISTA%") do start "" "%%A"
echo Abrindo os itens de daily-apps.txt...
:fim
echo.
pause