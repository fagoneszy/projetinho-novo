:: ============================================================
:: BATLAB | AutoDownloadOrganizer.bat | v1.0.0
:: @desc      Organiza a pasta Downloads em subpastas, repetindo
:: @category  automation
:: @admin     no
:: @risk      medium
:: @undo      Mova os arquivos de volta de Downloads
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - AutoDownloadOrganizer
echo ============================================
echo  BATLAB - AutoDownloadOrganizer
echo ============================================
set "SEG=900"
if not "%~1"=="" set "SEG=%~1"
echo(%SEG%| findstr /r "^[1-9][0-9][0-9]?[0-9]?$" >nul
if errorlevel 1 (echo Intervalo invalido: %SEG%. Use 1 a 9999 segundos. & goto :fim)
set "DL=%USERPROFILE%\Downloads"
if not exist "%DL%" (echo Pasta Downloads nao encontrada. & goto :fim)
echo [ATENCAO] Vai mover os arquivos de %DL% para subpastas:
echo    Imagens  Videos  Documentos  Compactados  Outros
echo Repetindo a cada %SEG% segundos. Ctrl+C para parar.
choice /c SN /m "Iniciar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
:loop
powershell -NoProfile -Command "$d='%DL%'; $img='.jpg','.jpeg','.png','.gif','.bmp','.webp','.svg'; $vid='.mp4','.mkv','.avi','.mov','.wmv'; $doc='.pdf','.doc','.docx','.xls','.xlsx','.ppt','.pptx','.txt','.csv'; $zip='.zip','.rar','.7z','.tar','.gz'; Get-ChildItem -File -LiteralPath $d | ForEach-Object { $e=$_.Extension.ToLower(); $c='Outros'; if($img -contains $e){$c='Imagens'} elseif($vid -contains $e){$c='Videos'} elseif($doc -contains $e){$c='Documentos'} elseif($zip -contains $e){$c='Compactados'}; $p=Join-Path $d $c; if(-not (Test-Path $p)){New-Item -ItemType Directory -Path $p | Out-Null}; Move-Item -LiteralPath $_.FullName -Destination $p -ErrorAction SilentlyContinue }"
echo [%time%] Downloads organizado.
timeout /t %SEG% /nobreak >nul
goto :loop
echo.
pause