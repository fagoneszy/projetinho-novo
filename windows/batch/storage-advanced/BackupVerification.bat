:: ============================================================
:: BATLAB | BackupVerification.bat | v1.0.0
:: @desc      Compara backup com a pasta original
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
title BATLAB - BackupVerification
echo ============================================
echo  BATLAB - BackupVerification
echo ============================================
echo Compara quantidade, tamanho e arquivos faltando no backup.
echo Somente leitura: nenhuma pasta e alterada.
set "ORIG="
set /p "ORIG=Pasta original: "
set "DEST="
set /p "DEST=Pasta do backup: "
if "%ORIG%"=="" (echo [ERRO] Informe a pasta original. & goto :fim)
if "%DEST%"=="" (echo [ERRO] Informe a pasta do backup. & goto :fim)
if not exist "%ORIG%" (echo [ERRO] Nao encontrada: %ORIG% & goto :fim)
if not exist "%DEST%" (echo [ERRO] Nao encontrada: %DEST% & goto :fim)
powershell -NoProfile -Command "try { $o=(Get-Item -LiteralPath $env:ORIG).FullName; $b=(Get-Item -LiteralPath $env:DEST).FullName; $of=@(Get-ChildItem -LiteralPath $o -Recurse -Force -File -ErrorAction SilentlyContinue); $bf=@(Get-ChildItem -LiteralPath $b -Recurse -Force -File -ErrorAction SilentlyContinue); $so=($of | Measure-Object Length -Sum).Sum; $sb=($bf | Measure-Object Length -Sum).Sum; if($null -eq $so){ $so=0 }; if($null -eq $sb){ $sb=0 }; Write-Host ('  Original: '+$of.Count+' arquivos | '+[math]::Round($so/1MB,1)+' MB'); Write-Host ('  Backup:   '+$bf.Count+' arquivos | '+[math]::Round($sb/1MB,1)+' MB'); Write-Host ('  Diferenca de tamanho: '+[math]::Round(($sb-$so)/1MB,1)+' MB'); if(($of.Count -eq 0) -or ($bf.Count -eq 0)){ Write-Host '  Uma das pastas esta vazia: comparacao de nomes pulada.' } else { $ro=@($of | ForEach-Object { $_.FullName.Substring($o.Length) }); $rb=@($bf | ForEach-Object { $_.FullName.Substring($b.Length) }); $d=@(Compare-Object -ReferenceObject $ro -DifferenceObject $rb); $miss=@($d | Where-Object { $_.SideIndicator -eq '<=' }); $extra=@($d | Where-Object { $_.SideIndicator -eq '=>' }); Write-Host ('  Faltando no backup: '+$miss.Count+' | sobrando no backup: '+$extra.Count); $miss | Select-Object -First 10 | ForEach-Object { Write-Host ('    falta: '+$_.InputObject) }; $extra | Select-Object -First 10 | ForEach-Object { Write-Host ('    sobra: '+$_.InputObject) } } } catch { Write-Host ('  Falha ao comparar: '+$_.Exception.Message) }"
:fim
echo.
pause
endlocal
