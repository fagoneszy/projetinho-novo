# build-manifest.ps1 — varre <categoria>/*.bat, le o cabeçalho @meta
# e gera site/projects.json (fonte de dados do site BATLAB).
#
# Uso:
#   powershell -ExecutionPolicy Bypass -File tools\build-manifest.ps1
#   powershell -File tools\build-manifest.ps1 -Owner faguinho -Repo batlab

param(
    [string]$Owner,
    [string]$Repo
)

$ErrorActionPreference = 'Stop'

$root  = Split-Path -Parent $PSScriptRoot
$site  = Join-Path $root 'site'
$cfgJs = Join-Path $site 'config.js'

# Owner/Repo: parametros > config.js > padrao
if (-not $Owner -or -not $Repo) {
    if (Test-Path $cfgJs) {
        $txt = Get-Content -LiteralPath $cfgJs -Raw
        if (-not $Owner -and $txt -match 'REPO_OWNER\s*=\s*["'']([^"'']+)["'']') { $Owner = $Matches[1] }
        if (-not $Repo  -and $txt -match 'REPO_NAME\s*=\s*["'']([^"'']+)["'']')  { $Repo  = $Matches[1] }
    }
}
if (-not $Owner) { $Owner = 'SEU_USUARIO' }
if (-not $Repo)  { $Repo  = 'batlab' }

$baseRaw   = "https://raw.githubusercontent.com/$Owner/$Repo/main"
$baseRepo  = "https://github.com/$Owner/$Repo/blob/main"

$tools = @()
$bad   = @()

Get-ChildItem -LiteralPath $root -Directory |
    Where-Object { $_.Name -notin @('site', 'tools', 'docs', '.git') } |
    Sort-Object Name |
    ForEach-Object {
        $catDir = $_
        Get-ChildItem -LiteralPath $catDir.FullName -Filter '*.bat' -File | Sort-Object Name | ForEach-Object {
            $f = $_
            $meta = @{}
            $version = '1.0.0'
            $lines = Get-Content -LiteralPath $f.FullName -Encoding UTF8 -TotalCount 12
            foreach ($l in $lines) {
                if ($l -match '^::\s*@(\w+)\s+(.+)$') {
                    $meta[$Matches[1]] = $Matches[2].Trim()
                }
                elseif ($l -match '^::\s*BATLAB\s*\|.*\|\s*v(\S+)\s*$') {
                    $version = $Matches[1]
                }
            }
            foreach ($req in @('desc', 'category', 'admin', 'risk', 'undo')) {
                if (-not $meta.ContainsKey($req)) { $bad += "$($f.FullName) :: falta @$req" }
            }
            if ($meta.ContainsKey('category') -and $meta['category'] -ne $catDir.Name) {
                $bad += "$($f.FullName) :: @category=$($meta['category']) mas a pasta e '$($catDir.Name)'"
            }
            if ($meta.ContainsKey('admin') -and $meta['admin'] -notin @('no', 'yes')) {
                $bad += "$($f.FullName) :: @admin invalido: $($meta['admin'])"
            }
            if ($meta.ContainsKey('risk') -and $meta['risk'] -notin @('low', 'medium', 'high')) {
                $bad += "$($f.FullName) :: @risk invalido: $($meta['risk'])"
            }

            $kb = [math]::Round($f.Length / 1KB, 1)
            $rel = "$($catDir.Name)/$($f.Name)"
            $tools += [pscustomobject]@{
                name        = [System.IO.Path]::GetFileNameWithoutExtension($f.Name)
                file        = $f.Name
                slug        = $f.BaseName.ToLower()
                category    = $catDir.Name
                description = if ($meta.ContainsKey('desc')) { $meta['desc'] } else { '' }
                admin       = ($meta.ContainsKey('admin') -and $meta['admin'] -eq 'yes')
                risk        = if ($meta.ContainsKey('risk')) { $meta['risk'] } else { 'low' }
                undo        = if ($meta.ContainsKey('undo')) { $meta['undo'] } else { 'N/A' }
                version     = $version
                size        = "$kb KB"
                download    = "$baseRaw/$rel"
                source      = "$baseRepo/$rel"
            }
        }
    }

if ($bad.Count -gt 0) {
    Write-Host "PROBLEMAS NO CABECALHO:" -ForegroundColor Red
    $bad | ForEach-Object { Write-Host "  $_" -ForegroundColor Red }
    Write-Host ""
}

if (-not (Test-Path $site)) { New-Item -ItemType Directory -Path $site | Out-Null }
$out = Join-Path $site 'projects.json'
$json = $tools | ConvertTo-Json -Depth 4
[System.IO.File]::WriteAllText($out, $json, (New-Object System.Text.UTF8Encoding($false)))

$byCat = $tools | Group-Object category | Sort-Object Name
Write-Host "Gerado: $out" -ForegroundColor Green
Write-Host "Total : $($tools.Count) ferramentas (owner=$Owner repo=$Repo)" -ForegroundColor Green
$byCat | ForEach-Object { Write-Host ("  {0,-15} {1}" -f $_.Name, $_.Count) }
if ($bad.Count -gt 0) { exit 1 }
