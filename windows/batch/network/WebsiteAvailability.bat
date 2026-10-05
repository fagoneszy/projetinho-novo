:: ============================================================
:: BATLAB | WebsiteAvailability.bat | v1.0.0
:: @desc      Testa a disponibilidade de uma lista de sites com curl
:: @category  network
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - WebsiteAvailability
echo ============================================
echo  BATLAB - WebsiteAvailability
echo ============================================
echo Testando a disponibilidade dos sites abaixo...
echo Cada teste usa curl com timeout de 5 segundos.
for %%S in (google.com github.com cloudflare.com) do (
    echo ----------------------------------------
    echo Testando https://%%S ...
    curl -Is -m 5 "https://%%S" | findstr /i /b "HTTP" >nul
    if errorlevel 1 (echo [X] %%S: OFFLINE ou lento) else (echo [OK] %%S: online)
)
echo.
echo [i] Sites testados: google.com, github.com e cloudflare.com.
echo [i] Falhou so um? Rode de novo para confirmar.
echo Feito.
echo.
pause
