:: ============================================================
:: BATLAB | WindowsDefenderStatus.bat | v1.0.0
:: @desc      Status do Windows Defender (Get-MpComputerStatus)
:: @category  diagnostics
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - WindowsDefenderStatus
echo ============================================
echo  BATLAB - WindowsDefenderStatus
echo ============================================
echo Consultando o Windows Defender, aguarde...
echo.
powershell -NoProfile -Command "Get-MpComputerStatus | Select-Object AMServiceEnabled,AntivirusEnabled,AntispywareEnabled,RealTimeProtectionEnabled,AntivirusSignatureLastUpdated,AntivirusSignatureAge,QuickScanEndTime,FullScanEndTime | Format-List"
if errorlevel 1 (
    echo [ERRO] Falha ao consultar o Windows Defender.
    echo [!] O modulo WindowsDefender pode nao existir nesta maquina.
    goto :fim
)
echo [OK] Campos principais:
echo   RealTimeProtectionEnabled : protecao em tempo real ativa
echo   AntivirusSignatureAge     : dias desde a ultima atualizacao
echo   QuickScanEndTime          : ultimo scan rapido concluido
echo [Dica] Painel grafico: windowsdefender:
:fim
echo.
pause
