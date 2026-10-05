:: ============================================================
:: BATLAB | EmergencyDiagnostics.bat | v1.0.0
:: @desc      Coleta relatorios em um pacote ZIP
:: @category  system-diagnosis
:: @platform  windows
:: @admin     yes
:: @risk      medium
:: @writes user
:: @deletes none
:: @registry none
:: @services read
:: @tasks read
:: @network read
:: @restart none
:: @undo      Apague o ZIP gerado na pasta atual
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - EmergencyDiagnostics
echo ============================================
echo  BATLAB - EmergencyDiagnostics
echo ============================================
net session >nul 2>&1
if errorlevel 1 (echo [ERRO] Execute como Administrador. & pause & exit /b 1)
for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMdd-HHmm"') do set "Z=BATLAB-diagnostico-%%i.zip"
echo [PLANO] Vai gerar o pacote %Z% na pasta atual com relatorios SOMENTE-LEITURA:
echo   01-sistema.txt      sistema, maquina e versao do Windows
echo   02-rede.txt         ipconfig completo
echo   03-servicos.txt     servicos e status
echo   04-tarefas.txt      tarefas agendadas
echo   05-eventos.txt      erros e avisos dos ultimos 7 dias
echo [ATENCAO] Nenhuma configuracao sera alterada e nada sera apagado.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
powershell -NoProfile -Command "$d=$env:TEMP+'\batlab-emergencia'; New-Item -ItemType Directory -Force -Path $d | Out-Null; function W($n,$c){ [IO.File]::WriteAllText($d+'\'+$n,($c | Out-String)) }; try { W '01-sistema.txt' ((Get-CimInstance Win32_OperatingSystem) + (Get-CimInstance Win32_ComputerSystem)) } catch { W '01-sistema.txt' 'indisponivel' }; try { W '02-rede.txt' ((ipconfig /all | Out-String)) } catch { W '02-rede.txt' 'indisponivel' }; try { W '03-servicos.txt' (Get-Service | Sort-Object Status,Name | Select-Object Status,Name,DisplayName) } catch { W '03-servicos.txt' 'indisponivel' }; try { W '04-tarefas.txt' ((schtasks /query /fo TABLE | Out-String)) } catch { W '04-tarefas.txt' 'indisponivel' }; try { W '05-eventos.txt' (Get-WinEvent -FilterHashtable @{LogName='System'; Level=1,2; StartTime=(Get-Date).AddDays(-7)} -MaxEvents 50 -ErrorAction Stop | Select-Object TimeCreated,Id,ProviderName) } catch { W '05-eventos.txt' 'nenhum evento' }; try { Compress-Archive -Path ($d+'\*') -DestinationPath '%Z%' -Force; Write-Host ('Pacote gerado: %Z%') } catch { Write-Host 'Falha ao gerar o pacote.' }"
if exist "%Z%" (echo [OK] Relatorio completo em %Z%) else (echo [ERRO] Nao foi possivel criar o ZIP.)
:fim
echo.
pause
endlocal
