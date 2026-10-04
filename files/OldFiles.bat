:: ============================================================
:: BATLAB | OldFiles.bat | v1.0.0
:: @desc      Lista arquivos mais antigos que N dias (padrao 365)
:: @category  files
:: @admin     no
:: @risk      low
:: @undo      N/A (somente listagem)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OldFiles
echo ============================================
echo  BATLAB - OldFiles
echo ============================================
set "DIAS=%~1"
if not defined DIAS set /p "DIAS=Idade minima em dias (padrao 365): "
if not defined DIAS set "DIAS=365"
echo(%DIAS%| findstr /r /c:"^[0-9][0-9]*$" >nul || set "DIAS=365"
echo Arquivos modificados ha mais de %DIAS% dias em %CD%
echo [INFO] Usa forfiles /D -%DIAS% (inclui subpastas).
echo.
forfiles /S /D -%DIAS% /C "cmd /c echo @path  @fdate  @fsize bytes"
if errorlevel 1 (echo [!] Nenhum arquivo encontrado ou forfiles falhou.) else (echo Feito. Listagem concluida.)
:fim
echo.
pause