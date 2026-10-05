:: ============================================================
:: BATLAB | MatrixEffect.bat | v1.0.0
:: @desc      Efeito Matrix: chuva de caracteres verde por 30 segundos
:: @category  games
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - MatrixEffect
echo ============================================
echo  BATLAB - MatrixEffect
echo ============================================
echo Efeito Matrix - 30 segundos. Ctrl+C para sair.
color 0a
powershell -NoProfile -Command "for($i=0;$i -lt 250;$i++){ $s=''; for($j=0;$j -lt 70;$j++){ $s+=[char](48+[int](Get-Random -Maximum 74)) }; Write-Host $s; Start-Sleep -Milliseconds 120 }"
color 07
echo Fim do efeito.
echo.
pause
