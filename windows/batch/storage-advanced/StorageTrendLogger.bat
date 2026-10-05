:: ============================================================
:: BATLAB | StorageTrendLogger.bat | v1.0.0
:: @desc      Registra uso de disco em CSV
:: @category  storage-advanced
:: @platform  windows
:: @admin     no
:: @risk      medium
:: @writes user
:: @deletes none
:: @registry none
:: @services none
:: @tasks none
:: @network none
:: @restart none
:: @undo      Apague o UsoDisco.csv gerado
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - StorageTrendLogger
echo ============================================
echo  BATLAB - StorageTrendLogger
echo ============================================
echo [ATENCAO] Vai gravar linhas novas no arquivo UsoDisco.csv.
echo Arquivo: %CD%\UsoDisco.csv - criado com cabecalho se nao existir.
echo Colunas: data, hora, volume, livre em GB e uso em 100.
echo Nada alem deste CSV e alterado e nada e apagado.
echo Volumes que serao registrados agora:
powershell -NoProfile -Command "try { Get-Volume -ErrorAction Stop | Where-Object { $_.DriveLetter } | ForEach-Object { $p=0; if($_.Size -gt 0){ $p=[math]::Round(100*$_.SizeRemaining/$_.Size) }; Write-Host ('  '+$_.DriveLetter+': livre '+[math]::Round($_.SizeRemaining/1GB,1)+' GB | uso '+$p+' em 100') } } catch { Write-Host ('  Falha ao ler volumes: '+$_.Exception.Message) }"
choice /c SN /m "Gravar estas linhas no CSV? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
powershell -NoProfile -Command "try { $f='UsoDisco.csv'; if(-not (Test-Path -LiteralPath $f)){ Add-Content -LiteralPath $f -Value 'data,hora,volume,livre_gb,uso_em_100' -Encoding UTF8 }; $n=0; Get-Volume -ErrorAction Stop | Where-Object { $_.DriveLetter } | ForEach-Object { $p=0; if($_.Size -gt 0){ $p=[math]::Round(100*$_.SizeRemaining/$_.Size) }; $g=([math]::Round($_.SizeRemaining/1GB,1)).ToString('F1',[cultureinfo]::InvariantCulture); $l=(Get-Date -Format 'yyyy-MM-dd')+','+(Get-Date -Format 'HH:mm')+','+$_.DriveLetter+','+$g+','+$p; Add-Content -LiteralPath $f -Value $l -Encoding UTF8; $n=$n+1 }; Write-Host ('Gravadas '+$n+' linhas em '+((Get-Location).Path+'\'+$f)) } catch { Write-Host ('  Falha ao gravar: '+$_.Exception.Message) }"
:fim
echo.
pause
endlocal
