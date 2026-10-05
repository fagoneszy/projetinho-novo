:: ============================================================
:: BATLAB | BootConfigurationReport.bat | v1.0.0
:: @desc      Mostra a configuracao de inicializacao
:: @category  windows-update
:: @platform  windows
:: @admin     yes
:: @risk      low
:: @writes none
:: @deletes none
:: @registry read
:: @services none
:: @tasks none
:: @network none
:: @restart none
:: @undo      Somente leitura: nada a desfazer
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - BootConfigurationReport
echo ============================================
echo  BATLAB - BootConfigurationReport
echo ============================================
net session >nul 2>&1
if errorlevel 1 (
  echo [ERRO] Precisa de administrador para ler a configuracao de inicializacao.
  echo        Clique com botao direito e escolha Executar como administrador.
  goto :fim
)
powershell -NoProfile -Command "Write-Host 'Configuracao de inicializacao (BCD):'; Write-Host ''; $o = & bcdedit.exe /enum 2>&1; $c=$LASTEXITCODE; if($c -ne 0){ Write-Host '  Falha ao ler o BCD - rode como administrador.' } else { $o | ForEach-Object { Write-Host ('  '+$_) } }"
:fim
echo.
pause
endlocal
