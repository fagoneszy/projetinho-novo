# build-problems.ps1 — valida problems/*.json e gera site/problems.json
# (porta "por problema" do site BATLAB).
#
# Uso:
#   powershell -ExecutionPolicy Bypass -File tools\build-problems.ps1

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$enc  = New-Object System.Text.UTF8Encoding($false)

$problemsDir = Join-Path $root 'problems'
$site        = Join-Path $root 'site'
$projectsJson = Join-Path $site 'projects.json'

$bad = @()
$warn = @()
$items = @()

$known = @{}
if (Test-Path -LiteralPath $projectsJson) {
    $tools = Get-Content -LiteralPath $projectsJson -Raw -Encoding UTF8 | ConvertFrom-Json
    foreach ($t in @($tools)) { $known[$t.slug] = $true }
}

$files = Get-ChildItem -LiteralPath $problemsDir -Filter '*.json' -File | Sort-Object Name
foreach ($f in $files) {
    try {
        $obj = Get-Content -LiteralPath $f.FullName -Raw -Encoding UTF8 | ConvertFrom-Json
    } catch {
        $bad += "$($f.Name) :: JSON invalido: $($_.Exception.Message)"
        continue
    }
    $id = [string]$obj.id
    if (-not $id) { $bad += "$($f.Name) :: falta 'id'"; continue }
    if ($id -ne $f.BaseName) { $bad += "$($f.Name) :: id='$id' nao bate com o arquivo" }
    if (-not $obj.title)  { $bad += "$($f.Name) :: falta 'title'" }
    if (-not $obj.desc)   { $bad += "$($f.Name) :: falta 'desc'" }
    if ($null -eq $obj.order) { $bad += "$($f.Name) :: falta 'order'" }
    $kw = @($obj.keywords)
    if ($kw.Count -eq 0) { $bad += "$($f.Name) :: 'keywords' vazio" }
    $tl = @($obj.tools)
    foreach ($s in $tl) {
        if ($known.Count -gt 0 -and -not $known.ContainsKey([string]$s)) {
            $warn += "$id :: slug nao encontrado em projects.json: $s"
        }
    }
    $items += [pscustomobject]@{
        id       = $id
        order    = [int]$obj.order
        title    = [string]$obj.title
        desc     = [string]$obj.desc
        keywords = @($kw | ForEach-Object { [string]$_ })
        tools    = @($tl | ForEach-Object { [string]$_ })
    }
}

# order unico
$dupOrder = $items | Group-Object order | Where-Object Count -gt 1
foreach ($d in $dupOrder) { $bad += "order duplicado: $($d.Name)" }

if ($bad.Count -gt 0) {
    Write-Host "PROBLEMAS EM problems/:" -ForegroundColor Red
    $bad | ForEach-Object { Write-Host "  $_" -ForegroundColor Red }
    exit 1
}

$out = $items | Sort-Object order
if (-not (Test-Path $site)) { New-Item -ItemType Directory -Path $site | Out-Null }
$outPath = Join-Path $site 'problems.json'
$json = $out | ConvertTo-Json -Depth 4
[System.IO.File]::WriteAllText($outPath, $json, $enc)
$webData = Join-Path $root 'web\src\data'
if (Test-Path (Join-Path $root 'web')) {
    if (-not (Test-Path $webData)) { New-Item -ItemType Directory -Path $webData | Out-Null }
    [System.IO.File]::WriteAllText((Join-Path $webData 'problems.json'), $json, $enc)
}

Write-Host "Gerado: $outPath" -ForegroundColor Green
Write-Host "Total : $($out.Count) problemas" -ForegroundColor Green
if ($warn.Count -gt 0) {
    Write-Host "AVISOS (slugs ainda nao existentes):" -ForegroundColor Yellow
    $warn | ForEach-Object { Write-Host "  $_" -ForegroundColor Yellow }
}
