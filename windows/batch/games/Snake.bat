:: ============================================================
:: BATLAB | Snake.bat | v1.0.0
:: @desc      Cobrinha no terminal - WASD move, ESC sai
:: @category  games
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - Snake
echo ============================================
echo  BATLAB - Snake
echo ============================================
set "PS1=%TEMP%\batlab_snake.ps1"
>"%PS1%" echo if([Console]::IsInputRedirected -or [Console]::IsOutputRedirected){ Write-Host 'AVISO: o Snake precisa de um console interativo (abra com dois cliques).'; exit 0 }
>>"%PS1%" echo [Console]::CursorVisible=$false
>>"%PS1%" echo $W=40
>>"%PS1%" echo $H=18
>>"%PS1%" echo $list=New-Object 'System.Collections.Generic.List[int]'
>>"%PS1%" echo for($i=3;$i -ge 0;$i--){ $list.Add((10+$i)+8*$W) }
>>"%PS1%" echo $dx=1
>>"%PS1%" echo $dy=0
>>"%PS1%" echo $fx=30
>>"%PS1%" echo $fy=8
>>"%PS1%" echo $score=0
>>"%PS1%" echo $die=$false
>>"%PS1%" echo Write-Host 'SNAKE - WASD move, ESC sai'
>>"%PS1%" echo Start-Sleep -Seconds 2
>>"%PS1%" echo while($die -eq $false){
>>"%PS1%" echo   while([Console]::KeyAvailable){
>>"%PS1%" echo     $k=[Console]::ReadKey($true).Key
>>"%PS1%" echo     if($k -eq [ConsoleKey]::W -and $dy -eq 0){ $dx=0; $dy=-1 }
>>"%PS1%" echo     if($k -eq [ConsoleKey]::S -and $dy -eq 0){ $dx=0; $dy=1 }
>>"%PS1%" echo     if($k -eq [ConsoleKey]::A -and $dx -eq 0){ $dx=-1; $dy=0 }
>>"%PS1%" echo     if($k -eq [ConsoleKey]::D -and $dx -eq 0){ $dx=1; $dy=0 }
>>"%PS1%" echo     if($k -eq [ConsoleKey]::Escape){ $die=$true }
>>"%PS1%" echo   }
>>"%PS1%" echo   $hx=$list[0]%%$W
>>"%PS1%" echo   $hy=[math]::Floor($list[0]/$W)
>>"%PS1%" echo   $nx=$hx+$dx
>>"%PS1%" echo   $ny=$hy+$dy
>>"%PS1%" echo   if($nx -lt 0){ $die=$true }
>>"%PS1%" echo   if($nx -ge $W){ $die=$true }
>>"%PS1%" echo   if($ny -lt 0){ $die=$true }
>>"%PS1%" echo   if($ny -ge $H){ $die=$true }
>>"%PS1%" echo   if($die -eq $false){
>>"%PS1%" echo     $ni=$nx+$ny*$W
>>"%PS1%" echo     $eat=$false
>>"%PS1%" echo     if($ni -eq ($fx+$fy*$W)){ $eat=$true }
>>"%PS1%" echo     $hit=$false
>>"%PS1%" echo     if($list.Contains($ni) -and $ni -ne $list[$list.Count-1]){ $hit=$true }
>>"%PS1%" echo     if($hit){ $die=$true }
>>"%PS1%" echo     if($die -eq $false){
>>"%PS1%" echo       $list.Insert(0,$ni)
>>"%PS1%" echo       if($eat){ $score++ } else { $list.RemoveAt($list.Count-1) }
>>"%PS1%" echo       if($eat){
>>"%PS1%" echo         $free=@()
>>"%PS1%" echo         for($c=0;$c -lt ($W*$H);$c++){ if(-not $list.Contains($c)){ $free+=$c } }
>>"%PS1%" echo         if($free.Count -eq 0){ Write-Host 'TRAVOU TUDO - VOCE VENCEU!'; $die=$true }
>>"%PS1%" echo         if($free.Count -gt 0){
>>"%PS1%" echo           $p=$free[[int](Get-Random -Maximum $free.Count)]
>>"%PS1%" echo           $fx=$p%%$W
>>"%PS1%" echo           $fy=[math]::Floor($p/$W)
>>"%PS1%" echo         }
>>"%PS1%" echo       }
>>"%PS1%" echo     }
>>"%PS1%" echo   }
>>"%PS1%" echo   [Console]::Clear()
>>"%PS1%" echo   for($y=0;$y -lt $H;$y++){
>>"%PS1%" echo     $line=''
>>"%PS1%" echo     for($x=0;$x -lt $W;$x++){
>>"%PS1%" echo       $i=$x+$y*$W
>>"%PS1%" echo       if($i -eq ($fx+$fy*$W)){ $line+='#' }
>>"%PS1%" echo       elseif($list.Contains($i)){ if($i -eq $list[0]){ $line+='O' } else { $line+='o' } }
>>"%PS1%" echo       else{ $line+='.' }
>>"%PS1%" echo     }
>>"%PS1%" echo     Write-Host $line
>>"%PS1%" echo   }
>>"%PS1%" echo   Write-Host ('Placar: '+$score+'   ESC sai')
>>"%PS1%" echo   Start-Sleep -Milliseconds 90
>>"%PS1%" echo }
>>"%PS1%" echo [Console]::CursorVisible=$true
>>"%PS1%" echo Write-Host 'FIM DE JOGO. Placar:' $score
echo Iniciando o Snake...
powershell -NoProfile -ExecutionPolicy Bypass -File "%PS1%"
del "%PS1%" >nul 2>&1
echo.
pause
