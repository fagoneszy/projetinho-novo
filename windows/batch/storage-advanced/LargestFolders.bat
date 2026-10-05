:: ============================================================
:: BATLAB | LargestFolders.bat | v1.0.0
:: @desc      Maiores pastas da unidade
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
title BATLAB - LargestFolders
echo ============================================
echo  BATLAB - LargestFolders
echo ============================================
echo Soma os arquivos de cada subpasta da pasta atual e ordena.
echo Pasta analisada: %CD%
echo Pode demorar em arvores grandes. Ctrl+C interrompe. Nada e apagado.
powershell -NoProfile -Command "try { $r=(Get-Location).Path; $d=@(Get-ChildItem -LiteralPath $r -Directory -Force -ErrorAction Stop); if($d.Count -eq 0){ Write-Host '  Nenhuma subpasta nesta pasta.' }; $d | ForEach-Object { $n=$_.Name; $s=0; Get-ChildItem -LiteralPath $_.FullName -Recurse -Force -File -ErrorAction SilentlyContinue | ForEach-Object { $s=$s+$_.Length }; [pscustomobject]@{ Pasta=$n; MB=[math]::Round($s/1MB,1) } } | Sort-Object MB -Descending | Select-Object -First 10 | ForEach-Object { Write-Host ('  '+$_.Pasta+' | '+$_.MB+' MB') } } catch { Write-Host ('  Falha ao varrer a pasta: '+$_.Exception.Message) }"
:fim
echo.
pause
endlocal
