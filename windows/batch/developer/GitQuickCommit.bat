:: ============================================================
:: BATLAB | GitQuickCommit.bat | v1.0.0
:: @desc      Adiciona todos os arquivos e cria um commit automatico
:: @category  developer
:: @platform windows
:: @admin     no
:: @risk      medium
:: @writes none
:: @deletes none
:: @registry none
:: @services none
:: @tasks none
:: @network none
:: @restart none
:: @undo      git reset --soft HEAD~1 para desfazer o commit
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - GitQuickCommit
echo ============================================
echo  BATLAB - GitQuickCommit
echo ============================================
echo [ATENCAO] Vai executar git add -A e criar um commit automatico.
echo Arquivos que serao incluidos:
where git >nul 2>&1
if errorlevel 1 (echo [ERRO] git nao encontrado no PATH. & goto :fim)
git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (echo [ERRO] Esta pasta nao e um repositorio Git. & goto :fim)
git status --short
echo.
choice /c SN /m "Criar o commit com tudo adicionado? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
set "MSG=%~1"
if not defined MSG set "MSG=Atualizacao automatica %DATE% %TIME%"
git add -A
if errorlevel 1 (echo [ERRO] Falha no git add. & goto :fim)
git commit -m "%MSG%"
if errorlevel 1 (echo [!] Nada para commitar. & goto :fim)
echo.
echo [OK] Commit criado: %MSG%
echo [i] Desfazer: git reset --soft HEAD~1
:fim
echo.
pause
