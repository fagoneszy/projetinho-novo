:: ============================================================
:: BATLAB | RestartNetwork.bat | v1.0.0
:: @desc      Desabilita e reabilita um adaptador de rede selecionado
:: @category  network
:: @platform windows
:: @admin     yes
:: @risk      medium
:: @writes none
:: @deletes none
:: @registry none
:: @services none
:: @tasks none
:: @network write
:: @restart none
:: @undo      Enable-NetAdapter para reabilitar o adaptador manualmente
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - RestartNetwork
echo ============================================
echo  BATLAB - RestartNetwork
echo ============================================
net session >nul 2>&1
if errorlevel 1 (echo [ERRO] Execute como Administrador. & pause & exit /b 1)
echo [ATENCAO] Vai DESABILITAR e depois REABILITAR um adaptador de rede.
echo Isso derruba a conexao do adaptador por alguns segundos.
echo Adaptadores atuais:
powershell -NoProfile -Command "Get-NetAdapter | Format-Table -AutoSize Name,Status,InterfaceDescription"
echo.
set "ADAP=%~1"
if not defined ADAP set /p "ADAP=Nome do adaptador (ex.: Ethernet): "
if not defined ADAP (echo [ERRO] Nenhum adaptador informado. & goto :fim)
choice /c SN /m "Reiniciar o adaptador %ADAP%? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
echo Desabilitando %ADAP%...
powershell -NoProfile -Command "Disable-NetAdapter -Name '%ADAP%' -Confirm:$false"
if errorlevel 1 (echo [ERRO] Falha ao desabilitar %ADAP%. & goto :fim)
echo Adaptador desabilitado. Reabilitando em 3 segundos...
timeout /t 3 /nobreak >nul
powershell -NoProfile -Command "Enable-NetAdapter -Name '%ADAP%' -Confirm:$false"
if errorlevel 1 (echo [ERRO] Falha ao reabilitar %ADAP%. & goto :fim)
echo.
echo [OK] Adaptador %ADAP% reiniciado.
echo [i] Se caiu, reabra o script e use o nome certo da lista.
:fim
echo.
pause
