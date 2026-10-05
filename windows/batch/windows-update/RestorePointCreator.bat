:: ============================================================
:: BATLAB | RestorePointCreator.bat | v1.0.0
:: @desc      Cria um ponto de restauracao
:: @category  windows-update
:: @platform  windows
:: @admin     yes
:: @risk      medium
:: @writes system
:: @deletes none
:: @registry none
:: @services none
:: @tasks none
:: @network none
:: @restart none
:: @undo      Ponto de restauracao criado; remova em Painel > Restauracao do sistema
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - RestorePointCreator
echo ============================================
echo  BATLAB - RestorePointCreator
echo ============================================
net session >nul 2>&1
if errorlevel 1 (
  echo [ERRO] Precisa de administrador para criar ponto de restauracao.
  echo        Clique com botao direito e escolha Executar como administrador.
  goto :fim
)
echo [ATENCAO] Vai criar um PONTO DE RESTAURACAO do sistema agora.
echo   Tipo: MODIFY_SETTINGS - configuracoes do Windows
echo   Local: disco do sistema - usa o espaco reservado de restauracao
echo   O Windows permite no maximo 1 ponto automatico por dia.
echo   Nada e apagado; o ponto fica em Restauracao do sistema.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
powershell -NoProfile -Command "try { Checkpoint-Computer -Description 'BATLAB - ponto criado manualmente' -RestorePointType MODIFY_SETTINGS -ErrorAction Stop; Write-Host '[OK] Ponto de restauracao criado com sucesso.' } catch { Write-Host ('[ERRO] '+$_.Exception.Message); Write-Host 'Se ja existe ponto recente, aguarde 24h e rode de novo.' }"
:fim
echo.
pause
endlocal
