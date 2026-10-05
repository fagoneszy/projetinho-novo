:: ============================================================
:: BATLAB | StartupAudit.bat | v1.0.0
:: @desc      O que inicia com o Windows (reg Run + schtasks)
:: @category  diagnostics
:: @platform windows
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - StartupAudit
echo ============================================
echo  BATLAB - StartupAudit
echo ============================================
echo == Chaves de execucao automatica ==
echo -- HKCU Run --
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run"
if errorlevel 1 echo [AVISO] Chave HKCU Run ausente ou vazia.
echo -- HKCU RunOnce --
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce"
if errorlevel 1 echo [AVISO] Chave HKCU RunOnce ausente ou vazia.
echo -- HKLM Run --
reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Run"
if errorlevel 1 echo [AVISO] Chave HKLM Run ausente ou negada.
echo -- HKLM RunOnce --
reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce"
if errorlevel 1 echo [AVISO] Chave HKLM RunOnce ausente ou negada.
echo.
echo == Tarefas agendadas ==
schtasks /query /fo TABLE
if errorlevel 1 echo [AVISO] Nao foi possivel listar as tarefas agendadas.
echo.
echo [OK] Itens suspeitos aparecem em Run ou em tarefas fora do Microsoft.
echo [Dica] Inicializacao do usuario: shell:startup
echo Feito.
echo.
pause
