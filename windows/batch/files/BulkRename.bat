:: ============================================================
:: BATLAB | BulkRename.bat | v1.0.0
:: @desc      Renomeia arquivos em massa aplicando um padrao
:: @category  files
:: @platform windows
:: @admin     no
:: @risk      medium
:: @writes user
:: @deletes none
:: @registry none
:: @services none
:: @tasks none
:: @network none
:: @restart none
:: @undo      Renomeie os arquivos de volta para os nomes originais
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - BulkRename
echo ============================================
echo  BATLAB - BulkRename
echo ============================================
set "PREFIX=%~1"
if not defined PREFIX set /p "PREFIX=Prefixo novo para os arquivos: "
if not defined PREFIX (echo [ERRO] Prefixo nao informado. & goto :fim)
set /a COUNT=0
for /f "delims=" %%f in ('dir /b /a-d 2^>nul') do set /a COUNT+=1
if %COUNT%==0 (echo [!] Nenhum arquivo na pasta atual. & goto :fim)
echo [ATENCAO] %COUNT% arquivo(s) serao RENOMEADOS.
echo Novo nome = PREFIXO + numero + extensao. Ex: %PREFIX%1.txt e %PREFIX%2.pdf
echo Pasta: %CD%
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
setlocal EnableDelayedExpansion
set /a N=0
for /f "delims=" %%f in ('dir /b /a-d 2^>nul') do (
  set /a N+=1
  ren "%%f" "!PREFIX!!N!%%~xf"
)
echo Feito. %COUNT% arquivo(s) renomeado(s): !PREFIX!1 ... !PREFIX!!N!
:fim
echo.
pause
