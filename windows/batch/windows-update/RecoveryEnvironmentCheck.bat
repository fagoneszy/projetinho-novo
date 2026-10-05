:: ============================================================
:: BATLAB | RecoveryEnvironmentCheck.bat | v1.0.0
:: @desc      Verifica o ambiente de recuperacao (WinRE)
:: @category  windows-update
:: @platform  windows
:: @admin     no
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
title BATLAB - RecoveryEnvironmentCheck
echo ============================================
echo  BATLAB - RecoveryEnvironmentCheck
echo ============================================
echo [INFO] Detalhes oficiais do WinRE: rode reagentc /info como administrador.
powershell -NoProfile -Command "$x=Join-Path $env:SystemRoot 'System32\Recovery\ReAgent.xml'; if(-not (Test-Path -LiteralPath $x)){ Write-Host 'ReAgent.xml nao encontrado - WinRE ausente nesta instalacao.' } else { try { $r=[xml](Get-Content -LiteralPath $x -ErrorAction Stop); $st=''+$r.WindowsRE.InstallState.state; $loc=''+$r.WindowsRE.WinreLocation.path; $b=''+$r.WindowsRE.WinreBCD.id; $os=''+$r.WindowsRE.OsInstallAvailable.state; Write-Host 'Ambiente de recuperacao (WinRE):'; if($st -eq '1'){ Write-Host '  Status: HABILITADO' } else { Write-Host ('  Status: nao habilitado - estado '+$st) }; Write-Host ('  Local: '+$loc); Write-Host ('  Entrada BCD: '+$b); if($os -eq '1'){ Write-Host '  Imagem de reinstalacao disponivel: sim' } else { Write-Host '  Imagem de reinstalacao disponivel: nao' }; $w=Join-Path $env:SystemRoot 'System32\Recovery\winre.wim'; Write-Host ('  winre.wim na pasta Recovery: '+$(if(Test-Path -LiteralPath $w){'presente'}else{'ausente'})) } catch { Write-Host ('Falha ao ler ReAgent.xml: '+$_.Exception.Message) } }"
:fim
echo.
pause
endlocal
