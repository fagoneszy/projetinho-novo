:: ============================================================
:: BATLAB | OpenTaskScheduler.bat | v1.0.0
:: @desc      Abre o Agendador de Tarefas
:: @category  customization
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenTaskScheduler
echo ============================================
echo  BATLAB - OpenTaskScheduler
echo ============================================
echo Abrindo o Agendador de Tarefas...
start "" "%WINDIR%\System32\taskschd.msc"
if errorlevel 1 (
    echo [ERRO] Nao foi possivel abrir o Agendador de Tarefas.
    goto :fim
)
echo Agendador de Tarefas solicitado.
echo [Dica] Tarefas criadas aparecem em Biblioteca do Agendador.
echo Feito.
:fim
echo.
pause
