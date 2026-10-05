:: ============================================================
:: BATLAB | ProcessNetworkConnections.bat | v1.0.0
:: @desc      netstat + processo dono (tasklist)
:: @category  diagnostics
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - ProcessNetworkConnections
echo ============================================
echo  BATLAB - ProcessNetworkConnections
echo ============================================
setlocal EnableDelayedExpansion
set "OUTDIR=%TEMP%\BATLAB"
set "TMPF=%OUTDIR%\conexoes.txt"
if not exist "%OUTDIR%" mkdir "%OUTDIR%"
netstat -ano | findstr /i "ESTABLISHED" > "%TMPF%"
if not exist "%TMPF%" (
    echo [ERRO] Falha ao gerar a lista de conexoes.
    goto :fim
)
echo Conexoes TCP estabelecidas agrupadas por processo:
set "VISTOS=."
for /f "tokens=5" %%p in ('findstr /i "ESTABLISHED" "%TMPF%"') do (
    set "REP=0"
    for %%v in (!VISTOS!) do if "%%v"=="%%p" set "REP=1"
    if "!REP!"=="0" (
        set "VISTOS=!VISTOS! %%p"
        echo.
        echo [PID %%p]
        tasklist /fi "PID eq %%p" | findstr /i /v "Info"
    )
)
if "!VISTOS!"=="." echo [AVISO] Nenhuma conexao TCP estabelecida no momento.
del "%TMPF%" >nul 2>&1
echo.
echo Feito.
:fim
echo.
pause