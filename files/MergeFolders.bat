:: ============================================================
:: BATLAB | MergeFolders.bat | v1.0.0
:: @desc      Mescla o conteudo de duas pastas
:: @category  files
:: @admin     no
:: @risk      medium
:: @undo      Mova os arquivos copiados de volta para a pasta de origem
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - MergeFolders
echo ============================================
echo  BATLAB - MergeFolders
echo ============================================
set "A=%~1"
set "B=%~2"
if not defined A set /p "A=Pasta de ORIGEM: "
if not defined B set /p "B=Pasta de DESTINO (recebera o conteudo): "
if not defined A (echo [ERRO] Origem nao informada. & goto :fim)
if not defined B (echo [ERRO] Destino nao informado. & goto :fim)
if not exist "%A%\" (echo [ERRO] Origem nao encontrada: %A% & goto :fim)
if not exist "%B%\" (echo [ERRO] Destino nao encontrado: %B% & goto :fim)
echo [ATENCAO] O conteudo de A sera MESCLADO dentro de B.
echo   A: %A%
echo   B: %B%
echo Arquivos com o mesmo nome serao SUBSTITUIDOS em B.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
robocopy "%A%" "%B%" /E /XJ /R:1 /W:1 /NFL /NDL /NJH /NP >nul
if %ERRORLEVEL% GEQ 8 (echo [ERRO] Falha na mesclagem. Codigo %ERRORLEVEL%.) else (echo Feito. Conteudo mesclado em %B%.)
:fim
echo.
pause