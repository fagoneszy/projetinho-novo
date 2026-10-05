:: ============================================================
:: BATLAB | QuickNotes.bat | v1.0.0
:: @desc      Cria uma nota rapida na area de trabalho
:: @category  productivity
:: @admin     no
:: @risk      low
:: @undo      Apague a linha do arquivo Notas.txt
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - QuickNotes
echo ============================================
echo  BATLAB - QuickNotes
echo ============================================
set /p "NOTA=Nota: "
if not defined NOTA (echo Nada digitado. & goto :fim)
set "ARQ=%USERPROFILE%\Desktop\Notas.txt"
>>"%ARQ%" echo [%date% %time%] %NOTA%
echo Salvo em: %ARQ%
:fim
echo.
pause