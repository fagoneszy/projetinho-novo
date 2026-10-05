:: ============================================================
:: BATLAB | HideHiddenFiles.bat | v1.0.0
:: @desc      Oculta arquivos ocultos no Explorer
:: @category  customization
:: @platform windows
:: @admin     no
:: @risk      medium
:: @writes none
:: @deletes none
:: @registry write
:: @services none
:: @tasks none
:: @network none
:: @restart none
:: @undo      Execute ShowHiddenFiles.bat (valor Hidden=1)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - HideHiddenFiles
echo ============================================
echo  BATLAB - HideHiddenFiles
echo ============================================
set "KEY=HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
echo [ATENCAO] O Explorer deixara de exibir arquivos ocultos.
echo O registro do usuario sera alterado:
echo   %KEY%\Hidden = 2
echo.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
reg add "%KEY%" /v Hidden /t REG_DWORD /d 2 /f >nul
if errorlevel 1 (echo [ERRO] Falha ao alterar o registro. & goto :fim)
echo Arquivos ocultos agora ficaram ocultos.
echo [!] Abra uma nova janela do Explorer para ver o efeito.
echo [Dica] Voce ainda pode acessa-los digitando o caminho direto.
:fim
echo.
pause
