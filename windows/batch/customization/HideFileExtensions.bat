:: ============================================================
:: BATLAB | HideFileExtensions.bat | v1.0.0
:: @desc      Oculta as extensoes de arquivo
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
:: @undo      Execute ShowFileExtensions.bat (valor HideFileExt=0)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - HideFileExtensions
echo ============================================
echo  BATLAB - HideFileExtensions
echo ============================================
set "KEY=HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
echo [ATENCAO] O Explorer deixara de exibir as extensoes dos arquivos.
echo O registro do usuario sera alterado:
echo   %KEY%\HideFileExt = 1
echo.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
reg add "%KEY%" /v HideFileExt /t REG_DWORD /d 1 /f >nul
if errorlevel 1 (echo [ERRO] Falha ao alterar o registro. & goto :fim)
echo Extensoes de arquivo agora ficaram ocultas.
echo [!] Abra uma nova janela do Explorer para ver o efeito.
echo [Dica] Mostrar as extensoes e mais seguro para identificar .exe.
:fim
echo.
pause
