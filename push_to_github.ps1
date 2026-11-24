# Sri Vignasewra Saree House - PowerShell GitHub Push Helper
Write-Host "=========================================================" -ForegroundColor Yellow
Write-Host "  SRI VIGNASEWRA SAREE HOUSE - Push To GitHub Script     " -ForegroundColor Yellow
Write-Host "=========================================================" -ForegroundColor Yellow
Write-Host ""

$gitPath = "git"
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    $portableGit = "C:\Users\NANDA GOPAL\.gemini\antigravity\scratch\mingit\cmd\git.exe"
    if (Test-Path $portableGit) {
        $gitPath = $portableGit
    } else {
        Write-Host "[ERROR] Git is not found." -ForegroundColor Red
        pause
        exit 1
    }
}

Set-Location "C:\Users\NANDA GOPAL\.gemini\antigravity\scratch\sri-vignasewra-saree-house"

Write-Host "[*] Git ready: $gitPath" -ForegroundColor Cyan
& $gitPath status

Write-Host ""
$repoUrl = Read-Host "Enter your GitHub Repository URL (e.g. https://github.com/USERNAME/sri-vignasewra-saree-house.git)"

if ([string]::IsNullOrWhiteSpace($repoUrl)) {
    Write-Host "[!] No URL entered. Changes remain committed locally on 'main'." -ForegroundColor Yellow
    pause
    exit 0
}

# Configure remote
& $gitPath remote remove origin 2>$null
& $gitPath remote add origin $repoUrl

Write-Host ""
Write-Host "[*] Pushing 'main' branch to GitHub..." -ForegroundColor Cyan
& $gitPath push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "[SUCCESS] Website successfully pushed to GitHub!" -ForegroundColor Green
    Write-Host "To host it live for free on GitHub Pages:" -ForegroundColor Cyan
    Write-Host "1. Go to your repository settings on GitHub"
    Write-Host "2. Click 'Pages' under Code and automation"
    Write-Host "3. Under 'Branch', select 'main' and root (/), then click Save"
} else {
    Write-Host ""
    Write-Host "[!] Push failed. When prompted for password, use your GitHub Personal Access Token." -ForegroundColor Red
}

pause
