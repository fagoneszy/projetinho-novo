:: ============================================================
:: BATLAB | CleanBuild.bat | v1.0.0
:: @desc      Remove pastas de build e dependencias do projeto
:: @category  developer
:: @platform windows
:: @admin     no
:: @risk      medium
:: @writes none
:: @deletes files
:: @registry none
:: @services none
:: @tasks none
:: @network none
:: @restart none
:: @undo      Recriado no proximo build
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - CleanBuild
echo ============================================
echo  BATLAB - CleanBuild
echo ============================================
echo [ATENCAO] Vai remover pastas de build e dependencias locais.
set "TEM=0"
if exist "build" set "TEM=1"
if exist "dist" set "TEM=1"
if exist "node_modules" set "TEM=1"
if exist "target" set "TEM=1"
if exist "__pycache__" set "TEM=1"
if "%TEM%"=="0" (echo [i] Nenhum alvo encontrado nesta pasta. & goto :fim)
echo Alvos que serao removidos:
if exist "build" echo   - build
if exist "dist" echo   - dist
if exist "node_modules" echo   - node_modules
if exist "target" echo   - target
if exist "__pycache__" echo   - __pycache__
echo [!] O conteudo apagado e recriado no proximo build ou install.
choice /c SN /m "Remover estes diretorios? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
if exist "build" rmdir /s /q "build"
if exist "dist" rmdir /s /q "dist"
if exist "node_modules" rmdir /s /q "node_modules"
if exist "target" rmdir /s /q "target"
if exist "__pycache__" rmdir /s /q "__pycache__"
echo.
echo [OK] Limpeza concluida.
echo [i] Desfazer: recriado no proximo build (npm install, cargo build, make).
:fim
echo.
pause
