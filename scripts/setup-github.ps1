# CareerPluse marketing public GitHub repository setup. Safe to rerun after interruption.
# Creates repo only if missing; never overwrites a different existing repo.
# Windows PowerShell 5.1 treats CLI stderr (including normal Git push progress) as errors
# with Stop. Every native CLI command below is checked using its exit code.
$ErrorActionPreference = 'Continue'
$Root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
Set-Location $Root

function Check-Exit([string]$Step) {
    if ($LASTEXITCODE -ne 0) { throw "$Step failed (exit code $LASTEXITCODE)." }
}

# Probe a missing GitHub repo without treating its expected 404 on stderr as a
# terminating Windows PowerShell 5.1 NativeCommandError.
function Get-RepoProbe([string]$FullName) {
    $outFile = [System.IO.Path]::GetTempFileName()
    $errFile = [System.IO.Path]::GetTempFileName()
    try {
        $ghPath = (Get-Command gh -ErrorAction Stop).Source
        $p = Start-Process -FilePath $ghPath -ArgumentList @('repo','view',$FullName,'--json','description') -NoNewWindow -Wait -PassThru -RedirectStandardOutput $outFile -RedirectStandardError $errFile -ErrorAction Stop
        $outText = [System.IO.File]::ReadAllText($outFile)
        $errText = [System.IO.File]::ReadAllText($errFile)
        if ($p.ExitCode -eq 0) {
            return @{ Found = $true; Data = ($outText | ConvertFrom-Json -ErrorAction Stop) }
        }
        if ($errText -match 'Could not resolve to a Repository|HTTP 404|Not Found|not found') {
            return @{ Found = $false; Data = $null }
        }
        throw "Could not check $FullName. GitHub CLI said: $errText"
    } finally {
        Remove-Item $outFile, $errFile -Force -ErrorAction SilentlyContinue
    }
}

if (-not (Get-Command gh -ErrorAction SilentlyContinue)) { throw 'GitHub CLI missing: https://cli.github.com/' }
if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw 'Git missing: https://git-scm.com/downloads' }
$owner = (& gh api user --jq '.login').Trim()
Check-Exit 'Get authenticated GitHub account'
if (-not $owner) { throw 'GitHub CLI is not authenticated. Run: gh auth login' }
$Repo = "$owner/CareerPluse-Marketing-Team"
$description = 'CareerPluse 15-day student marketing team tasks, SOP, and KPI reporting'
Write-Host "GitHub account: $owner" -ForegroundColor Cyan
Write-Host "Target PUBLIC repository: $Repo" -ForegroundColor Cyan

$probe = Get-RepoProbe $Repo
if ($probe.Found -and $probe.Data.description -ne $description) {
    throw "A repository with the name $Repo already exists but is not marked as this campaign. Refusing to overwrite it."
}

if (-not (Test-Path .git)) { & git init -b main | Out-Host; Check-Exit 'Git initialize' }
if (-not (git config user.name)) { & git config user.name $owner; Check-Exit 'Set Git user name' }
if (-not (git config user.email)) { & git config user.email "$owner@users.noreply.github.com"; Check-Exit 'Set Git email' }
& git add README.md SETUP_WINDOWS.md START_HERE.bat docs scripts issues.json .github .gitignore
Check-Exit 'Stage documentation and 60 issue definitions'
& git diff --cached --quiet
if ($LASTEXITCODE -eq 1) {
    & git commit -m 'CareerPluse public marketing plan and 60 task definitions' | Out-Host
    Check-Exit 'Commit task documents'
} elseif ($LASTEXITCODE -ne 0) { throw 'Could not inspect Git staged changes.' }

if (-not $probe.Found) {
    Write-Host 'Repository does not exist. Creating it now...' -ForegroundColor Yellow
    & gh repo create $Repo --public --source . --remote origin --push --description $description | Out-Host
    Check-Exit 'Create public repository and push files'
} else {
    Write-Host 'Found an earlier setup attempt; safely continuing.' -ForegroundColor Yellow
    $remotes = @(& git remote)
    if ($remotes -notcontains 'origin') { & git remote add origin "https://github.com/$Repo.git"; Check-Exit 'Set origin remote' }
    & git push -u origin main | Out-Host
    Check-Exit 'Push campaign documentation'
}

Write-Host "Repository ready: https://github.com/$Repo" -ForegroundColor Green
Write-Host 'Importing the 60 GitHub Issues. This may take some time...' -ForegroundColor Cyan
& (Join-Path $PSScriptRoot 'import-issues.ps1') -Repo $Repo
if (-not $?) { throw 'Issue import did not finish. Rerun START_HERE.bat after checking the error.' }
Write-Host "DONE: https://github.com/$Repo/issues" -ForegroundColor Green
