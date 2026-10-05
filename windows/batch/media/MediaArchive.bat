:: ============================================================
:: BATLAB | MediaArchive.bat | v1.0.0
:: @desc      Compacta as imagens e videos do ano em ZIP
:: @category  media
:: @admin     no
:: @risk      medium
:: @undo      Exclua o ZIP gerado na pasta Documentos (as origens nao sao alteradas)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - MediaArchive
echo ============================================
echo  BATLAB - MediaArchive
echo ============================================
set "OUTDIR=%USERPROFILE%\Documents"
echo [ATENCAO] Imagens e videos modificados NO ANO ATUAL serao
echo           compactados em um arquivo ZIP dentro de Documentos.
echo O ZIP existente, se houver, sera substituido.
echo Nada sera apagado das pastas de origem.
echo.
echo Arquivos que entram no ZIP (lista parcial):
powershell -NoProfile -Command "$y=(Get-Date).Year; $p=Join-Path $env:USERPROFILE 'Pictures'; $v=Join-Path $env:USERPROFILE 'Videos'; $f=@(Get-ChildItem -Path (Join-Path $p '*') -Include *.jpg,*.jpeg,*.png,*.gif,*.bmp,*.webp,*.mp4,*.avi,*.mkv,*.mov,*.wmv -File -EA SilentlyContinue) + @(Get-ChildItem -Path (Join-Path $v '*') -Include *.mp4,*.avi,*.mkv,*.mov,*.wmv,*.jpg,*.jpeg,*.png -File -EA SilentlyContinue); @($f | Where-Object { $_.LastWriteTime.Year -eq $y } | Select-Object -First 15 Name, LastWriteTime | Format-Table -AutoSize)"
echo.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
echo Compactando...
powershell -NoProfile -Command "$y=(Get-Date).Year; $p=Join-Path $env:USERPROFILE 'Pictures'; $v=Join-Path $env:USERPROFILE 'Videos'; $f=@(Get-ChildItem -Path (Join-Path $p '*') -Include *.jpg,*.jpeg,*.png,*.gif,*.bmp,*.webp,*.mp4,*.avi,*.mkv,*.mov,*.wmv -File -EA SilentlyContinue) + @(Get-ChildItem -Path (Join-Path $v '*') -Include *.mp4,*.avi,*.mkv,*.mov,*.wmv,*.jpg,*.jpeg,*.png -File -EA SilentlyContinue); $f=@($f | Where-Object { $_.LastWriteTime.Year -eq $y }); if ($f.Count -eq 0) { Write-Host 'Nenhum arquivo do ano atual encontrado.' } else { $out=Join-Path $env:OUTDIR ('midia_' + $y + '.zip'); Compress-Archive -LiteralPath ($f.FullName) -DestinationPath $out -Force; Write-Host ('ZIP gerado: ' + $out) }"
if errorlevel 1 (echo [!] O PowerShell retornou um codigo de erro.) else (echo Feito.)
:fim
echo.
pause