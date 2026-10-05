:: ============================================================
:: BATLAB | UpdateErrorCodes.bat | v1.0.0
:: @desc      Consulta codigos de erro de atualizacao
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
title BATLAB - UpdateErrorCodes
echo ============================================
echo  BATLAB - UpdateErrorCodes
echo ============================================
powershell -NoProfile -Command "$m=@{ '0x80070002'='Arquivo ausente - limpe a pasta SoftwareDistribution e tente de novo'; '0x80070003'='Caminho nao encontrado'; '0x80244010'='Servidor de atualizacao demorou para responder - timeout'; '0x8024402c'='Falha de proxy ou DNS na conexao'; '0x8024001E'='Falha na instalacao da atualizacao'; '0x80248007'='Nenhum resultado na busca de atualizacoes'; '0x8024a105'='Servico do Windows Update em estado invalido'; '0x80070422'='Servico do Windows Update desabilitado'; '0x8007000d'='Dado invalido - componente possivelmente corrompido'; '0x800f081f'='Nao foi possivel baixar a origem - DISM sem arquivos' }; Write-Host 'Codigos comuns do Windows Update:'; $m.Keys | Sort-Object | ForEach-Object { Write-Host ('  '+$_+' = '+$m[$_]) }; Write-Host ''; Write-Host 'Codigos encontrados nos seus eventos recentes:'; $e=@(Get-WinEvent -FilterHashtable @{LogName='Microsoft-Windows-WindowsUpdateClient/Operational'; Level=1,2} -MaxEvents 30 -ErrorAction SilentlyContinue); $ach=@(); foreach($x in $e){ foreach($q in [regex]::Matches(''+$x.Message,'0x[0-9A-Fa-f]{8}')){ if($ach -notcontains $q.Value){ $ach+=$q.Value } } }; if($ach.Count -eq 0){ Write-Host '  (nenhum codigo 0x nos eventos recentes)' } else { foreach($c in $ach){ $d='nao catalogado'; if($m.ContainsKey($c)){ $d=$m[$c] }; Write-Host ('  '+$c+' = '+$d) } }"
:fim
echo.
pause
endlocal
