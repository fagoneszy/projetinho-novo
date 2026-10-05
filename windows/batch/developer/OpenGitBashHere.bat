:: ============================================================
:: BATLAB | OpenGitBashHere.bat | v1.0.0
:: @desc      Abre o Git Bash na pasta atual
:: @category  developer
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenGitBashHere
echo ============================================
echo  BATLAB - OpenGitBashHere
echo ============================================
set "GB="
if exist "%ProgramFiles%\Git\git-bash.exe" set "GB=%ProgramFiles%\Git\git-bash.exe"
if exist "%ProgramFiles(x86)%\Git\git-bash.exe" set "GB=%ProgramFiles(x86)%\Git\git-bash.exe"
if defined GB goto abre
where bash >nul 2>&1
if errorlevel 1 (echo [ERRO] Git nao encontrado. Instale o Git for Windows. & goto :fim)
echo [!] git-bash.exe nao localizado; abrindo o bash do PATH.
start "" cmd /k bash --login
goto :fim
:abre
echo Abrindo Git Bash em %CD%...
start "" "%GB%" --cd="%CD%"
if errorlevel 1 (echo [!] Falha ao abrir o Git Bash. & goto :fim)
echo [OK] Git Bash aberto na pasta atual.
:fim
echo.
pause
