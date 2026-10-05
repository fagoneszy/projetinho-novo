:: ============================================================
:: BATLAB | DriveLetterManager.bat | v1.0.0
:: @desc      Letras de disco em uso e disponiveis
:: @category  storage-advanced
:: @platform  windows
:: @admin     no
:: @risk      low
:: @writes none
:: @deletes none
:: @registry none
:: @services none
:: @tasks none
:: @network none
:: @restart none
:: @undo      Somente leitura: nada a desfazer
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - DriveLetterManager
echo ============================================
echo  BATLAB - DriveLetterManager
echo ============================================
echo Lista letras em uso, letras livres e o mapa de volumes.
echo Este script apenas lista: nenhuma letra e alterada.
echo Para mudar uma letra na mao: abra Gerenciamento de discos,
echo   botao direito na particao, Alterar letra de unidade e caminhos.
echo Pelo prompt elevado: diskpart, select volume, assign letter.
powershell -NoProfile -Command "try { $u=@(Get-Volume -ErrorAction Stop | Where-Object { $_.DriveLetter } | ForEach-Object { [string]$_.DriveLetter }) } catch { Write-Host ('  Falha ao ler volumes: '+$_.Exception.Message); $u=@() }; Write-Host ('  Letras em uso: '+(($u | Sort-Object) -join ', ')); $liv=@(); foreach($n in 65..90){ $c=[string][char]$n; if($u -notcontains $c){ $liv+=$c } }; Write-Host ('  Letras livres: '+($liv -join ', ')); Write-Host ''; Write-Host 'Mapa atual de volumes:'; mountvol | ForEach-Object { Write-Host ('    '+$_) }"
:fim
echo.
pause
endlocal
