:: ============================================================
:: BATLAB | CountCodeLines.bat | v1.0.0
:: @desc      Conta as linhas de codigo por extensao no projeto
:: @category  developer
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - CountCodeLines
echo ============================================
echo  BATLAB - CountCodeLines
echo ============================================
echo Contando linhas de codigo por extensao em %CD%...
echo Somente arquivos de codigo sao considerados.
echo Aguarde a varredura das subpastas.
echo Host: %COMPUTERNAME% - contagem em %DATE% %TIME%
echo.
powershell -NoProfile -Command "Get-ChildItem -Recurse -File | Where-Object { $_.Extension -match '^\.(py|js|ts|jsx|tsx|java|c|cpp|h|hpp|go|rs|bat|ps1|html|css)$' } | Group-Object Extension | Sort-Object Name | ForEach-Object { $l = ($_.Group | Get-Content -ErrorAction SilentlyContinue | Measure-Object -Line).Lines; '{0,-8} {1,7} linhas  {2,5} arquivos' -f $_.Name, $l, $_.Count }"
if errorlevel 1 echo [!] A contagem retornou erro.
echo.
echo [i] Extensao, total de linhas e quantidade de arquivos.
echo Feito.
echo.
pause
