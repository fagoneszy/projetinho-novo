:: ============================================================
:: BATLAB | FolderSize.bat | v1.0.0
:: @desc      Calcula o tamanho total da pasta atual
:: @category  files
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A (somente calculo)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - FolderSize
echo ============================================
echo  BATLAB - FolderSize
echo ============================================
echo Calculando o tamanho total de %CD%
echo [INFO] Inclui subpastas, arquivos ocultos e de sistema.
echo [INFO] Pastas nao pesam - somente arquivos sao somados.
echo [INFO] Em pastas grandes o calculo pode demorar.
echo [INFO] O resultado sai em MB e GB.
echo [INFO] Nada sera alterado - apenas calculo.
echo.
powershell -NoProfile -Command "$f=@(Get-ChildItem -File -Recurse -Force -EA SilentlyContinue); $s=($f | Measure-Object Length -Sum).Sum; if(-not $s){$s=0}; Write-Host ('Arquivos: ' + $f.Count); Write-Host ('Tamanho : ' + [math]::Round($s/1MB,2) + ' MB  (' + [math]::Round($s/1GB,3) + ' GB)')"
echo.
if errorlevel 1 (echo [ERRO] Falha ao calcular o tamanho.) else (echo Feito. Calculo concluido.)
:fim
echo.
pause
