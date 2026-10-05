:: ============================================================
:: BATLAB | RainEffect.bat | v1.0.0
:: @desc      Efeito de chuva azul no terminal por 30 segundos
:: @category  games
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - RainEffect
echo ============================================
echo  BATLAB - RainEffect
echo ============================================
echo Efeito de chuva - 30 segundos. Ctrl+C para sair.
color 09
powershell -NoProfile -Command "for($i=0;$i -lt 250;$i++){ $s=''; for($j=0;$j -lt 70;$j++){ $s+=[char](48+[int](Get-Random -Maximum 74)) }; Write-Host $s; Start-Sleep -Milliseconds 120 }"
color 07
echo Fim do efeito.
echo.
pause
