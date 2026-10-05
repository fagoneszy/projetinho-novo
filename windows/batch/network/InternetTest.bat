:: ============================================================
:: BATLAB | InternetTest.bat | v1.0.0
:: @desc      Testa a conectividade da internet com varios destinos
:: @category  network
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - InternetTest
echo ============================================
echo  BATLAB - InternetTest
echo ============================================
set "DESTINOS=8.8.8.8 1.1.1.1 dns.google"
echo Testando conectividade com varios destinos...
echo Destinos: %DESTINOS%
echo.
for %%D in (%DESTINOS%) do (
    echo ----------------------------------------
    echo Alvo: %%D
    ping -n 2 -w 2000 %%D >nul
    if errorlevel 1 (echo [X] %%D sem resposta) else (echo [OK] %%D acessivel)
)
echo.
echo [i] Destinos usados: 8.8.8.8, 1.1.1.1 e dns.google
echo [i] Falhou tudo? Confira roteador com NetworkInfo.bat
echo Feito.
echo.
pause