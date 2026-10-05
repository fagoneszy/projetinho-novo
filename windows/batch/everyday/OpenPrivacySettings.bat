:: ============================================================
:: BATLAB | OpenPrivacySettings.bat | v1.0.0
:: @desc      Abre privacidade (ms-settings:privacy)
:: @category  everyday
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A - somente abre uma janela
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenPrivacySettings
echo ============================================
echo  BATLAB - OpenPrivacySettings
echo ============================================
echo Abrindo as configuracoes de privacidade...
start "" ms-settings:privacy
if errorlevel 1 (
    echo [ERRO] Nao foi possivel abrir as configuracoes de privacidade.
    goto :fim
)
echo [OK] Privacidade e Seguranca abertas.
echo [Dica] Revise: localizacao, camera e microfone.
echo Feito.
:fim
echo.
pause
