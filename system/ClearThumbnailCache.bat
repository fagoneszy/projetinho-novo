:: ============================================================
:: BATLAB | ClearThumbnailCache.bat | v1.0.0
:: @desc      Limpa o cache de miniaturas do Explorer
:: @category  system
:: @admin     no
:: @risk      medium
:: @undo      N/A - o cache de miniaturas e recriado automaticamente
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - ClearThumbnailCache
echo ============================================
echo  BATLAB - ClearThumbnailCache
echo ============================================
echo [ATENCAO] O cache de miniaturas (thumbcache) do Explorer sera apagado.
echo O Windows recria o cache nas proximas pastas que voce abrir.
echo Local: %LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache_*.db
echo Arquivos em uso serao PULADOS (isso nao e erro).
echo [INFO] Pastas podem abrir mais lento ate o cache ser refeito.
choice /c SN /m "Limpar o cache de miniaturas? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
powershell -NoProfile -Command "$d=Join-Path $env:LOCALAPPDATA 'Microsoft\Windows\Explorer'; $f=@(Get-ChildItem -LiteralPath $d -Filter 'thumbcache_*.db' -Force -EA SilentlyContinue); foreach($x in $f){ Remove-Item -LiteralPath $x.FullName -Force -EA SilentlyContinue }; Write-Host ('Removidos: ' + $f.Count + ' arquivo(s) - em uso foram pulados.')"
if errorlevel 1 (echo [!] Alguns arquivos nao puderam ser removidos.) else (echo Feito. Cache de miniaturas limpo.)
:fim
echo.
pause