:: ============================================================
:: BATLAB | DuplicateFinder.bat | v1.0.0
:: @desc      Lista arquivos duplicados (mesmo tamanho e conteudo)
:: @category  files
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A (somente listagem)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - DuplicateFinder
echo ============================================
echo  BATLAB - DuplicateFinder
echo ============================================
echo Procurando arquivos duplicados em %CD%
echo [INFO] Compara apenas arquivos de mesmo tamanho e mesmo hash MD5.
echo [INFO] A busca inclui subpastas e pode demorar em pastas grandes.
echo [INFO] Arquivos duplicados sao listados aos pares para voce revisar.
echo [INFO] Delete manualmente apenas o exemplar que for sobrar.
echo [INFO] Nada sera apagado - apenas listagem.
echo.
powershell -NoProfile -Command "$g=Get-ChildItem -File -Recurse -EA SilentlyContinue | Group-Object Length | Where-Object { $_.Count -gt 1 }; $n=0; foreach($b in $g){ $seen=@{}; foreach($f in $b.Group){ $h=(Get-FileHash -LiteralPath $f.FullName -Algorithm MD5).Hash; if($seen.ContainsKey($h)){ $n++; Write-Host ('DUP: ' + $f.FullName); Write-Host ('IGUAL: ' + $seen[$h]) } else { $seen[$h]=$f.FullName } } }; Write-Host ('Grupos de duplicados encontrados: ' + $n)"
if errorlevel 1 (echo [ERRO] Falha na verificacao de duplicados.) else (echo Feito. Listagem concluida.)
:fim
echo.
pause
