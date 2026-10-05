:: ============================================================
:: BATLAB | ExtensionReport.bat | v1.0.0
:: @desc      Relatorio: quantidade e tamanho por extensao
:: @category  files
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A (somente listagem)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - ExtensionReport
echo ============================================
echo  BATLAB - ExtensionReport
echo ============================================
echo Gerando relatorio por extensao em %CD%
echo [INFO] Colunas: extensao, quantidade de arquivos e tamanho total.
echo [INFO] A ordem e do maior tamanho para o menor.
echo [INFO] Inclui subpastas, arquivos ocultos e de sistema.
echo [INFO] Nada sera alterado - apenas leitura.
echo.
powershell -NoProfile -Command "Get-ChildItem -File -Recurse -Force -EA SilentlyContinue | Group-Object { if($_.Extension){$_.Extension.ToLower()} else {'(sem extensao)'} } | Sort-Object { ($_.Group | Measure-Object Length -Sum).Sum } -Descending | ForEach-Object { $s=($_.Group | Measure-Object Length -Sum).Sum; '{0,-16} {1,6} arq  {2,12:N0} KB' -f $_.Name, $_.Count, ($s/1KB) }"
echo.
if errorlevel 1 (echo [ERRO] Falha ao gerar o relatorio.) else (echo Feito. Relatorio concluido.)
:fim
echo.
pause
