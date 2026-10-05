:: ============================================================
:: BATLAB | DevServer.bat | v1.0.0
:: @desc      Detecta e inicia o servidor de desenvolvimento do projeto
:: @category  developer
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - DevServer
echo ============================================
echo  BATLAB - DevServer
echo ============================================
echo Detectando o servidor de desenvolvimento do projeto...
echo Pasta: %CD%
echo [i] Ctrl+C encerra o servidor.
if exist "manage.py" goto django
if exist "package.json" goto node
if exist "Cargo.toml" goto cargo
if exist "go.mod" goto go
if exist "app.py" goto pyone
if exist "main.py" goto pyone
echo [ERRO] Nenhum servidor de dev reconhecido nesta pasta.
echo [i] Suportados: Django, Node, Rust, Go e scripts Python.
goto :fim
:django
echo Rodando: python manage.py runserver
python manage.py runserver
if errorlevel 1 echo [!] Servidor Django terminou com erro.
goto :fim
:node
findstr /i /c:"dev" "package.json" >nul 2>&1
if errorlevel 1 (echo Rodando: npm start & call npm start & goto :fim)
echo Rodando: npm run dev
call npm run dev
goto :fim
:cargo
echo Rodando: cargo run
cargo run
if errorlevel 1 echo [!] cargo run terminou com erro.
goto :fim
:go
echo Rodando: go run .
go run .
if errorlevel 1 echo [!] go run terminou com erro.
goto :fim
:pyone
echo Rodando: python -m http.server 8000
echo [i] Abra http://localhost:8000 no navegador.
python -m http.server 8000
if errorlevel 1 echo [!] Servidor HTTP terminou com erro.
:fim
echo.
pause
