:: ============================================================
:: BATLAB | PathViewer.bat | v1.0.0
:: @desc      Mostra o PATH do sistema formatado, uma pasta por linha
:: @category  system
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A (somente leitura)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - PathViewer
echo ============================================
echo  BATLAB - PathViewer
echo ============================================
echo PATH formatado - uma pasta por linha...
echo [INFO] Primeiro o PATH da MAQUINA, depois o do USUARIO.
echo [INFO] Os dois juntos formam o PATH efetivo do processo.
echo [INFO] Nada sera alterado - apenas leitura.
echo [INFO] Linhas vazias do PATH sao ignoradas na listagem.
echo.
powershell -NoProfile -Command "Write-Host '--- PATH da MAQUINA ---'; [Environment]::GetEnvironmentVariable('PATH','Machine') -split ';' | Where-Object { $_ } | ForEach-Object { '  ' + $_ }; Write-Host '--- PATH do USUARIO ---'; [Environment]::GetEnvironmentVariable('PATH','User') -split ';' | Where-Object { $_ } | ForEach-Object { '  ' + $_ }"
echo.
if errorlevel 1 (echo [ERRO] Falha ao ler o PATH.) else (echo Feito. PATH listado acima.)
:fim
echo.
pause
