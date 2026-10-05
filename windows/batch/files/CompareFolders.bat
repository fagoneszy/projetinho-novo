:: ============================================================
:: BATLAB | CompareFolders.bat | v1.0.0
:: @desc      Compara duas pastas e lista as diferencas
:: @category  files
:: @admin     no
:: @risk      low
:: @undo      N/A (somente listagem)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - CompareFolders
echo ============================================
echo  BATLAB - CompareFolders
echo ============================================
set "A=%~1"
set "B=%~2"
if not defined A set /p "A=Pasta A (referencia): "
if not defined B set /p "B=Pasta B (comparacao): "
if not defined A (echo [ERRO] Pasta A nao informada. & goto :fim)
if not defined B (echo [ERRO] Pasta B nao informada. & goto :fim)
if not exist "%A%\" (echo [ERRO] Nao encontrada: %A% & goto :fim)
if not exist "%B%\" (echo [ERRO] Nao encontrada: %B% & goto :fim)
echo Somente leitura - nenhuma pasta sera alterada.
echo   A: %A%
echo   B: %B%
echo Legenda: ^<= so existe em A   ^|   ^=^> so existe em B
echo.
powershell -NoProfile -Command "$ra='%A%'.TrimEnd('\'); $rb='%B%'.TrimEnd('\'); $a=@(Get-ChildItem -LiteralPath $ra -Recurse -File -Force -EA SilentlyContinue | ForEach-Object { $_.FullName.Substring($ra.Length) }); $b=@(Get-ChildItem -LiteralPath $rb -Recurse -File -Force -EA SilentlyContinue | ForEach-Object { $_.FullName.Substring($rb.Length) }); $d=Compare-Object -ReferenceObject $a -DifferenceObject $b; if($d){ $d | ForEach-Object { '{0} {1}' -f $_.SideIndicator, $_.InputObject } } else { 'Pastas identicas (mesmos arquivos).' }"
if errorlevel 1 (echo [ERRO] Falha ao comparar as pastas.) else (echo Feito. Comparacao concluida.)
:fim
echo.
pause