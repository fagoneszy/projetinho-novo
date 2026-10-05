:: ============================================================
:: BATLAB | OpenSoundSettings.bat | v1.0.0
:: @desc      Abre som (mmsys.cpl)
:: @category  everyday
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A - somente abre uma janela
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenSoundSettings
echo ============================================
echo  BATLAB - OpenSoundSettings
echo ============================================
echo Abrindo as configuracoes de som...
if not exist "%SystemRoot%\System32\mmsys.cpl" (
    echo [ERRO] mmsys.cpl nao encontrado.
    goto :fim
)
start "" control.exe mmsys.cpl
if errorlevel 1 (
    echo [ERRO] Falha ao abrir o painel de som.
    goto :fim
)
echo [OK] Dispositivos de reproducao e gravacao abertos.
echo [Dica] Teste o microfone na aba Gravacao.
echo Feito.
:fim
echo.
pause
