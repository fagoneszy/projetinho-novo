:: ============================================================
:: BATLAB | CppProject.bat | v1.0.0
:: @desc      Cria estrutura C++ com src, include e Makefile
:: @category  developer
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - CppProject
echo ============================================
echo  BATLAB - CppProject
echo ============================================
set "P=%~1"
if not defined P set "P=%CD%"
echo Criando estrutura C++ em: %P%
if not exist "%P%" mkdir "%P%"
if not exist "%P%" (echo [ERRO] Falha ao criar a pasta. & goto :fim)
pushd "%P%"
if not exist "src" mkdir src
if not exist "include" mkdir include
if exist "src\main.cpp" goto mainok
echo #include ^<iostream^>> "src\main.cpp"
echo.>>"src\main.cpp"
echo int main^(^) {>> "src\main.cpp"
echo     std::cout ^<^< "Hello, world!" ^<^< std::endl;>> "src\main.cpp"
echo     return 0;>> "src\main.cpp"
echo }>> "src\main.cpp"
echo [+] src\main.cpp criado.
:mainok
if exist "Makefile" goto mkok
echo CC=g++> "Makefile"
echo CFLAGS=-Wall -Wextra -O2 -Iinclude>> "Makefile"
echo.>> "Makefile"
echo all: build/main>> "Makefile"
echo.>> "Makefile"
echo build/main: src/main.cpp>> "Makefile"
echo 	@mkdir -p build>> "Makefile"
echo 	$(CC) $(CFLAGS) -o build/main src/main.cpp>> "Makefile"
echo.>> "Makefile"
echo clean:>> "Makefile"
echo 	rm -rf build>> "Makefile"
echo [+] Makefile criado.
:mkok
popd
echo.
echo [OK] Estrutura C++ criada em %P%
echo [i] Build: make. Limpeza: make clean.
echo Feito.
:fim
echo.
pause
