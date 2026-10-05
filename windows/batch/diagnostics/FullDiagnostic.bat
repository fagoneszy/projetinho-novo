:: ============================================================
:: BATLAB | FullDiagnostic.bat | v1.0.0
:: @desc      Bateria de verificacoes somente-leitura salvas em Relatorios\AAAA-MM-DD
:: @category  diagnostics
:: @admin     yes
:: @risk      medium
:: @undo      N/A - somente leitura; apague a pasta Relatorios gerada
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - FullDiagnostic
echo ============================================
echo  BATLAB - FullDiagnostic
echo ============================================
net session >nul 2>&1
if errorlevel 1 (echo [ERRO] Execute como Administrador. & pause & exit /b 1)
for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd"') do set "D=%%i"
set "OUT=%CD%\Relatorios\%D%"
echo [PLANO] Vai criar a pasta %OUT% e gravar relatorios SOMENTE-LEITURA:
echo   01-discos.txt        Get-PhysicalDisk e espaco em volume
echo   02-rede.txt          ipconfig /all + netstat -ano
echo   03-eventos.txt       erros e avisos dos ultimos 7 dias
echo   04-servicos.txt      servicos automaticos que estao parados
echo   05-contas.txt        contas locais e grupo administradores
echo   06-inicializacao.txt chaves Run e tarefas agendadas
echo [ATENCAO] Nenhuma configuracao sera alterada e nada sera apagado.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
if not exist "%OUT%" mkdir "%OUT%"
if not exist "%OUT%" (echo [ERRO] Nao foi possivel criar a pasta de saida. & goto :fim)
powershell -NoProfile -Command "Get-PhysicalDisk | Format-Table FriendlyName,HealthStatus,OperationalStatus -AutoSize -Wrap; Get-CimInstance Win32_LogicalDisk -Filter 'DriveType=3' | Select-Object DeviceID,FreeSpace,Size | Format-Table -AutoSize" > "%OUT%\01-discos.txt"
if errorlevel 1 echo [AVISO] Falha ao gerar 01-discos.txt
ipconfig /all > "%OUT%\02-rede.txt"
netstat -ano >> "%OUT%\02-rede.txt"
powershell -NoProfile -Command "Get-WinEvent -FilterHashtable @{LogName='System'; Level=1,2,3; StartTime=(Get-Date).AddDays(-7)} -MaxEvents 50 | Format-List TimeCreated,Id,ProviderName,Message" > "%OUT%\03-eventos.txt"
powershell -NoProfile -Command "Get-Service | Where-Object { $_.StartType -eq 'Automatic' -and $_.Status -eq 'Stopped' } | Format-Table Name,DisplayName -AutoSize" > "%OUT%\04-servicos.txt"
net user > "%OUT%\05-contas.txt"
net localgroup administrators >> "%OUT%\05-contas.txt"
reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" > "%OUT%\06-inicializacao.txt"
schtasks /query /fo TABLE >> "%OUT%\06-inicializacao.txt"
echo [OK] Relatorios gravados em: %OUT%
echo [OK] Arquivos gerados:
dir /b "%OUT%"
:fim
echo.
pause