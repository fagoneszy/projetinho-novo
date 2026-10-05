:: ============================================================
:: BATLAB | TypingTest.bat | v1.0.0
:: @desc      Teste de digitacao: mede suas palavras por minuto
:: @category  games
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - TypingTest
echo ============================================
echo  BATLAB - TypingTest
echo ============================================
echo Teste de digitacao: digite a frase exata e pressione ENTER.
powershell -NoProfile -Command "$p=@('o rato roeu a roupa do rei de roma','a raposa marrom salta sobre o cachorro preguicoso','programar em batch exige paciencia e cafe'); $f=$p | Get-Random; Write-Host ('Frase: ' + $f); $t0=Get-Date; $u=Read-Host 'Sua digitacao'; $d=((Get-Date)-$t0).TotalSeconds; if($d -lt 1){$d=1}; $pal=$f.Split(' ').Count; $ppm=[math]::Round($pal*60/$d,1); Write-Host ('Tempo: ' + [math]::Round($d,1) + ' s'); Write-Host ('PPM: ' + $ppm); if($u -ceq $f){Write-Host 'PERFEITO, frase identica!'}else{Write-Host 'Diferente do original.'}"
echo.
pause
