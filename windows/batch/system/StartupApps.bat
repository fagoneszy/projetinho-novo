:: ============================================================
:: BATLAB | StartupApps.bat | v1.0.0
:: @desc      Programas que iniciam com o Windows
:: @category  system
:: @admin     no
:: @risk      low
:: @undo      N/A (somente leitura)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - StartupApps
echo ============================================
echo  BATLAB - StartupApps
echo ============================================
echo Listando os programas que iniciam com o Windows...
echo [INFO] Chaves de registro Run (HKCU e HKLM) e pastas de Iniciar.
echo [INFO] Nada sera alterado - apenas leitura.
echo.
powershell -NoProfile -Command "foreach($k in @('HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run','HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run')){ Write-Host ('--- ' + $k); $p=Get-ItemProperty -Path $k -EA SilentlyContinue; if($p){ $p.PSObject.Properties | Where-Object { $_.Name -notlike 'PS*' } | ForEach-Object { '   ' + $_.Name + ' = ' + $_.Value } } }"
echo --- Pasta Iniciar do usuario ---
dir /b "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup" 2>nul
echo --- Pasta Iniciar de todos ---
dir /b "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup" 2>nul
echo.
if errorlevel 1 (echo [!] Algumas fontes nao puderam ser lidas.) else (echo Feito. Lista acima.)
:fim
echo.
pause