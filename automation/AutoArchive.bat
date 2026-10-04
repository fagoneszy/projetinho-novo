:: ============================================================
:: BATLAB | AutoArchive.bat | v1.0.0
:: @desc      Compacta em ZIP e remove arquivos antigos da pasta
:: @category  automation
:: @admin     no
:: @risk      medium
:: @undo      Extraia os arquivos do ZIP Arquivo_AAAA-MM-DD.zip
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - AutoArchive
echo ============================================
echo  BATLAB - AutoArchive
echo ============================================
set "DIAS=30"
if not "%~1"=="" set "DIAS=%~1"
echo(%DIAS%| findstr /r "^[1-9][0-9]*$" >nul
if errorlevel 1 (echo Valor invalido: %DIAS%. Use dias sem zero a esquerda. & goto :fim)
echo [ATENCAO] Vai compactar em ZIP e REMOVER da pasta os arquivos
echo com mais de %DIAS% dias de idade.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
powershell -NoProfile -Command "$n=[int]('%DIAS%'); $d=Get-Date -Format yyyy-MM-dd; $z=Join-Path (Get-Location).Path ('Arquivo_'+$d+'.zip'); $f=@(Get-ChildItem -File | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-$n) }); if($f.Count -eq 0){ Write-Host 'Nenhum arquivo antigo nesta pasta.' } else { $f | Compress-Archive -DestinationPath $z -Update; $f | Remove-Item; Write-Host ('Zip criado: ' + $z); Write-Host ($f.Count.ToString() + ' arquivos removidos da pasta.') }"
:fim
echo.
pause