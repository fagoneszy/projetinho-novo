:: ============================================================
:: BATLAB | ClearTemp.bat | v1.0.0
:: @desc      Limpa os arquivos temporarios do usuario e do Windows
:: @category  system
:: @platform windows
:: @admin     no
:: @risk      medium
:: @writes none
:: @deletes temp
:: @registry none
:: @services none
:: @tasks none
:: @network none
:: @restart none
:: @undo      N/A - arquivos temporarios sao recriados pelo Windows
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - ClearTemp
echo ============================================
echo  BATLAB - ClearTemp
echo ============================================
echo [ATENCAO] Os arquivos TEMPORARIOS serao apagados:
echo   %TEMP%
echo   C:\Windows\Temp
echo Arquivos em uso serao PULADOS (isso nao e erro).
echo.
powershell -NoProfile -Command "$s=0; foreach($d in @($env:TEMP,'C:\Windows\Temp')){ if(Test-Path -LiteralPath $d){ $s+=(Get-ChildItem -LiteralPath $d -Recurse -File -Force -EA SilentlyContinue | Measure-Object Length -Sum).Sum } }; if(-not $s){$s=0}; Write-Host ('Conteudo atual: ' + [math]::Round($s/1MB,1) + ' MB')"
choice /c SN /m "Limpar os temporarios? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
powershell -NoProfile -Command "foreach($d in @($env:TEMP,'C:\Windows\Temp')){ if(Test-Path -LiteralPath $d){ Get-ChildItem -LiteralPath $d -Force -EA SilentlyContinue | Remove-Item -Recurse -Force -EA SilentlyContinue } }; Write-Host 'Limpeza concluida (itens em uso foram pulados).'"
echo Feito. Temporarios limpos.
:fim
echo.
pause
