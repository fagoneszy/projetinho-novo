:: ============================================================
:: BATLAB | KillProcess.bat | v1.0.0
:: @desc      Lista processos e encerra o escolhido
:: @category  system
:: @admin     no
:: @risk      medium
:: @undo      Abra o programa novamente pelo Menu Iniciar ou atalho
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - KillProcess
echo ============================================
echo  BATLAB - KillProcess
echo ============================================
setlocal EnableDelayedExpansion
echo Montando o menu de processos (maximo 30 exibidos)...
echo.
set /a N=0
for /f "tokens=1,2 delims=," %%a in ('tasklist /FO CSV /NH') do (
  set /a N+=1
  set "PN!N!=%%~a"
  set "PP!N!=%%~b"
  if !N! LEQ 30 echo   !N!. %%~a   PID %%~b
)
if !N! EQU 0 (echo [ERRO] Nenhum processo encontrado. & goto :fim)
echo.
echo [INFO] Total de processos: !N!. Se nao estiver acima, use taskkill /IM nome.exe
set /p "OPCAO=Digite o NUMERO do processo (vazio cancela): "
if not defined OPCAO (echo Cancelado pelo usuario. & goto :fim)
echo(!OPCAO!| findstr /r /c:"^[0-9][0-9]*$" >nul
if errorlevel 1 (echo [ERRO] Opcao invalida - digite apenas numeros. & goto :fim)
if !OPCAO! LSS 1 (echo [ERRO] Opcao fora do intervalo. & goto :fim)
if !OPCAO! GTR !N! (echo [ERRO] Opcao fora do intervalo 1..!N!. & goto :fim)
set "ALVO=!PN%OPCAO%!"
set "PIDX=!PP%OPCAO%!"
echo [ATENCAO] O processo abaixo sera encerrado a FORCA (taskkill /F):
echo    !ALVO!   PID !PIDX!
choice /c SN /m "Encerrar este processo? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
taskkill /F /PID !PIDX!
if errorlevel 1 (echo [ERRO] Falha ao encerrar - permissao ou processo do sistema.) else (echo Feito. Processo !ALVO! encerrado.)
:fim
echo.
pause