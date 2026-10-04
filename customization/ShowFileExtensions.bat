:: ============================================================
:: BATLAB | ShowFileExtensions.bat | v1.0.0
:: @desc      Mostra as extensoes de arquivo
:: @category  customization
:: @admin     no
:: @risk      medium
:: @undo      Execute HideFileExtensions.bat (valor HideFileExt=1)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - ShowFileExtensions
echo ============================================
echo  BATLAB - ShowFileExtensions
echo ============================================
set "KEY=HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
echo [ATENCAO] O Explorer passara a exibir as extensoes dos arquivos.
echo O registro do usuario sera alterado:
echo   %KEY%\HideFileExt = 0
echo.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
reg add "%KEY%" /v HideFileExt /t REG_DWORD /d 0 /f >nul
if errorlevel 1 (echo [ERRO] Falha ao alterar o registro. & goto :fim)
echo Extensoes de arquivo agora serao exibidas.
echo [!] Abra uma nova janela do Explorer para ver o efeito.
echo [Dica] Isso ajuda a identificar arquivos suspeitos.exe.
:fim
echo.
pause