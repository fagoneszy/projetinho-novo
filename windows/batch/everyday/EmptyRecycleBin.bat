:: ============================================================
:: BATLAB | EmptyRecycleBin.bat | v1.0.0
:: @desc      Esvazia a Lixeira (PowerShell Clear-RecycleBin -Force)
:: @category  everyday
:: @admin     no
:: @risk      high
:: @undo      Irreversivel - use /dryrun antes
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - EmptyRecycleBin
echo ============================================
echo  BATLAB - EmptyRecycleBin
echo ============================================
if /i "%~1"=="/dryrun" (
    echo [DRYRUN] Nada sera apagado. Itens atuais na Lixeira:
    powershell -NoProfile -Command "$s=New-Object -ComObject Shell.Application; $i=$s.Namespace(10); if ($i) { 'Itens: ' + $i.Items().Count } else { 'Itens: 0' }"
    echo [DRYRUN] Nenhuma alteracao foi feita.
    goto :fim
)
echo ============================================
echo  [ATENCAO] ACAO IRREVERSIVEL
echo ============================================
echo [!] Este script esvazia TODA a Lixeira deste usuario.
echo [!] Arquivos apagados nao poderao ser recuperados.
echo.
echo Itens atuais na Lixeira:
powershell -NoProfile -Command "$s=New-Object -ComObject Shell.Application; $i=$s.Namespace(10); if ($i) { 'Itens: ' + $i.Items().Count } else { 'Itens: 0' }"
echo.
echo [1/2] Confirme que voce entende o risco.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
echo [2/2] Ultima confirmacao antes de apagar de vez.
choice /c SN /m "Esvaziar a Lixeira? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
powershell -NoProfile -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue"
if errorlevel 1 (echo [ERRO] Falha ao esvaziar a Lixeira. & goto :fim)
echo [OK] Lixeira esvazia (acao irreversivel).
:fim
echo.
pause