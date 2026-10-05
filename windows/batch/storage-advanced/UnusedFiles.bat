:: ============================================================
:: BATLAB | UnusedFiles.bat | v1.0.0
:: @desc      Arquivos nao acessados ha muito tempo
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
title BATLAB - UnusedFiles
echo ============================================
echo  BATLAB - UnusedFiles
echo ============================================
set "DIAS=%~1"
if "%DIAS%"=="" set "DIAS=180"
echo Lista arquivos da pasta atual sem acesso ha mais de %DIAS% dias.
echo Pasta analisada: %CD%
echo Uso: UnusedFiles.bat 360 - padrao 180 dias. Nada e apagado.
powershell -NoProfile -Command "try { $d=180; if($env:DIAS -match '^[0-9]+$'){ $d=[int]$env:DIAS }; $c=(Get-Date).AddDays(-1*$d); $r=(Get-Location).Path; $f=@(Get-ChildItem -LiteralPath $r -Recurse -Force -File -ErrorAction SilentlyContinue | Where-Object { $_.LastAccessTime -lt $c }); if($f.Count -eq 0){ Write-Host ('  Nenhum arquivo parado desde '+$c.ToString('dd/MM/yyyy')+'.') } else { Write-Host ('  '+$f.Count+' arquivo(s) sem acesso desde '+$c.ToString('dd/MM/yyyy')+':'); $f | Sort-Object LastAccessTime | Select-Object -First 15 | ForEach-Object { Write-Host ('    '+$_.LastAccessTime.ToString('dd/MM/yyyy')+' | '+[math]::Round($_.Length/1KB,0)+' KB | '+$_.FullName) }; $t=($f | Measure-Object Length -Sum).Sum; Write-Host ('  Total parado: '+[math]::Round($t/1MB,1)+' MB') } } catch { Write-Host ('  Falha ao varrer a pasta: '+$_.Exception.Message) }"
:fim
echo.
pause
endlocal
