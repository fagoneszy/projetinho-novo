:: ============================================================
:: BATLAB | InstallRequirements.bat | v1.0.0
:: @desc      Instala as dependencias Python do requirements.txt com pip
:: @category  developer
:: @admin     no
:: @risk      medium
:: @undo      pip uninstall -r requirements.txt para remover os pacotes
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - InstallRequirements
echo ============================================
echo  BATLAB - InstallRequirements
echo ============================================
if not exist "requirements.txt" (echo [ERRO] requirements.txt nao encontrado nesta pasta. & goto :fim)
echo [ATENCAO] Vai instalar pacotes Python com pip a partir de:
echo   %CD%\requirements.txt
echo Conteudo atual do arquivo:
type "requirements.txt"
if errorlevel 1 echo [!] Arquivo vazio ou ilegivel.
echo.
choice /c SN /m "Instalar as dependencias? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
call pip install -r requirements.txt
if errorlevel 1 (echo [ERRO] pip instalacao falhou. Verifique a saida acima. & goto :fim)
echo.
echo [OK] Dependencias instaladas.
echo [i] Desfazer: pip uninstall -r requirements.txt
echo Feito.
:fim
echo.
pause