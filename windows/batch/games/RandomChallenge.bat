:: ============================================================
:: BATLAB | RandomChallenge.bat | v1.0.0
:: @desc      Sorteia um desafio divertido
:: @category  games
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - RandomChallenge
echo ============================================
echo  BATLAB - RandomChallenge
echo ============================================
powershell -NoProfile -Command "$c=@('Fale por 2 minutos sem usar a palavra eu','Escreva 5 ideias de projeto em 3 minutos','Desenhe algo em 60 segundos sem levantar a mao','Conte de 100 a 0 decrescendo de 7','Escreva seu nome com a mao nao dominante','Imite um animal por 30 segundos','Conte ate 20 de olhos fechados'); Write-Host ''; Write-Host '  DESAFIO SORTEADO:'; Write-Host ''; Write-Host ('  ' + ($c | Get-Random)); Write-Host ''"
echo.
pause
