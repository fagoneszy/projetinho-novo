:: ============================================================
:: BATLAB | GitPush.bat | v1.0.0
:: @desc      Envia os commits locais com git push e reporta erro claro
:: @category  developer
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - GitPush
echo ============================================
echo  BATLAB - GitPush
echo ============================================
echo Enviando os commits locais (git push)...
where git >nul 2>&1
if errorlevel 1 (echo [ERRO] git nao encontrado no PATH. & goto :fim)
git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (echo [ERRO] Esta nao e um repositorio Git. & goto :fim)
git remote | findstr /i "." >nul 2>&1
if errorlevel 1 (echo [ERRO] Nenhum remoto configurado - use git remote add. & goto :fim)
echo.
git push
if errorlevel 1 (echo [ERRO] git push falhou. Verifique remoto e autenticacao. & goto :fim)
echo.
echo [OK] Push concluido.
echo Feito.
:fim
echo.
pause
