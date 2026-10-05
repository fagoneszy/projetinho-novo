:: ============================================================
:: BATLAB | FocusMode.bat | v1.0.0
:: @desc      Fecha aplicativos de distracao e abre ferramentas de foco
:: @category  productivity
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
:: @undo      Abra manualmente o que foi fechado
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - FocusMode
echo ============================================
echo  BATLAB - FocusMode
echo ============================================
echo [ATENCAO] Vai encerrar (se abertos): discord.exe, steam.exe, spotify.exe
echo e abrir o bloco de notas para foco.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
for %%P in (discord.exe steam.exe spotify.exe) do (
    taskkill /IM %%P /F >nul 2>&1 && echo   Encerrado: %%P
)
start "" notepad
echo Modo foco ativo.
:fim
echo.
pause
