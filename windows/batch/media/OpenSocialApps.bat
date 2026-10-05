:: ============================================================
:: BATLAB | OpenSocialApps.bat | v1.0.0
:: @desc      Menu de redes sociais (YouTube, Twitch, Twitter/X, Instagram)
:: @category  media
:: @admin     no
:: @risk      low
:: @undo      N/A
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OpenSocialApps
echo ============================================
echo  BATLAB - OpenSocialApps
echo ============================================
echo Escolha a rede social:
echo   1 - YouTube
echo   2 - Twitch
echo   3 - Twitter / X
echo   4 - Instagram
echo.
choice /c 1234 /m "Qual abrir?"
if errorlevel 4 goto :s4
if errorlevel 3 goto :s3
if errorlevel 2 goto :s2
if errorlevel 1 goto :s1
goto :fim
:s1
start "" "https://www.youtube.com"
if errorlevel 1 (echo [ERRO] Falha ao abrir o YouTube.) else (echo YouTube solicitado.)
goto :fim
:s2
start "" "https://www.twitch.tv"
if errorlevel 1 (echo [ERRO] Falha ao abrir a Twitch.) else (echo Twitch solicitada.)
goto :fim
:s3
start "" "https://x.com"
if errorlevel 1 (echo [ERRO] Falha ao abrir o Twitter/X.) else (echo Twitter/X solicitado.)
goto :fim
:s4
start "" "https://www.instagram.com"
if errorlevel 1 (echo [ERRO] Falha ao abrir o Instagram.) else (echo Instagram solicitado.)
goto :fim
:fim
echo.
pause