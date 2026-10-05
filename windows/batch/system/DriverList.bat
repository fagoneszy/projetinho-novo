:: ============================================================
:: BATLAB | DriverList.bat | v1.0.0
:: @desc      Lista os drivers instalados
:: @category  system
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A (somente leitura)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - DriverList
echo ============================================
echo  BATLAB - DriverList
echo ============================================
echo Listando os drivers instalados com driverquery...
echo [INFO] Pode demorar de 5 a 20 segundos.
echo [INFO] Coluna Status mostra se o driver esta ativo.
echo [INFO] Nada sera alterado - apenas leitura.
echo [INFO] Para exportar use: driverquery /fo csv ^> drivers.csv
echo.
driverquery /fo table
echo.
if errorlevel 1 (echo [!] driverquery retornou erro - rode como Administrador para todos os detalhes.) else (echo Feito. Drivers listados acima.)
:fim
echo.
pause
