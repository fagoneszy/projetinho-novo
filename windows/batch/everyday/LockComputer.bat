:: ============================================================
:: BATLAB | LockComputer.bat | v1.0.0
:: @desc      Trava a estacao (rundll32.exe user32.dll,LockWorkStation)
:: @category  everyday
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      Ctrl+Alt+Del e informe a senha
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - LockComputer
echo ============================================
echo  BATLAB - LockComputer
echo ============================================
echo Trava a estacao de %USERNAME%...
rundll32.exe user32.dll,LockWorkStation
if errorlevel 1 (
    echo [ERRO] Falha ao travar a estacao.
    goto :fim
)
echo [OK] Estacao travada - a tela de bloqueio foi acionada.
echo [Dica] Nada e fechado; os programas continuam rodando.
echo Feito.
:fim
echo.
pause
