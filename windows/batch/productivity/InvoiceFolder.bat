:: ============================================================
:: BATLAB | InvoiceFolder.bat | v1.0.0
:: @desc      Cria a estrutura de documentos financeiros do mes
:: @category  productivity
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      Apague a pasta criada
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - InvoiceFolder
echo ============================================
echo  BATLAB - InvoiceFolder
echo ============================================
for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM"') do set "MES=%%i"
if not exist "%MES%" mkdir "%MES%"
if not exist "%MES%\Recebidas" mkdir "%MES%\Recebidas"
if not exist "%MES%\Emitidas" mkdir "%MES%\Emitidas"
echo Estrutura financeira criada em: %CD%\%MES%
echo.
pause
