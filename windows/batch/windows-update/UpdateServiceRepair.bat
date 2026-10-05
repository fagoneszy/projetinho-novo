:: ============================================================
:: BATLAB | UpdateServiceRepair.bat | v1.0.0
:: @desc      Reinicia os servicos do Windows Update para destravar atualizacoes
:: @category  windows-update
:: @platform  windows
:: @admin     yes
:: @risk      medium
:: @writes none
:: @deletes none
:: @registry none
:: @services write
:: @tasks none
:: @network none
:: @restart none
:: @undo      Servicos reiniciados: estado volta ao normal em segundos, nada permanente mudou
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - UpdateServiceRepair
echo ============================================
echo  BATLAB - UpdateServiceRepair
echo ============================================
net session >nul 2>&1
if errorlevel 1 (
  echo [ERRO] Precisa de administrador para parar/ iniciar servicos.
  echo        Clique com botao direito > Executar como administrador.
  goto :fim
)
echo [ATENCAO] Vai parar e reiniciar os servicos BITS e Windows Update.
echo Nenhuma instalacao em andamento deve existir neste momento.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
echo.
echo Parando servicos...
net stop wuauserv /y >nul 2>&1
net stop bits /y >nul 2>&1
echo Iniciando servicos...
net start bits >nul 2>&1
net start wuauserv >nul 2>&1
echo.
sc query wuauserv | findstr /i "STATE"
sc query bits | findstr /i "STATE"
echo.
echo Pronto. Se a atualizacao continuar travada, reinicie o PC e tente de novo.
:fim
echo.
pause
