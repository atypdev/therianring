# Check if running with elevated privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Please run this script with elevated privileges (Run as administrator)." -ForegroundColor Red
    exit 1
}

# Build Jekyll site
Write-Host "Building Jekyll site..."
bundle exec jekyll build

# Check if build succeeded
if ($LASTEXITCODE -eq 0) {
    Write-Host "Jekyll build succeeded."
} else {
    Write-Host "Jekyll build failed. Exiting..." -ForegroundColor Red
    exit 1
}

# Default Apache htdocs location
$apache_htdocs = "C:\Apache24\htdocs"

# Move contents of _site directory to Apache htdocs location
Write-Host "Moving _site directory to Apache htdocs location..."
Move-Item -Path "..\_site\*" -Destination $apache_htdocs -Force

# Check if move succeeded
if ($LASTEXITCODE -eq 0) {
    Write-Host "Site successfully deployed to Apache htdocs location."
} else {
    Write-Host "Failed to deploy site to Apache htdocs location. Exiting..." -ForegroundColor Red
    exit 1
}

Write-Host "Script execution completed."
