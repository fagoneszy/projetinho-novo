:: ============================================================
:: BATLAB | SortVideos.bat | v1.0.0
:: @desc      Separa os videos em uma pasta Videos
:: @category  files
:: @admin     no
:: @risk      medium
:: @undo      Mova os arquivos da pasta Videos de volta
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - SortVideos
echo ============================================
echo  BATLAB - SortVideos
echo ============================================
set /a COUNT=0
for /f "delims=" %%f in ('dir /b /a-d *.mp4 *.mkv *.avi *.mov *.wmv *.flv *.webm *.m4v 2^>nul') do set /a COUNT+=1
if %COUNT%==0 (echo [!] Nenhum video encontrado nesta pasta. & goto :fim)
echo [ATENCAO] %COUNT% video(s) serao MOVIDOS para a subpasta Videos.
echo   Extensoes: mp4 mkv avi mov wmv flv webm m4v
echo   Origem: %CD%
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
if not exist "Videos" mkdir "Videos"
for %%e in (mp4 mkv avi mov wmv flv webm m4v) do move /Y "*.%%e" "Videos\" >nul 2>&1
if exist "Videos\*" (echo Feito. Confera a pasta Videos.) else (echo [!] Nada foi movido.)
:fim
echo.
pause