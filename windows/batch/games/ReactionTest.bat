:: ============================================================
:: BATLAB | ReactionTest.bat | v1.0.0
:: @desc      Mede seu tempo de reacao
:: @category  games
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - ReactionTest
echo ============================================
echo  BATLAB - ReactionTest
echo ============================================
echo Espere o sinal e apere qualquer tecla o mais rapido possivel!
powershell -NoProfile -Command "$w=Get-Random -Minimum 1500 -Maximum 5000; Start-Sleep -Milliseconds $w; $t0=Get-Date; Write-Host ''; Write-Host '  AGORA!'; [Console]::ReadKey($true) | Out-Null; $d=[int]((Get-Date)-$t0).TotalMilliseconds; Write-Host ('Tempo de reacao: ' + $d + ' ms'); if($d -lt 250){Write-Host 'Reflexos de gato!'}elseif($d -lt 400){Write-Host 'Muito bom!'}else{Write-Host 'Treine mais!'}"
echo.
pause