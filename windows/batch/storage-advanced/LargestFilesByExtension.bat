:: ============================================================
:: BATLAB | LargestFilesByExtension.bat | v1.0.0
:: @desc      Maiores arquivos por extensao
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
title BATLAB - LargestFilesByExtension
echo ============================================
echo  BATLAB - LargestFilesByExtension
echo ============================================
echo Agrupa os arquivos da pasta atual por extensao e ordena por tamanho.
echo Pasta analisada: %CD%
echo Somente leitura: nenhum arquivo e movido ou apagado.
powershell -NoProfile -Command "try { $r=(Get-Location).Path; $f=@(Get-ChildItem -LiteralPath $r -Recurse -Force -File -ErrorAction SilentlyContinue); if($f.Count -eq 0){ Write-Host '  Nenhum arquivo nesta pasta.' }; $f | Group-Object Extension | ForEach-Object { $e = if($_.Name){ $_.Name } else { '(sem extensao)' }; [pscustomobject]@{ Ext=$e; Qtd=$_.Count; MB=[math]::Round((($_.Group | Measure-Object Length -Sum).Sum)/1MB,1) } } | Sort-Object MB -Descending | Select-Object -First 10 | ForEach-Object { Write-Host ('  '+$_.Ext+' | '+$_.Qtd+' arquivos | '+$_.MB+' MB') } } catch { Write-Host ('  Falha ao varrer a pasta: '+$_.Exception.Message) }"
:fim
echo.
pause
endlocal
