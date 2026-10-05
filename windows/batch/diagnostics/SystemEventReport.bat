:: ============================================================
:: BATLAB | SystemEventReport.bat | v1.0.0
:: @desc      Erros e avisos do log Sistema dos ultimos 7 dias em TXT
:: @category  diagnostics
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - SystemEventReport
echo ============================================
echo  BATLAB - SystemEventReport
echo ============================================
for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd"') do set "D=%%i"
set "OUTDIR=%TEMP%\BATLAB"
set "OUT=%OUTDIR%\eventos-sistema-%D%.txt"
if not exist "%OUTDIR%" mkdir "%OUTDIR%"
echo Coletando erros e avisos do log Sistema (ultimos 7 dias)...
powershell -NoProfile -Command "Get-WinEvent -FilterHashtable @{LogName='System'; Level=1,2,3; StartTime=(Get-Date).AddDays(-7)} -MaxEvents 50 | Format-List TimeCreated,Id,LevelDisplayName,ProviderName,Message" > "%OUT%"
if errorlevel 1 (
    echo [ERRO] Falha ao ler o log Sistema (ou nenhum evento).
    goto :fim
)
echo [OK] Relatorio gravado em:
echo   %OUT%
echo [OK] Niveis: 1=Critico  2=Erro  3=Aviso.
echo [Dica] Mais eventos: aumente o -MaxEvents no script.
echo Feito.
:fim
echo.
pause