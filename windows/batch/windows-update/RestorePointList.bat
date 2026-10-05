:: ============================================================
:: BATLAB | RestorePointList.bat | v1.0.0
:: @desc      Lista pontos de restauracao
:: @category  windows-update
:: @platform  windows
:: @admin     yes
:: @risk      low
:: @writes none
:: @deletes none
:: @registry none
:: @services none
:: @tasks none
:: @network none
:: @restart none
:: @undo      Somente leitura: nada a desfazer
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - RestorePointList
echo ============================================
echo  BATLAB - RestorePointList
echo ============================================
net session >nul 2>&1
if errorlevel 1 (
  echo [ERRO] Precisa de administrador para ler os pontos de restauracao.
  echo        Clique com botao direito e escolha Executar como administrador.
  goto :fim
)
powershell -NoProfile -Command "try { $r=@(Get-CimInstance -Namespace 'root/default' -ClassName 'SystemRestore' -ErrorAction Stop); if($r.Count -eq 0){ Write-Host 'Nenhum ponto de restauracao encontrado.' } else { Write-Host ('Pontos de restauracao ('+$r.Count+') - mais recentes primeiro:'); $r | Sort-Object SequenceNumber -Descending | Select-Object -First 15 | ForEach-Object { $t=$_.CreationTime; if($t -is [DateTime]){ $t=$t.ToString('dd/MM/yyyy HH:mm') }; Write-Host ('  #'+$_.SequenceNumber+' | '+$t+' | '+$_.Description) } } } catch { Write-Host ('Falha ao consultar: '+$_.Exception.Message) }"
:fim
echo.
pause
endlocal
