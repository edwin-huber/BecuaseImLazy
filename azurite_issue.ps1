#Usage: .azurite_issue.ps1 -IssueNumber 1234
param( [Parameter(Mandatory=$true)] $IssueNumber)

$issueDir = "azurite_issue_" + $IssueNumber

### Set up a dev environment for the issue
if(!(Test-Path $issueDir)){

    [System.IO.Directory]::CreateDirectory($issueDir)
    Set-Location $issueDir

    git clone 'https://github.com/edwin-huber/azurite'
    
    Set-Location 'Azurite'
    
    git remote add upstream 'https://github.com/azure/azurite'
    
    git checkout main
    # sync origin main with upstream main
    git pull upstream main
    git push
    
    # checkout branch for issue work
    git checkout -b $issueDir
    
    # install dependencies & packages
    npm install
}
else
{
    Set-Location $issueDir
    Set-Location 'Azurite'
}

code .