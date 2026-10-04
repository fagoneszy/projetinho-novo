:: ============================================================
:: BATLAB | WindowsVersion.bat | v1.0.0
:: @desc      Versao, edicao e build do Windows
:: @category  system
:: @admin     no
:: @risk      low
:: @undo      N/A (somente leitura)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - WindowsVersion
echo ============================================
echo  BATLAB - WindowsVersion
echo ============================================
echo Lendo a versao do Windows...
echo [INFO] Produto, edicao, build e revisao do sistema.
echo [INFO] O ver no final mostra a versao curta do prompt.
echo [INFO] Nada sera alterado - apenas leitura.
echo.
powershell -NoProfile -Command "$o=Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion'; Write-Host ('Produto:  ' + $o.ProductName); Write-Host ('Edicao:  ' + $o.EditionID); Write-Host ('Build:    ' + $o.CurrentBuildNumber + '.' + $o.UBR); Write-Host ('Registro: ' + $o.ReleaseId + ' ' + $o.DisplayVersion); Write-Host ('Tipo:     ' + $o.ProductType)"
echo.
ver
if errorlevel 1 (echo [ERRO] Falha ao ler a versao.) else (echo Feito. Versao acima.)
:fim
echo.
pause