:: ============================================================
:: BATLAB | NetworkEmergencyReset.bat | v1.0.0
:: @desc      Reset de emergencia da pilha de rede do Windows
:: @category  network-advanced
:: @platform windows
:: @admin     yes
:: @risk      high
:: @writes    none
:: @deletes   none
:: @registry  none
:: @services  write
:: @tasks     none
:: @network   write
:: @restart   none
:: @undo      Reiniciar o computador; em ultimo caso use um ponto de restauracao do sistema
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - NetworkEmergencyReset
echo ============================================
echo  BATLAB - NetworkEmergencyReset
echo ============================================
net session >nul 2>&1
if errorlevel 1 (echo [ERRO] Execute como Administrador. & pause & exit /b 1)
if /i "%~1"=="/dryrun" goto dry
echo ============================================================
echo  [ATENCAO] RESET DE EMERGENCIA DA REDE - leia antes de continuar
echo ============================================================
echo Sera executado, nesta ordem:
echo   1. ipconfig /flushdns    2. netsh winsock reset
echo   3. netsh int ip reset     4. reinicio do servico Dhcp
echo [!] O REINICIO do computador e obrigatorio ao final.
echo [!] Ajuste VPN e IP estatico depois do reset.
choice /c SN /m "Primeira confirmacao: resetar a rede agora? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
choice /c SN /m "Segunda confirmacao: tem certeza? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
echo [1/4] Limpando cache DNS... & ipconfig /flushdns
echo [2/4] Reconstruindo o catalogo Winsock... & netsh winsock reset
echo [3/4] Reconstruindo o protocolo TCP/IP... & netsh int ip reset
echo [4/4] Reiniciando o servico DHCP... & net stop Dhcp & net start Dhcp
echo.
echo [OK] Concluido. REINICIE o computador para aplicar.
goto :fim
:dry
echo [DRYRUN] Nenhuma alteracao foi feita neste modo.
echo ipconfig /flushdns, netsh winsock reset, netsh int ip reset,
echo reinicio do servico Dhcp e reinicio do sistema operacional.
echo [i] Uso: NetworkEmergencyReset.bat /dryrun
:fim
echo.
pause
