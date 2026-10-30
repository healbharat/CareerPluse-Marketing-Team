param(
    [Parameter(Mandatory=$false)]
    [string]$Repo = ""
)
$ErrorActionPreference = 'Stop'
$Root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
if (-not (Get-Command gh -ErrorAction SilentlyContinue)) { throw 'Install GitHub CLI (gh) first: https://cli.github.com/' }
gh auth status 2>$null | Out-Null
if ($LASTEXITCODE -ne 0) { throw 'Run gh auth login first and authorize the account that owns the repo.' }
$owner = (gh api user --jq '.login').Trim()
if ($LASTEXITCODE -ne 0 -or -not $owner) { throw 'GitHub login lookup failed.' }
if (-not $Repo) { $Repo = "$owner/CareerPluse-Marketing-Team" }
gh repo view $Repo --json name | Out-Null
if ($LASTEXITCODE -ne 0) { throw "Repository not accessible: $Repo" }

$all = Get-Content (Join-Path $Root 'issues.json') -Raw -Encoding UTF8 | ConvertFrom-Json
if ($all.Count -ne 60) { throw "Expected 60 tasks, found $($all.Count). Aborting." }
$labelsToAdd = @{}
foreach($item in $all) { foreach($label in $item.labels) { $labelsToAdd[$label] = $true } }
$labelNames = @(gh label list --repo $Repo --limit 200 --json name --jq '.[].name')
foreach ($label in $labelsToAdd.Keys) {
    if ($labelNames -notcontains $label) {
        $colour = if ($label.StartsWith('owner:')) { '1D76DB' } elseif ($label.StartsWith('day:')) { 'BFD4F2' } elseif ($label.StartsWith('status:')) { 'FEF2C0' } else { 'D4C5F9' }
        gh label create $label --repo $Repo --color $colour --description 'CareerPluse marketing task tag' | Out-Null
        if ($LASTEXITCODE -ne 0) { throw "Failed creating label: $label" }
    }
}
$existingTitles = @(gh issue list --repo $Repo --state all --limit 500 --json title --jq '.[].title')
if ($LASTEXITCODE -ne 0) { throw 'Cannot list Issues. Check GitHub Issues are enabled and permissions are granted.' }
$made = 0; $skipped = 0
foreach($item in $all) {
    if ($existingTitles -contains $item.title) { Write-Host "SKIP $($item.key) (already exists)"; $skipped++; continue }
    $tmp = New-TemporaryFile
    try {
       [System.IO.File]::WriteAllText($tmp.FullName, [string]$item.body, (New-Object System.Text.UTF8Encoding($false)))
       $labelArg = ($item.labels -join ',')
       gh issue create --repo $Repo --title $item.title --body-file $tmp.FullName --label $labelArg | Out-Host
       if ($LASTEXITCODE -ne 0) { throw "Issue creation failed: $($item.key). Rerun this script after fixing the error." }
       $made++
    } finally { Remove-Item $tmp.FullName -Force -ErrorAction SilentlyContinue }
}
Write-Host "Finished: $made created, $skipped already present. Expected total: 60." -ForegroundColor Green
Write-Host "Open https://github.com/$Repo/issues"
