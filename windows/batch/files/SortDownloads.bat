:: ============================================================
:: BATLAB | SortDownloads.bat | v1.0.0
:: @desc      Organiza a pasta Downloads por tipo de arquivo
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
:: @undo      Mova os arquivos das subpastas de volta para Downloads
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - SortDownloads
echo ============================================
echo  BATLAB - SortDownloads
echo ============================================
set "DL=%USERPROFILE%\Downloads"
if not exist "%DL%\" (echo [ERRO] Pasta Downloads nao encontrada. & goto :fim)
pushd "%DL%"
set /a COUNT=0
for /f "delims=" %%f in ('dir /b /a-d 2^>nul') do set /a COUNT+=1
echo [ATENCAO] %COUNT% arquivo(s) de %DL% serao movidos por tipo.
echo Subpastas: Imagens, Videos, Musicas, Documentos, Compactados, Instaladores, Outros
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & popd & goto :fim)
for %%d in (Imagens Videos Musicas Documentos Compactados Instaladores Outros) do if not exist "%%d" mkdir "%%d"
for %%e in (jpg jpeg png gif bmp webp svg ico tif tiff) do move /Y "*.%%e" "Imagens\" >nul 2>&1
for %%e in (mp4 mkv avi mov wmv flv webm m4v) do move /Y "*.%%e" "Videos\" >nul 2>&1
for %%e in (mp3 wav flac aac ogg m4a wma) do move /Y "*.%%e" "Musicas\" >nul 2>&1
for %%e in (doc docx pdf txt xls xlsx ppt pptx rtf odt csv) do move /Y "*.%%e" "Documentos\" >nul 2>&1
for %%e in (zip rar 7z tar gz bz2 xz) do move /Y "*.%%e" "Compactados\" >nul 2>&1
for %%e in (exe msi bat cmd ps1 reg) do move /Y "*.%%e" "Instaladores\" >nul 2>&1
for /f "delims=" %%f in ('dir /b /a-d 2^>nul') do move /Y "%%f" "Outros\" >nul 2>&1
popd
echo Feito. Confira a pasta Downloads.
:fim
echo.
pause
