:: ============================================================
:: BATLAB | NetworkReset.bat | v1.0.0
:: @desc      Reseta Winsock e TCP/IP do Windows (requer Administrador)
:: @category  network
:: @admin     yes
:: @risk      high
:: @undo      Reiniciar o computador; para desfazer use um ponto de restauracao do sistema
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - NetworkReset
echo ============================================
echo  BATLAB - NetworkReset
echo ============================================
net session >nul 2>&1
if errorlevel 1 (echo [ERRO] Execute como Administrador. & pause & exit /b 1)
if /i "%~1"=="/dryrun" goto dry
echo ============================================================
echo  [ATENCAO] ESTE SCRIPT REDEFINE A PILHA DE REDE DO WINDOWS
echo ============================================================
echo O que sera afetado:
echo   1. Catalogo Winsock  - netsh winsock reset
echo   2. Protocolo TCP/IP  - netsh int ip reset
echo   3. Enderecos IP      - ipconfig /release e /renew
echo   4. Cache DNS         - ipconfig /flushdns
echo [!] O REINICIO do computador e obrigatorio ao final.
echo [!] A conexao sem fio pode precisar ser reconectada.
echo [!] Se houver VPN ou IP estatico, reconfigure depois do reset.
choice /c SN /m "Primeira confirmacao: redefinir a rede? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
choice /c SN /m "Segunda confirmacao: tem certeza? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
echo.
echo Executando o reset...
netsh winsock reset
if errorlevel 1 (echo [!] winsock reset retornou erro.)
netsh int ip reset
if errorlevel 1 (echo [!] int ip reset retornou erro.)
ipconfig /release
ipconfig /renew
ipconfig /flushdns
echo.
echo [OK] Reset concluido. REINICIE o computador para aplicar.
echo [i] Rotas e DNS atuais foram regerados pelo sistema.
goto :fim
:dry
echo [DRYRUN] Nenhuma alteracao foi feita neste modo.
echo O que seria executado:
echo   - netsh winsock reset
echo   - netsh int ip reset
echo   - ipconfig /release
echo   - ipconfig /renew
echo   - ipconfig /flushdns
echo   - Reinicio obrigatorio do computador
echo [i] Uso: NetworkReset.bat /dryrun
:fim
echo.
pause