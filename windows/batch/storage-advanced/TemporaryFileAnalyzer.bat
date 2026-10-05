:: ============================================================
:: BATLAB | TemporaryFileAnalyzer.bat | v1.0.0
:: @desc      Analisa o tamanho dos temporarios
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
title BATLAB - TemporaryFileAnalyzer
echo ============================================
echo  BATLAB - TemporaryFileAnalyzer
echo ============================================
echo Mede o tamanho das pastas de temporarios do PC.
echo Este script apenas mede: nenhum arquivo temporario e apagado.
powershell -NoProfile -Command "try { Write-Host 'Pastas de temporarios:'; $t=@($env:TEMP, ($env:windir+'\Temp'), ($env:ProgramData+'\Microsoft\Windows\Temp')); $sum=0; foreach($p in $t){ if(Test-Path -LiteralPath $p){ $f=@(Get-ChildItem -LiteralPath $p -Recurse -Force -File -ErrorAction SilentlyContinue); $s=($f | Measure-Object Length -Sum).Sum; if($null -eq $s){ $s=0 }; $sum=$sum+$s; Write-Host ('  '+$p+' | '+$f.Count+' arquivos | '+[math]::Round($s/1MB,1)+' MB') } else { Write-Host ('  '+$p+' | inexistente ou sem acesso') } }; Write-Host ('  Soma dos temporarios: '+[math]::Round($sum/1MB,1)+' MB') } catch { Write-Host ('  Falha na leitura: '+$_.Exception.Message) }"
:fim
echo.
pause
endlocal
