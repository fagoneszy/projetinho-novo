:: ============================================================
:: BATLAB | SafeModeHelper.bat | v1.0.0
:: @desc      Agenda entrada em modo seguro com confirmacao
:: @category  windows-update
:: @platform  windows
:: @admin     yes
:: @risk      medium
:: @writes system
:: @deletes none
:: @registry write
:: @services none
:: @tasks none
:: @network none
:: @restart none
:: @undo      bcdedit /deletevalue {current} safeboot (rode a opcao desativar)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - SafeModeHelper
echo ============================================
echo  BATLAB - SafeModeHelper
echo ============================================
net session >nul 2>&1
if errorlevel 1 (
  echo [ERRO] Precisa de administrador para alterar o modo seguro no BCD.
  echo        Clique com botao direito e escolha Executar como administrador.
  goto :fim
)
echo [ATENCAO] A opcao 2 faz o Windows iniciar em MODO SEGURO na proxima reiniciada.
echo 1 - Mostrar status atual do modo seguro
echo 2 - Ativar modo seguro - proxima inicializacao em modo seguro
echo 3 - Desativar modo seguro - volta ao normal
choice /c 123 /m "Escolha (1/2/3)"
if errorlevel 3 goto DESAT
if errorlevel 2 goto ATIV
powershell -NoProfile -Command "$o = & bcdedit.exe /enum '{current}' 2>&1; $c=$LASTEXITCODE; $t=''+($o -join ' '); if($c -ne 0){ Write-Host 'Falha ao ler a configuracao de inicializacao.' } elseif($t -match 'safeboot'){ Write-Host 'Modo seguro: ATIVADO - o Windows inicia em modo seguro.' } else { Write-Host 'Modo seguro: DESATIVADO - inicializacao normal.' }"
goto :fim
:ATIV
echo [ATENCAO] Depois do reinicio o Windows abre em modo seguro. Para voltar ao normal rode este script e escolha a opcao 3.
choice /c SN /m "Ativar modo seguro agora? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
bcdedit /set {current} safeboot minimal
if errorlevel 1 (echo [ERRO] Falha ao ativar o modo seguro.) else (echo [OK] Modo seguro ATIVADO. Reinicie o PC para entrar.)
goto :fim
:DESAT
bcdedit /deletevalue {current} safeboot
if errorlevel 1 (echo [ERRO] Nada para desativar ou falha de permissao.) else (echo [OK] Modo seguro DESATIVADO. Inicializacao normal.)
goto :fim
:fim
echo.
pause
endlocal
