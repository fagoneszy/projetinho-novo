:: ============================================================
:: BATLAB | RenameSequentially.bat | v1.0.0
:: @desc      Renomeia arquivos em sequencia numerica (001, 002...)
:: @category  productivity
:: @platform windows
:: @admin     no
:: @risk      medium
:: @writes user
:: @deletes none
:: @registry none
:: @services none
:: @tasks none
:: @network none
:: @restart none
:: @undo      Os nomes originais nao sao restaurados - faca backup antes
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - RenameSequentially
echo ============================================
echo  BATLAB - RenameSequentially
echo ============================================
echo [ATENCAO] Vai renomear os arquivos desta pasta para 001_, 002_...
echo Arquivos atuais:
powershell -NoProfile -Command "Get-ChildItem -File | Sort-Object Name | Select-Object -ExpandProperty Name"
choice /c SN /m "Renomear? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
powershell -NoProfile -Command "$i=1; Get-ChildItem -File | Sort-Object Name | ForEach-Object { Rename-Item -LiteralPath $_.FullName -NewName (('{0:d3}' -f $i) + '_' + $_.Name); $i++ }"
echo Renomeados.
:fim
echo.
pause
