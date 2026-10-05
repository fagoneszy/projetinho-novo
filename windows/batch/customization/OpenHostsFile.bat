:: ============================================================
:: BATLAB | OpenHostsFile.bat | v1.0.0
:: @desc      Abre o arquivo hosts no Bloco de Notas como administrador
:: @category  customization
:: @admin     yes
:: @risk      medium
:: @undo      Feche o Bloco de Notas sem salvar ou restaure o backup manual do arquivo hosts
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenHostsFile
echo ============================================
echo  BATLAB - OpenHostsFile
echo ============================================
net session >nul 2>&1
if errorlevel 1 (
    echo [!] Este script precisa de elevacao. Solicitando ao Windows...
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs" 2>nul
    echo Se o UAC for confirmado, uma nova janela sera aberta.
    goto :fim
)
set "HOSTS=%SystemRoot%\System32\drivers\etc\hosts"
echo [ATENCAO] O arquivo hosts sera aberto no Bloco de Notas
echo           com privilÃ©gios de administrador.
echo Caminho: %HOSTS%
echo Nada sera salvo sem a sua acao dentro do Bloco de Notas.
echo.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
powershell -NoProfile -Command "Start-Process notepad -Verb RunAs -ArgumentList '%SystemRoot%\System32\drivers\etc\hosts'"
if errorlevel 1 (echo [ERRO] Falha ao abrir o Bloco de Notas com elevacao.) else (echo Bloco de Notas solicitado como administrador.)
echo [Dica] Faca backup do arquivo antes de editar.
:fim
echo.
pause