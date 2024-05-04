$FolderPath = "C:\Users\Ian\GitHub\brave-traveler"

Set-Location -Path $FolderPath

$IsClean = (git diff-index --quiet HEAD --) -or (git diff-files --quiet)

if ($IsClean) {
    Write-Host "Working tree is clean. Skipping commit and pushing changes."
    git push
} else {
    $CommitMessage = "$(Get-Date -Format 'dddd - yyyy-MM-dd HH:mm:ss')"


    git add .
    git commit -m $CommitMessage

    git push
}