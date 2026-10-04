:: ============================================================
:: BATLAB | CleanDownloads.bat | v1.0.0
:: @desc      Remove da pasta Downloads arquivos mais antigos que N dias
:: @category  files
:: @admin     no
:: @risk      high
:: @undo      Irreversivel - use /dryrun antes
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - CleanDownloads
echo ============================================
echo  BATLAB - CleanDownloads
echo ============================================
set "DRY="
set "DIAS="
if /i "%~1"=="/dryrun" (set "DRY=1") else (set "DIAS=%~1")
if /i "%~2"=="/dryrun" (set "DRY=1") else if not defined DIAS (set "DIAS=%~2")
if not defined DRY if not defined DIAS set /p "DIAS=Idade minima em dias (padrao 30): "
if not defined DIAS set "DIAS=30"
echo(%DIAS%| findstr /r /c:"^[0-9][0-9]*$" >nul || set "DIAS=30"
set "DL=%USERPROFILE%\Downloads"
if not exist "%DL%\" (echo [ERRO] Pasta Downloads nao encontrada. & goto :fim)
echo Arquivos com mais de %DIAS% dias em %DL%:
powershell -NoProfile -Command "$c=@(Get-ChildItem -LiteralPath (Join-Path $env:USERPROFILE 'Downloads') -File -Force -EA SilentlyContinue | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-%DIAS%) }); foreach($f in $c){ Write-Host ('  ' + $f.LastWriteTime.ToString('yyyy-MM-dd') + '  ' + $f.Name) }; Write-Host ('Total: ' + $c.Count + ' arquivo(s)')"
if defined DRY (echo [/dryrun] Nada foi excluido. & goto :fim)
echo.
echo [ATENCAO] Os arquivos listados acima serao EXCLUIDOS PERMANENTEMENTE.
echo           Nao ha Lixeira - a exclusao e IRREVERSIVEL sem backup.
choice /c SN /m "Deseja continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
echo [ATENCAO] CONFIRMACAO FINAL: exclusao definitiva dos arquivos acima.
choice /c SN /m "Excluir de vez? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
powershell -NoProfile -Command "$c=@(Get-ChildItem -LiteralPath (Join-Path $env:USERPROFILE 'Downloads') -File -Force -EA SilentlyContinue | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-%DIAS%) }); foreach($f in $c){ Remove-Item -LiteralPath $f.FullName -Force -EA SilentlyContinue }; Write-Host ('Removidos: ' + $c.Count + ' arquivo(s)')"
if errorlevel 1 (echo [!] Confera a pasta - alguns arquivos podem estar em uso.) else (echo Feito.)
:fim
echo.
pause