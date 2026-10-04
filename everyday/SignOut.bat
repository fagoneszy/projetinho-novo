:: ============================================================
:: BATLAB | SignOut.bat | v1.0.0
:: @desc      Fecha a sessao (shutdown /l)
:: @category  everyday
:: @admin     no
:: @risk      medium
:: @undo      Refaca o login com sua senha
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - SignOut
echo ============================================
echo  BATLAB - SignOut
echo ============================================
echo [PLANO] Encerrar a sessao de %USERNAME% agora.
echo [PLANO] Todos os programas desta sessao serao fechados.
echo [PLANO] Depois basta entrar novamente com a sua senha.
echo [ATENCAO] Trabalho nao salvo sera perdido.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
shutdown /l
if errorlevel 1 (echo [ERRO] Falha ao encerrar a sessao. & goto :fim)
echo [OK] Sessao encerrada.
:fim
echo.
pause