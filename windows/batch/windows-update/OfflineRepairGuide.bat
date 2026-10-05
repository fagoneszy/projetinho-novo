:: ============================================================
:: BATLAB | OfflineRepairGuide.bat | v1.0.0
:: @desc      Guia de reparo offline passo a passo
:: @category  windows-update
:: @platform  windows
:: @admin     no
:: @risk      low
:: @writes none
:: @deletes none
:: @registry none
:: @services none
:: @tasks none
:: @network none
:: @restart none
:: @undo      Somente leitura: nada a desfazer
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - OfflineRepairGuide
echo ============================================
echo  BATLAB - OfflineRepairGuide
echo ============================================
powershell -NoProfile -Command "Write-Host 'Guia de reparo offline - passo a passo:'; Write-Host ''; $g=@('1. Entrar no ambiente de recuperacao: Configuracoes > Recuperacao > Reiniciar agora (ou 3 desligamentos forcados).','2. Escolha Solucao de Problemas > Opcoes avancadas.','3. Reparar ao inicializar: corrige erros de boot sem tocar nos seus arquivos.','4. Prompt de comando: bootrec /fixmbr  e  bootrec /rebuildbcd  para recuperar o arranque.','5. Prompt de comando: DISM /Image:C: /Cleanup-Image /RestoreHealth - troque C: pela particao do Windows.','6. Prompt de comando: sfc /scannow /offbootdir=C: /offwindir=C:Windows - repara sem sistema ativo.','7. Restauracao do sistema: use um ponto criado antes do problema.','8. Se o Windows voltar a abrir, rode WindowsRepairBundle.bat para o reparo completo.'); foreach($x in $g){ Write-Host $x; Write-Host '' }"
:fim
echo.
pause
endlocal
