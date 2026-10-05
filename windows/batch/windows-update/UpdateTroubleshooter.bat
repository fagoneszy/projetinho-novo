:: ============================================================
:: BATLAB | UpdateTroubleshooter.bat | v1.0.0
:: @desc      Abre o solucionador do Windows Update
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
title BATLAB - UpdateTroubleshooter
echo ============================================
echo  BATLAB - UpdateTroubleshooter
echo ============================================
echo [INFO] Vai abrir a ferramenta de solucao de problemas do Windows Update.
echo [INFO] Se o Windows pedir permissao, confirme na janela que aparecer.
powershell -NoProfile -Command "$ok=$false; $m=Join-Path $env:SystemRoot 'System32\msdt.exe'; if(Test-Path -LiteralPath $m){ try { Start-Process -FilePath $m -ArgumentList '/id','WindowsUpdateDiagnostic' -ErrorAction Stop; Write-Host 'Solucionador do Windows Update iniciado (msdt).'; $ok=$true } catch { Write-Host 'Falha ao iniciar o msdt.' } }; if(-not $ok){ try { Start-Process 'ms-settings:troubleshoot' -ErrorAction Stop; Write-Host 'Configuracoes de solucao de problemas abertas.' } catch { Write-Host 'Nao foi possivel abrir as configuracoes.' } }"
:fim
echo.
pause
endlocal
