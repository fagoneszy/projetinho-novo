:: ============================================================
:: BATLAB | CopyClipboardToFile.bat | v1.0.0
:: @desc      Salva o conteudo da area de transferencia em um arquivo
:: @category  productivity
:: @admin     no
:: @risk      low
:: @undo      Apague o arquivo Clipboard.txt
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - CopyClipboardToFile
echo ============================================
echo  BATLAB - CopyClipboardToFile
echo ============================================
set "ARQ=%USERPROFILE%\Desktop\Clipboard.txt"
powershell -NoProfile -Command "Get-Clipboard -Raw | Set-Content -LiteralPath (Join-Path $env:USERPROFILE 'Desktop\Clipboard.txt') -Encoding UTF8"
if exist "%ARQ%" (echo Salvo em: %ARQ%) else (echo A area de transferencia esta vazia.)
echo.
pause