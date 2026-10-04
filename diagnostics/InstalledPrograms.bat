:: ============================================================
:: BATLAB | InstalledPrograms.bat | v1.0.0
:: @desc      Programas instalados (registro de desinstalar) em TXT e CSV
:: @category  diagnostics
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - InstalledPrograms
echo ============================================
echo  BATLAB - InstalledPrograms
echo ============================================
for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd"') do set "D=%%i"
set "OUTDIR=%TEMP%\BATLAB"
set "TXT=%OUTDIR%\programas-%D%.txt"
set "CSV=%OUTDIR%\programas-%D%.csv"
if not exist "%OUTDIR%" mkdir "%OUTDIR%"
echo Lendo as chaves de desinstalacao do registro...
powershell -NoProfile -Command "Get-ItemProperty 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*','HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*','HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*' -ErrorAction SilentlyContinue | Where-Object { $_.DisplayName } | Sort-Object DisplayName | Select-Object DisplayName,DisplayVersion,Publisher,InstallDate | Format-Table -AutoSize -Wrap" > "%TXT%"
if errorlevel 1 (
    echo [ERRO] Falha ao ler o registro de programas.
    goto :fim
)
powershell -NoProfile -Command "Get-ItemProperty 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*','HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*','HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*' -ErrorAction SilentlyContinue | Where-Object { $_.DisplayName } | Sort-Object DisplayName | Select-Object DisplayName,DisplayVersion,Publisher,InstallDate | Export-Csv -Path '%CSV%' -NoTypeInformation -Encoding UTF8"
if errorlevel 1 echo [AVISO] Nao foi possivel gerar o CSV.
echo [OK] Texto : %TXT%
echo [OK] CSV   : %CSV%
echo [OK] InstallDate no registro vem no formato AAAAMMDD.
echo Feito.
:fim
echo.
pause