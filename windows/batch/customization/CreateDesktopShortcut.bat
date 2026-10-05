:: ============================================================
:: BATLAB | CreateDesktopShortcut.bat | v1.0.0
:: @desc      Cria um atalho na area de trabalho (arg: caminho do alvo)
:: @category  customization
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      Exclua o arquivo .lnk criado na area de trabalho
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - CreateDesktopShortcut
echo ============================================
echo  BATLAB - CreateDesktopShortcut
echo ============================================
set "ALVO=%~1"
if "%ALVO%"=="" (
    echo [ERRO] Informe o caminho do alvo.
    echo Exemplo: CreateDesktopShortcut.bat "C:\Windows\System32\notepad.exe"
    goto :fim
)
if not exist "%ALVO%" (
    echo [AVISO] O caminho nao existe: %ALVO%
    echo O atalho sera criado mesmo assim.
)
set "DEST=%USERPROFILE%\Desktop"
echo Criando atalho na area de trabalho:
echo   Alvo: %ALVO%
echo   Destino: %DEST%
powershell -NoProfile -Command "$w=New-Object -ComObject WScript.Shell; $n=[System.IO.Path]::GetFileNameWithoutExtension($env:ALVO); $p=Join-Path $env:DEST ($n + '.lnk'); $s=$w.CreateShortcut($p); $s.TargetPath=$env:ALVO; $s.WorkingDirectory=[System.IO.Path]::GetDirectoryName($env:ALVO); $s.Save()"
if errorlevel 1 (echo [ERRO] Falha ao criar o atalho. & goto :fim)
echo Atalho criado com sucesso.
echo Feito.
:fim
echo.
pause
