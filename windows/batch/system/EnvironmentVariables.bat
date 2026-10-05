:: ============================================================
:: BATLAB | EnvironmentVariables.bat | v1.0.0
:: @desc      Mostra todas as variaves de ambiente
:: @category  system
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A (somente leitura)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - EnvironmentVariables
echo ============================================
echo  BATLAB - EnvironmentVariables
echo ============================================
echo Variaveis de ambiente do processo atual...
echo [INFO] Inclui variaveis de USUARIO, de SISTEMA e do processo.
echo [INFO] Para ver uma so: set NOME_DA_VARIAVEL
echo [INFO] Nada sera alterado - apenas leitura.
echo.
set
echo.
echo Total de variaveis definidas:
powershell -NoProfile -Command "(Get-ChildItem Env:).Count"
echo.
if errorlevel 1 (echo [ERRO] Falha ao contar as variaveis.) else (echo Feito. Listagem acima.)
:fim
echo.
pause
