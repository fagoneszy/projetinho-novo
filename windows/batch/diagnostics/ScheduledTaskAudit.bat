:: ============================================================
:: BATLAB | ScheduledTaskAudit.bat | v1.0.0
:: @desc      Tarefas agendadas suspeitas ou ocultas (schtasks /query /fo LIST)
:: @category  diagnostics
:: @platform windows
:: @admin     yes
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - ScheduledTaskAudit
echo ============================================
echo  BATLAB - ScheduledTaskAudit
echo ============================================
net session >nul 2>&1
if errorlevel 1 (echo [ERRO] Execute como Administrador. & pause & exit /b 1)
for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd"') do set "D=%%i"
set "OUTDIR=%TEMP%\BATLAB"
set "OUT=%OUTDIR%\tarefas-%D%.txt"
if not exist "%OUTDIR%" mkdir "%OUTDIR%"
echo Listando todas as tarefas agendadas (pode demorar)...
schtasks /query /fo LIST /v > "%OUT%"
if errorlevel 1 (
    echo [ERRO] Falha ao listar as tarefas agendadas.
    goto :fim
)
echo [OK] Lista completa gravada em:
echo   %OUT%
echo [!] Olhe "Task To Run" com caminho em %TEMP% ou pasta de usuario.
echo [!] Tarefas ocultas aparecem com "Hidden: Yes".
echo [!] "Run As User" diferente do esperado tambem chama atencao.
echo Feito.
:fim
echo.
pause
