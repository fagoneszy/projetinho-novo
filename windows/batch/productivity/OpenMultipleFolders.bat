:: ============================================================
:: BATLAB | OpenMultipleFolders.bat | v1.0.0
:: @desc      Abre varias pastas de uma vez (recebe caminhos como argumento)
:: @category  productivity
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenMultipleFolders
echo ============================================
echo  BATLAB - OpenMultipleFolders
echo ============================================
if not "%~1"=="" (
    for %%D in (%*) do start "" explorer "%%D"
    echo Pastas abertas: %*
    goto :fim
)
start "" "%USERPROFILE%\Documents"
start "" "%USERPROFILE%\Downloads"
start "" "%USERPROFILE%\Pictures"
echo Abertas: Documents, Downloads, Pictures
echo Dica: passe caminhos como argumento para abrir outros.
:fim
echo.
pause