:: ============================================================
:: BATLAB | FindTODO.bat | v1.0.0
:: @desc      Procura marcadores TODO e FIXME em todos os arquivos
:: @category  developer
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - FindTODO
echo ============================================
echo  BATLAB - FindTODO
echo ============================================
echo Procurando marcadores TODO e FIXME em todos os arquivos...
echo Pasta: %CD%
echo.
findstr /s /i /n /c:"TODO" /c:"FIXME" *.*
if errorlevel 1 (echo [i] Nenhuma ocorrencia de TODO ou FIXME encontrada. & goto :fim)
echo.
echo [i] Formato acima: arquivo(linha): conteudo encontrado.
echo [i] Revise cada item e resolva ou remova o marcador.
echo Feito.
:fim
echo.
pause
