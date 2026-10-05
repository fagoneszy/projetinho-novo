:: ============================================================
:: BATLAB | GitBackup.bat | v1.0.0
:: @desc      Faz add, commit e push em um unico passo
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
:: @undo      git reset --soft HEAD~1 e git push --force apenas se necessario
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - GitBackup
echo ============================================
echo  BATLAB - GitBackup
echo ============================================
echo [ATENCAO] Vai executar em sequencia: git add -A, git commit e git push.
echo Repo: %CD%
where git >nul 2>&1
if errorlevel 1 (echo [ERRO] git nao encontrado no PATH. & goto :fim)
git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (echo [ERRO] Esta pasta nao e um repositorio Git. & goto :fim)
echo Arquivos que serao enviados:
git status --short
git remote | findstr /i "." >nul 2>&1
if errorlevel 1 (echo [ERRO] Nenhum remoto configurado - use git remote add. & goto :fim)
choice /c SN /m "Adicionar, commitar e enviar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
set "MSG=%~1"
if not defined MSG set "MSG=Backup automatico %DATE% %TIME%"
git add -A
if errorlevel 1 (echo [ERRO] Falha no git add. & goto :fim)
git commit -m "%MSG%"
if errorlevel 1 echo [!] Nada para commitar; seguindo para o push.
git push
if errorlevel 1 (echo [ERRO] git push falhou. Verifique remoto e autenticacao. & goto :fim)
echo.
echo [OK] Backup concluido: %MSG%
echo [i] Desfazer: git reset --soft HEAD~1 (antes do push).
:fim
echo.
pause
