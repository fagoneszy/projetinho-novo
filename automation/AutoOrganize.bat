:: ============================================================
:: BATLAB | AutoOrganize.bat | v1.0.0
:: @desc      Organiza os arquivos da pasta em Imagens, Videos, Documentos e Outros
:: @category  automation
:: @admin     no
:: @risk      medium
:: @undo      Mova os arquivos de volta para a raiz
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - AutoOrganize
echo ============================================
echo  BATLAB - AutoOrganize
echo ============================================
echo [ATENCAO] Vai mover os arquivos desta pasta para subpastas:
echo    Imagens  Videos  Documentos  Outros
echo Arquivos ja organizados nao serao tocados.
choice /c SN /m "Organizar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
powershell -NoProfile -Command "$img='.jpg','.jpeg','.png','.gif','.bmp','.webp','.svg'; $vid='.mp4','.mkv','.avi','.mov','.wmv','.flv'; $doc='.pdf','.doc','.docx','.xls','.xlsx','.ppt','.pptx','.txt','.csv'; $n=0; Get-ChildItem -File | ForEach-Object { $f=$_; $e=$f.Extension.ToLower(); $c='Outros'; if($img -contains $e){$c='Imagens'} elseif($vid -contains $e){$c='Videos'} elseif($doc -contains $e){$c='Documentos'}; if($c -ne 'Outros'){ if(-not (Test-Path $c)){ New-Item -ItemType Directory -Path $c | Out-Null }; Move-Item -LiteralPath $f.FullName -Destination $c; $n++ } }; Write-Host ('Movidos: ' + $n + ' arquivo(s)')"
echo Obs: arquivos nao listados ficaram na raiz como Outros.
:fim
echo.
pause