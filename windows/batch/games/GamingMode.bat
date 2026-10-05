:: ============================================================
:: BATLAB | GamingMode.bat | v1.0.0
:: @desc      Fecha aplicativos pesados antes de jogar
:: @category  games
:: @platform windows
:: @admin     no
:: @risk      medium
:: @writes none
:: @deletes none
:: @registry none
:: @services none
:: @tasks none
:: @network none
:: @restart process
:: @undo      Abra novamente o que foi fechado
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - GamingMode
echo ============================================
echo  BATLAB - GamingMode
echo ============================================
echo [ATENCAO] Vai encerrar, se abertos: chrome.exe, msedge.exe, firefox.exe, spotify.exe
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
for %%P in (chrome.exe msedge.exe firefox.exe spotify.exe) do (
    taskkill /IM %%P /F >nul 2>&1 && echo   Encerrado: %%P
)
echo Modo jogo liberado de recursos.
:fim
echo.
pause
