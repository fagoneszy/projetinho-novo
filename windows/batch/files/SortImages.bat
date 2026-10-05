:: ============================================================
:: BATLAB | SortImages.bat | v1.0.0
:: @desc      Separa as imagens em uma pasta Imagens
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
:: @undo      Mova os arquivos da pasta Imagens de volta
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - SortImages
echo ============================================
echo  BATLAB - SortImages
echo ============================================
set /a COUNT=0
for /f "delims=" %%f in ('dir /b /a-d *.jpg *.jpeg *.png *.gif *.bmp *.webp *.svg *.ico *.tif *.tiff 2^>nul') do set /a COUNT+=1
if %COUNT%==0 (echo [!] Nenhuma imagem encontrada nesta pasta. & goto :fim)
echo [ATENCAO] %COUNT% imagem(ns) serao MOVIDAS para a subpasta Imagens.
echo   Extensoes: jpg jpeg png gif bmp webp svg ico tif tiff
echo   Origem: %CD%
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
if not exist "Imagens" mkdir "Imagens"
for %%e in (jpg jpeg png gif bmp webp svg ico tif tiff) do move /Y "*.%%e" "Imagens\" >nul 2>&1
if exist "Imagens\*" (echo Feito. Confera a pasta Imagens.) else (echo [!] Nada foi movido.)
:fim
echo.
pause
