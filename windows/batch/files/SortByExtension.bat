:: ============================================================
:: BATLAB | SortByExtension.bat | v1.0.0
:: @desc      Organiza os arquivos em pastas por extensao
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
:: @undo      Mova os arquivos das subpastas de volta para a pasta raiz
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - SortByExtension
echo ============================================
echo  BATLAB - SortByExtension
echo ============================================
set /a COUNT=0
for /f "delims=" %%f in ('dir /b /a-d 2^>nul') do set /a COUNT+=1
if %COUNT%==0 (echo [!] Nenhum arquivo na pasta atual. & goto :fim)
echo [ATENCAO] %COUNT% arquivo(s) serao MOVIDOS para subpastas pela extensao.
echo Exemplo: txt\, jpg\, pdf\. Arquivos sem extensao vao para sem_extensao\
echo Pasta: %CD%
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
setlocal EnableDelayedExpansion
for /f "delims=" %%f in ('dir /b /a-d 2^>nul') do (
  set "EXT=%%~xf"
  if "!EXT!"=="" set "EXT=sem_extensao"
  if "!EXT!"=="." set "EXT=sem_extensao"
  if not "!EXT!"=="sem_extensao" set "EXT=!EXT:~1!"
  if not exist "!EXT!\" mkdir "!EXT!"
  move /Y "%%f" "!EXT!\" >nul
)
echo Feito. %COUNT% arquivo(s) organizado(s) por extensao.
:fim
echo.
pause
