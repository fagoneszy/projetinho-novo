:: ============================================================
:: BATLAB | RenameByDate.bat | v1.0.0
:: @desc      Adiciona a data de modificacao no inicio dos nomes dos arquivos
:: @category  productivity
:: @admin     no
:: @risk      medium
:: @undo      Remova o prefixo AAAA-MM-DD_ dos nomes
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - RenameByDate
echo ============================================
echo  BATLAB - RenameByDate
echo ============================================
echo [ATENCAO] Vai renomear os arquivos desta pasta adicionando a data.
echo Arquivos atuais:
powershell -NoProfile -Command "Get-ChildItem -File | Select-Object -ExpandProperty Name"
choice /c SN /m "Renomear? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
powershell -NoProfile -Command "Get-ChildItem -File | Where-Object { $_.Name -notmatch '^\d{4}-\d{2}-\d{2}_' } | ForEach-Object { Rename-Item -LiteralPath $_.FullName -NewName ($_.LastWriteTime.ToString('yyyy-MM-dd_') + $_.Name) }"
echo Renomeados.
:fim
echo.
pause