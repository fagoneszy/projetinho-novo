:: ============================================================
:: BATLAB | RouteTable.bat | v1.0.0
:: @desc      Exibe a tabela de rotas do sistema com route print
:: @category  network
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - RouteTable
echo ============================================
echo  BATLAB - RouteTable
echo ============================================
echo Consultando a tabela de rotas do sistema...
echo Host: %COMPUTERNAME%
echo Data: %DATE% %TIME%
echo.
route print
if errorlevel 1 (echo [!] Falha ao ler a tabela de rotas. & goto :fim)
echo.
echo [i] Parte superior: rotas de interface da rede local.
echo [i] Parte inferior: rotas persistentes configuradas.
echo [i] Criar rota: route add. Remover: route delete.
echo Feito.
:fim
echo.
pause