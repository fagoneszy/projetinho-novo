:: ============================================================
:: BATLAB | SystemImageHealthCheck.bat | v1.0.0
:: @desc      Verifica saude da imagem do sistema
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
title BATLAB - SystemImageHealthCheck
echo ============================================
echo  BATLAB - SystemImageHealthCheck
echo ============================================
net session >nul 2>&1
if errorlevel 1 (
  echo [ERRO] Precisa de administrador para o DISM verificar a imagem do sistema.
  echo        Clique com botao direito e escolha Executar como administrador.
  goto :fim
)
echo [INFO] Verificacao completa da imagem - DISM /ScanHealth (somente leitura).
echo [INFO] Pode DEMORAR de 10 a 20 minutos. Nao feche a janela.
echo [INFO] Se achar dano, rode WindowsRepairBundle.bat para reparar.
powershell -NoProfile -Command "Write-Host 'Rodando DISM /Online /Cleanup-Image /ScanHealth...'; $o = & dism.exe /Online /Cleanup-Image /ScanHealth 2>&1; $c=$LASTEXITCODE; $o | ForEach-Object { Write-Host ('  '+$_) }; Write-Host ''; if($c -eq 0){ Write-Host '[OK] Nenhum problema encontrado na imagem do sistema.' } else { Write-Host ('[!] DISM terminou com codigo '+$c+' - leia a mensagem acima.') }"
:fim
echo.
pause
endlocal
