:: ============================================================
:: BATLAB | RecentlyInstalled.bat | v1.0.0
:: @desc      Programas instalados recentemente, ordenados por data
:: @category  diagnostics
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - RecentlyInstalled
echo ============================================
echo  BATLAB - RecentlyInstalled
echo ============================================
for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd"') do set "D=%%i"
set "OUTDIR=%TEMP%\BATLAB"
set "OUT=%OUTDIR%\instalados-recentes-%D%.txt"
if not exist "%OUTDIR%" mkdir "%OUTDIR%"
echo Ordenando os programas instalados pela data de instalacao...
powershell -NoProfile -Command "Get-ItemProperty 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*','HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*','HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*' -ErrorAction SilentlyContinue | Where-Object { $_.DisplayName } | Sort-Object InstallDate -Descending | Select-Object InstallDate,DisplayName,Publisher,DisplayVersion | Format-Table -AutoSize -Wrap" > "%OUT%"
if errorlevel 1 (
    echo [ERRO] Falha ao ler o registro de programas.
    goto :fim
)
echo [OK] Lista gravada em:
echo   %OUT%
echo [OK] Linhas de cima = instalacoes mais recentes (AAAAMMDD).
echo [!] Programa sem InstallDate aparece no fim da lista.
echo Feito.
:fim
echo.
pause