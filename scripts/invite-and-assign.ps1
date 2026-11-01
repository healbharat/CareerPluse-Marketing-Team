# CareerPluse — collaborators + 60 Issue assignments
# Run from Windows PowerShell after: gh auth login
# Step 1 sends collaboration invitations (students must accept).
# Step 2 assigns only after their effective repo permission is write/maintain/admin.
$ErrorActionPreference = "Stop"
$Repo = "healbharat/CareerPluse-Marketing-Team"
$People = @(
    @{ Name="Pragati"; Login="PragatiC-code"; Label="owner:pragati" },
    @{ Name="Rupam"; Login="Rupamrocks"; Label="owner:rupam" },
    @{ Name="Mannu Sharma"; Login="mannusharma8397"; Label="owner:mannu" },
    @{ Name="Shrushti"; Login="srushtip223"; Label="owner:shrushti" }
)
& gh auth status
if ($LASTEXITCODE -ne 0) { throw "Run gh auth login first." }
Write-Host "Repository: $Repo"
foreach ($p in $People) {
    $login = $p.Login
    $url = "repos/$Repo/collaborators/$login"
    $json = & gh api $url --method PUT -f permission=push 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "Could not invite $login : $json"
    } else {
        Write-Host "Invitation requested for $($p.Name) (@$login). Check GitHub invitation acceptance."
    }
}
Write-Host ""
Write-Host "IMPORTANT: Students must accept repository invitations before assignments can be made."
Write-Host "After acceptance, run this script again. Invitations will not duplicate existing collaborators."
foreach ($p in $People) {
    $login = $p.Login
    $permissionJson = & gh api "repos/$Repo/collaborators/$login/permission" 2>$null
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "Cannot verify permission for $login yet. Skipping."
        continue
    }
    $permission = ($permissionJson | ConvertFrom-Json).permission
    if (@("write","maintain","admin") -notcontains $permission) {
        Write-Warning "$login has $permission access; must accept invitation first. Skipping 15 assignments."
        continue
    }
    $items = & gh issue list --repo $Repo --state all --label $p.Label --limit 100 --json number,title,assignees | ConvertFrom-Json
    if ($LASTEXITCODE -ne 0) { throw "Failed to list issues for $login" }
    $assigned = 0
    foreach ($issue in $items) {
        if (@($issue.assignees | ForEach-Object { $_.login }) -contains $login) {
            $assigned++
            continue
        }
        & gh issue edit $issue.number --repo $Repo --add-assignee $login
        if ($LASTEXITCODE -ne 0) {
            Write-Warning "Issue #$($issue.number) assignment failed for $login"
            continue
        }
        $assigned++
    }
    Write-Host "$($p.Name): $assigned/$($items.Count) issues assigned or already assigned"
}
Write-Host "Verify: https://github.com/$Repo/issues"
