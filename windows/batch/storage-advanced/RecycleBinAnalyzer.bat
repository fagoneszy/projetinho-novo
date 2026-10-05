:: ============================================================
:: BATLAB | RecycleBinAnalyzer.bat | v1.0.0
:: @desc      Analise do conteudo da lixeira
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
title BATLAB - RecycleBinAnalyzer
echo ============================================
echo  BATLAB - RecycleBinAnalyzer
echo ============================================
echo Conta e mede o conteudo da lixeira e lista os maiores itens.
echo Este script apenas lista: a lixeira nao esvaziada.
powershell -NoProfile -Command "try { $sh=New-Object -ComObject Shell.Application; $rb=$sh.Namespace(10); if($null -eq $rb){ Write-Host '  Lixeira indisponivel.' } else { $it=@($rb.Items()); $sum=0; $it | ForEach-Object { $sum=$sum+$_.Size }; Write-Host ('  Itens na lixeira: '+$it.Count); Write-Host ('  Tamanho total: '+[math]::Round($sum/1MB,1)+' MB'); if($it.Count -gt 0){ Write-Host '  Maiores itens:'; $it | Sort-Object Size -Descending | Select-Object -First 10 | ForEach-Object { Write-Host ('    '+$rb.GetDetailsOf($_,0)+' | '+[math]::Round($_.Size/1MB,2)+' MB | origem '+$rb.GetDetailsOf($_,1)) } } } } catch { Write-Host ('  Falha ao ler a lixeira: '+$_.Exception.Message) }"
:fim
echo.
pause
endlocal
