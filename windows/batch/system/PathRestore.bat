:: ============================================================
:: BATLAB | PathRestore.bat | v1.0.0
:: @desc      Restaura o PATH a partir de um arquivo de backup
:: @category  system
:: @admin     yes
:: @risk      medium
:: @undo      Restaure o PATH de outro arquivo de backup com PathBackup
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - PathRestore
echo ============================================
echo  BATLAB - PathRestore
echo ============================================
net session >nul 2>&1
if errorlevel 1 (echo [ERRO] Execute como Administrador. & pause & exit /b 1)
set "SRC=%~1"
if not defined SRC set /p "SRC=Arquivo de backup do PATH: "
if not defined SRC (echo [ERRO] Arquivo nao informado. & goto :fim)
if not exist "%SRC%" (echo [ERRO] Arquivo nao encontrado: %SRC% & goto :fim)
echo [ATENCAO] O PATH sera SUBSTITUIDO pelo conteudo do arquivo.
echo Arquivo: %SRC%
echo O arquivo precisa de 2 linhas: linha 1 = PATH da maquina, linha 2 = do usuario.
echo [!] O arquivo nao pode ter quebras estranhas, aspas ou linhas a mais.
echo Conteudo atual do arquivo:
type "%SRC%"
echo.
choice /c SN /m "Restaurar o PATH deste arquivo? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
powershell -NoProfile -Command "$l=@(Get-Content -LiteralPath '%SRC%'); if($l.Count -lt 2){ Write-Host 'ERRO: o arquivo precisa de 2 linhas.'; exit 1 }; [Environment]::SetEnvironmentVariable('PATH',$l[0],'Machine'); [Environment]::SetEnvironmentVariable('PATH',$l[1],'User'); Write-Host 'PATH restaurado via PowerShell (sem limite de 1024 chars do setx).'"
if errorlevel 1 (echo [ERRO] Falha ao restaurar - confira o formato do arquivo.) else (echo Feito. PATH restaurado - abra novas janelas para efeito.)
:fim
echo.
pause