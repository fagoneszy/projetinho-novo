:: ============================================================
:: BATLAB | SecurityEventReport.bat | v1.0.0
:: @desc      Eventos de seguranca dos ultimos 7 dias em TXT
:: @category  diagnostics
:: @admin     yes
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - SecurityEventReport
echo ============================================
echo  BATLAB - SecurityEventReport
echo ============================================
net session >nul 2>&1
if errorlevel 1 (echo [ERRO] Execute como Administrador. & pause & exit /b 1)
for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd"') do set "D=%%i"
set "OUTDIR=%TEMP%\BATLAB"
set "OUT=%OUTDIR%\eventos-seguranca-%D%.txt"
if not exist "%OUTDIR%" mkdir "%OUTDIR%"
echo Coletando eventos de seguranca (ultimos 7 dias)...
powershell -NoProfile -Command "Get-WinEvent -FilterHashtable @{LogName='Security'; StartTime=(Get-Date).AddDays(-7)} -MaxEvents 100 | Format-List TimeCreated,Id,LevelDisplayName,ProviderName,Message" > "%OUT%"
if errorlevel 1 (
    echo [ERRO] Falha ao ler o log Security (sem privilegio ou vazio).
    goto :fim
)
echo [OK] Relatorio gravado em:
echo   %OUT%
echo [!] Log Security e auditado: leitura exige Administrador.
echo [!] Focos 4624/4625 (logon) e 4648 (logon explicito).
echo Feito.
:fim
echo.
pause