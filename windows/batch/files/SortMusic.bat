:: ============================================================
:: BATLAB | SortMusic.bat | v1.0.0
:: @desc      Separa as musicas em uma pasta Musicas
:: @category  files
:: @admin     no
:: @risk      medium
:: @undo      Mova os arquivos da pasta Musicas de volta
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - SortMusic
echo ============================================
echo  BATLAB - SortMusic
echo ============================================
set /a COUNT=0
for /f "delims=" %%f in ('dir /b /a-d *.mp3 *.wav *.flac *.aac *.ogg *.m4a *.wma 2^>nul') do set /a COUNT+=1
if %COUNT%==0 (echo [!] Nenhuma musica encontrada nesta pasta. & goto :fim)
echo [ATENCAO] %COUNT% arquivo(s) de audio serao MOVIDOS para a subpasta Musicas.
echo   Extensoes: mp3 wav flac aac ogg m4a wma
echo   Origem: %CD%
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
if not exist "Musicas" mkdir "Musicas"
for %%e in (mp3 wav flac aac ogg m4a wma) do move /Y "*.%%e" "Musicas\" >nul 2>&1
if exist "Musicas\*" (echo Feito. Confera a pasta Musicas.) else (echo [!] Nada foi movido.)
:fim
echo.
pause