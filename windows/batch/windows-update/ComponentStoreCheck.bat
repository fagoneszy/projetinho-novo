:: ============================================================
:: BATLAB | ComponentStoreCheck.bat | v1.0.0
:: @desc      Verifica integridade do component store
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
title BATLAB - ComponentStoreCheck
echo ============================================
echo  BATLAB - ComponentStoreCheck
echo ============================================
net session >nul 2>&1
if errorlevel 1 (
  echo [ERRO] Precisa de administrador para o DISM verificar o component store.
  echo        Clique com botao direito e escolha Executar como administrador.
  goto :fim
)
echo [INFO] Verificacao rapida de integridade - DISM /CheckHealth (nao altera nada).
echo [INFO] Leva poucos segundos.
powershell -NoProfile -Command "Write-Host 'Rodando DISM /Online /Cleanup-Image /CheckHealth...'; $o = & dism.exe /Online /Cleanup-Image /CheckHealth 2>&1; $c=$LASTEXITCODE; $o | ForEach-Object { Write-Host ('  '+$_) }; Write-Host ''; if($c -eq 0){ Write-Host '[OK] Nenhum dano detectado no component store.' } else { Write-Host ('[!] DISM terminou com codigo '+$c+' - leia a mensagem acima.') }"
:fim
echo.
pause
endlocal
