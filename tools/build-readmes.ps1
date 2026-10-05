# build-readmes.ps1 — varre <categoria>/*.bat, le o cabecalho @meta
# e gera <categoria>/README.md com a ficha de cada ferramenta.
#
# Uso:
#   powershell -ExecutionPolicy Bypass -File tools\build-readmes.ps1

$ErrorActionPreference = 'Stop'
$enc = New-Object System.Text.UTF8Encoding($false)
$root = Split-Path -Parent $PSScriptRoot

$titles = @{
    'productivity'  = 'Produtividade / Productivity'
    'files'         = 'Arquivos e pastas / Files & folders'
    'system'        = 'Sistema e manutencao / System & maintenance'
    'network'       = 'Rede e Internet / Network & Internet'
    'developer'     = 'Desenvolvimento / Development'
    'media'         = 'Downloads e midia / Downloads & media'
    'customization' = 'Customizacao / Customization'
    'games'         = 'Jogos e diversao / Games & fun'
    'automation'    = 'Automacao / Automation & tasks'
    'diagnostics'   = 'Seguranca e diagnostico / Security & diagnostics'
    'everyday'      = 'Usuarios comuns / Everyday users'
}
$descriptions = @{
    'productivity'  = 'Pastas, anotacoes, foco e atalhos do dia a dia de trabalho. / Folders, notes, focus and daily work shortcuts.'
    'files'         = 'Organizar, copiar, comparar e limpar arquivos e pastas. / Organize, copy, compare and clean files and folders.'
    'system'        = 'Informacao, caches, discos e ferramentas do Windows. / Info, caches, disks and Windows tools.'
    'network'       = 'Diagnostico e informacao de rede, Wi-Fi e Internet. / Network, Wi-Fi and Internet info and diagnostics.'
    'developer'     = 'Git, projetos, terminais e atalhos de programacao. / Git, projects, terminals and developer shortcuts.'
    'media'         = 'Organizar fotos, videos, musicas e abrir apps de criador. / Organize photos, videos, music and open creator apps.'
    'customization' = 'Aparencia, opcoes do Explorer e atalhos de sistema. / Appearance, Explorer options and system shortcuts.'
    'games'         = 'Jogos de terminal, aleatoriedade e efeitos divertidos. / Terminal games, randomness and fun effects.'
    'automation'    = 'Backups, tarefas agendadas e monitores automaticos. / Backups, scheduled tasks and automatic monitors.'
    'diagnostics'   = 'Auditoria de seguranca, portas, eventos e programas. / Security audit, ports, events and installed programs.'
    'everyday'      = 'Acoes simples de todo dia para usuarios comuns. / Simple everyday actions for regular users.'
}

function Esc($s) { if ($null -eq $s) { return '' }; ($s -replace '\|', '\|') -replace '\s+$', '' }

$total = 0
Get-ChildItem -LiteralPath (Join-Path $root 'windows\batch') -Directory |
    Where-Object { $_.Name -in $titles.Keys } |
    Sort-Object { [array]::IndexOf(@($titles.Keys), $_.Name) } |
    ForEach-Object {
        $catDir = $_
        $cat = $catDir.Name
        $files = @(Get-ChildItem -LiteralPath $catDir.FullName -Filter '*.bat' -File | Sort-Object Name)
        $total += $files.Count

        $rows = foreach ($f in $files) {
            $meta = @{}
            $lines = Get-Content -LiteralPath $f.FullName -Encoding UTF8 -TotalCount 30
            foreach ($l in $lines) {
                if ($l -match '^::\s*@(\w+)\s+(.+)$') { $meta[$Matches[1]] = $Matches[2].Trim() }
            }
            $admin = if ($meta['admin'] -eq 'yes') { 'sim' } else { 'no' }
            $risk  = $meta['risk']; if (-not $risk) { $risk = 'low' }
            $riskIco = switch ($risk) { 'high' { '🔴' } 'medium' { '🟡' } default { '🟢' } }
            $undo = Esc $meta['undo']; if (-not $undo) { $undo = 'N/A' }
            "| [$($f.Name)]($($f.Name)) | $(Esc $meta['desc']) | $admin | $riskIco ``$risk`` | $undo |"
        }

        $md = @"
# $($titles[$cat])

> $($files.Count) ferramentas • $($descriptions[$cat])

| Arquivo / File | Descricao | Admin | Risco / Risk | Desfazer / Undo |
|---|---|---|---|---|
$($rows -join "`n")

## Legenda / Legend

* **Admin** — ``sim``: rode como Administrador / run as Administrator.
* **Risco / Risk** — 🟢 ``low``: somente leitura / read-only. 🟡 ``medium``:
  modifica algo e pede confirmacao / changes something and asks first.
  🔴 ``high``: exclui ou altera o sistema com confirmacao dupla / destructive,
  double confirmation.
* **Desfazer / Undo** — como reverter / how to revert.

Veja tambem / see also: [RISCOS.md](../../docs/RISCOS.md) •
[TEMPLATE.md](../../docs/TEMPLATE.md) • [indice geral](../../README.md)
"@
        $out = Join-Path $catDir.FullName 'README.md'
        [System.IO.File]::WriteAllText($out, ($md -replace "`r?`n", "`r`n"), $enc)
        Write-Host ("  {0,-15} {1,3} -> README.md" -f $cat, $files.Count)
    }

Write-Host "READMEs gerados. Total: $total"
if ($total -ne 300) { Write-Host "ERRO: esperado 300, obtido $total" -ForegroundColor Red; exit 1 }
