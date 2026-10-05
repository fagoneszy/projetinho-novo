:: ============================================================
:: BATLAB | AutoCleanup.bat | v1.0.0
:: @desc      Remove do %TEMP% os arquivos com mais de N dias
:: @category  automation
:: @admin     no
:: @risk      medium
:: @undo      Irreversivel - arquivos de temp raramente sao necessarios
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - AutoCleanup
echo ============================================
echo  BATLAB - AutoCleanup
echo ============================================
set "DIAS=7"
if not "%~1"=="" set "DIAS=%~1"
echo(%DIAS%| findstr /r "^[1-9][0-9]*$" >nul
if errorlevel 1 (echo Valor invalido: %DIAS%. Use dias sem zero a esquerda. & goto :fim)
echo [ATENCAO] Vai excluir do %TEMP% os arquivos com mais de %DIAS% dias.
echo Quantidade de alvos:
powershell -NoProfile -Command "$n=[int]('%DIAS%'); $c=@(Get-ChildItem $env:TEMP -Recurse -File -ErrorAction SilentlyContinue | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-$n) }); Write-Host ($c.Count.ToString() + ' arquivo(s)')"
choice /c SN /m "Excluir? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
powershell -NoProfile -Command "$n=[int]('%DIAS%'); Get-ChildItem $env:TEMP -Recurse -File -ErrorAction SilentlyContinue | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-$n) } | ForEach-Object { Remove-Item -LiteralPath $_.FullName -Force -ErrorAction SilentlyContinue }; Write-Host 'Limpeza concluida.'"
echo Obs: arquivos em uso foram ignorados.
:fim
echo.
pause