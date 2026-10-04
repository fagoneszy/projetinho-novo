:: ============================================================
:: BATLAB | ShowHiddenFiles.bat | v1.0.0
:: @desc      Mostra arquivos ocultos no Explorer
:: @category  customization
:: @admin     no
:: @risk      medium
:: @undo      Execute HideHiddenFiles.bat (valor Hidden=2)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - ShowHiddenFiles
echo ============================================
echo  BATLAB - ShowHiddenFiles
echo ============================================
set "KEY=HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
echo [ATENCAO] O Explorer passara a exibir arquivos ocultos.
echo O registro do usuario sera alterado:
echo   %KEY%\Hidden = 1
echo.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
reg add "%KEY%" /v Hidden /t REG_DWORD /d 1 /f >nul
if errorlevel 1 (echo [ERRO] Falha ao alterar o registro. & goto :fim)
echo Arquivos ocultos agora serao exibidos.
echo [!] Abra uma nova janela do Explorer para ver o efeito.
echo [Dica] Arquivos ocultos do sistema continuam protegidos.
:fim
echo.
pause