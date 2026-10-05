:: ============================================================
:: BATLAB | ClearWindowsCache.bat | v1.0.0
:: @desc      Limpa caches do Windows (prefetch e similares)
:: @category  system
:: @platform windows
:: @admin     yes
:: @risk      medium
:: @writes none
:: @deletes files
:: @registry none
:: @services none
:: @tasks none
:: @network none
:: @restart none
:: @undo      N/A - os caches serao recriados pelo Windows
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - ClearWindowsCache
echo ============================================
echo  BATLAB - ClearWindowsCache
echo ============================================
net session >nul 2>&1
if errorlevel 1 (echo [ERRO] Execute como Administrador. & pause & exit /b 1)
echo [ATENCAO] Serao limpos os caches do Windows:
echo   C:\Windows\Prefetch
echo   C:\Windows\SoftwareDistribution\Download
echo Arquivos em uso serao PULADOS (isso nao e erro).
choice /c SN /m "Limpar os caches? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
powershell -NoProfile -Command "foreach($d in @('C:\Windows\Prefetch','C:\Windows\SoftwareDistribution\Download')){ if(Test-Path -LiteralPath $d){ Get-ChildItem -LiteralPath $d -Force -EA SilentlyContinue | Remove-Item -Recurse -Force -EA SilentlyContinue } }; Write-Host 'Caches limpos (itens em uso foram pulados).'"
if errorlevel 1 (echo [!] Alguns itens nao puderam ser removidos.) else (echo Feito. Caches do Windows limpos.)
:fim
echo.
pause
