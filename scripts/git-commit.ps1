$project = "F:\Projetos\udemy\ansible"
Set-Location $project
git checkout main
git pull
git status
$out = git status
$check = $null
$check = $out | Select-String -Pattern "untracked", "modified"
If ($null -ne $check ) {
    Write-Host -ForegroundColor Red "Uncommitted files found"
    $commit = Read-Host -Prompt "Enter comment for commit"
    #$commit = "feat: Add new examples"
    git add .
    git commit -m $commit
    git push origin main
    $out = git status
    $check = $null
    $check = $out | Select-String -Pattern "untracked"
    If ($null -ne $check ) {
        Write-Host -ForegroundColor Red "Commit failed!!!"
    }
    Else {
        Write-Host -ForegroundColor Green "Commit Success!!!"
    }
}