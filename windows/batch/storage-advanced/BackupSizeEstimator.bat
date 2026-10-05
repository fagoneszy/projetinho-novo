:: ============================================================
:: BATLAB | BackupSizeEstimator.bat | v1.0.0
:: @desc      Estima o tamanho de um backup
:: @category  storage-advanced
:: @platform  windows
:: @admin     no
:: @risk      low
:: @writes none
:: @deletes none
:: @registry none
:: @services none
:: @tasks none
:: @network none
:: @restart none
:: @undo      Somente leitura: nada a desfazer
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - BackupSizeEstimator
echo ============================================
echo  BATLAB - BackupSizeEstimator
echo ============================================
echo Soma os arquivos da pasta e estima o espaco do backup.
echo Nada e copiado, movido ou apagado.
set "ORIG="
set /p "ORIG=Pasta a ser copiada, vazio para a atual: "
if "%ORIG%"=="" set "ORIG=%CD%"
if not exist "%ORIG%" (echo [ERRO] Pasta nao encontrada: %ORIG% & goto :fim)
powershell -NoProfile -Command "try { $r=(Get-Item -LiteralPath $env:ORIG).FullName; $f=@(Get-ChildItem -LiteralPath $r -Recurse -Force -File -ErrorAction SilentlyContinue); $s=($f | Measure-Object Length -Sum).Sum; if($null -eq $s){ $s=0 }; Write-Host ('  Pasta: '+$r); Write-Host ('  Arquivos: '+$f.Count); Write-Host ('  Tamanho total: '+[math]::Round($s/1MB,1)+' MB | '+[math]::Round($s/1GB,2)+' GB'); Write-Host '  Maiores arquivos:'; $f | Sort-Object Length -Descending | Select-Object -First 5 | ForEach-Object { Write-Host ('    '+[math]::Round($_.Length/1MB,1)+' MB | '+$_.FullName) }; $fol=[math]::Round($s*1.1/1GB,2); Write-Host ('  Espaco recomendado no destino com folga de 10 por cento: '+$fol+' GB') } catch { Write-Host ('  Falha ao medir a pasta: '+$_.Exception.Message) }"
:fim
echo.
pause
endlocal
