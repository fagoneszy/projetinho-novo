:: ============================================================
:: BATLAB | WindowsRepairBundle.bat | v1.0.0
:: @desc      Executa reparos basicos em sequencia
:: @category  windows-update
:: @platform  windows
:: @admin     yes
:: @risk      high
:: @writes system
:: @deletes none
:: @registry write
:: @services none
:: @tasks none
:: @network none
:: @restart none
:: @undo      Arquivos substituidos sao restaurados pelo proprio Windows; reinicie ao final
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - WindowsRepairBundle
echo ============================================
echo  BATLAB - WindowsRepairBundle
echo ============================================
if /i "%~1"=="/dryrun" (
  echo [DRYRUN] Apenas listando o que seria feito - nada sera executado.
  echo   1. DISM /Online /Cleanup-Image /RestoreHealth - repara a imagem do Windows
  echo   2. sfc /scannow - repara arquivos protegidos do sistema
  echo Reexecute sem /dryrun para rodar de verdade - vai pedir 2 confirmacoes.
  goto :fim
)
net session >nul 2>&1
if errorlevel 1 (
  echo [ERRO] Precisa de administrador para rodar DISM e sfc.
  echo        Clique com botao direito e escolha Executar como administrador.
  goto :fim
)
echo ============================================================
echo  [ATENCAO] REPARO DO SISTEMA - DISM RestoreHealth + sfc /scannow
echo ============================================================
echo O que sera feito:
echo   1. DISM /Online /Cleanup-Image /RestoreHealth - repara a imagem do Windows
echo   2. sfc /scannow - repara arquivos protegidos do sistema
echo [!] Pode demorar de 10 a 40 minutos. Nao feche a janela.
echo [!] Pode ser necessario reiniciar o Windows ao final.
choice /c SN /m "Primeira confirmacao. Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
choice /c SN /m "Segunda confirmacao. Tem certeza? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
powershell -NoProfile -Command "Write-Host 'Etapa 1 de 2 - DISM /RestoreHealth, aguarde...'; & dism.exe /Online /Cleanup-Image /RestoreHealth; $d=$LASTEXITCODE; Write-Host ''; Write-Host 'Etapa 2 de 2 - sfc /scannow, aguarde...'; & sfc.exe /scannow; $s=$LASTEXITCODE; Write-Host ''; Write-Host ('DISM codigo: '+$d+' | sfc codigo: '+$s); if($d -eq 0 -and $s -eq 0){ Write-Host '[OK] Reparos concluidos. Reinicie o PC se o Windows pedir.' } else { Write-Host '[!] Um ou mais reparos reportaram problema - veja C:/Windows/Logs/CBS/CBS.log' }"
:fim
echo.
pause
endlocal
