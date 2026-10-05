:: ============================================================
:: BATLAB | BootConfigurationBackup.bat | v1.0.0
:: @desc      Backup da configuracao de inicializacao
:: @category  windows-update
:: @platform  windows
:: @admin     yes
:: @risk      medium
:: @writes user
:: @deletes none
:: @registry read
:: @services none
:: @tasks none
:: @network none
:: @restart none
:: @undo      Apague o arquivo de backup (o BCD original nao foi alterado)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - BootConfigurationBackup
echo ============================================
echo  BATLAB - BootConfigurationBackup
echo ============================================
net session >nul 2>&1
if errorlevel 1 (
  echo [ERRO] Precisa de administrador para ler a configuracao de inicializacao.
  echo        Clique com botao direito e escolha Executar como administrador.
  goto :fim
)
for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMdd-HHmm"') do set "BK=bcd-backup-%%i"
echo [ATENCAO] Vai exportar UMA COPIA da configuracao de inicializacao (BCD).
echo O arquivo %BK%.bcd sera criado nesta pasta: %CD%
echo O BCD original NAO sera alterado - apenas leitura da loja atual.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
bcdedit /export "%CD%\%BK%.bcd"
if errorlevel 1 (echo [ERRO] Falha ao exportar o BCD. Verifique a permissao.) else (echo [OK] Backup criado: %CD%\%BK%.bcd)
:fim
echo.
pause
endlocal
