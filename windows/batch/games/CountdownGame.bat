:: ============================================================
:: BATLAB | CountdownGame.bat | v1.0.0
:: @desc      Desafio: acerte o tempo da contagem oculta
:: @category  games
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - CountdownGame
echo ============================================
echo  BATLAB - CountdownGame
echo ============================================
echo Vou esperar um tempo aleatorio. Pressione ENTER quando achar que acabou!
powershell -NoProfile -Command "$w=Get-Random -Minimum 4000 -Maximum 9000; $t0=Get-Date; Start-Sleep -Milliseconds $w; Write-Host 'ACABOU! Pressione ENTER agora.'; Read-Host | Out-Null; $a=[int]((Get-Date)-$t0).TotalMilliseconds; $d=[math]::Abs($a-$w); Write-Host ('Tempo real: '+$w+' ms'); Write-Host ('Seu tempo:  '+$a+' ms'); Write-Host ('Diferenca:  '+$d+' ms'); if($d -lt 700){Write-Host 'EXCELENTE!'}elseif($d -lt 1500){Write-Host 'Muito bom!'}else{Write-Host 'Quase! Tente de novo.'}"
echo.
pause