
# Windows PowerShell script for installing Neovim, Neovide, and fonts

# Check if winget is installed
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "Winget is not installed. Please install Winget first."
    exit 1
}

# --- Install Neovim ---
# Winget package ID for Neovim is assumed to be "Neovim.Neovim"
$nvimInstalled = winget list --id Neovim.Neovim -e | Select-String "Neovim"
if (-not $nvimInstalled) {
    Write-Host "Neovim is not installed. Installing Neovim..."
    winget install --id Neovim.Neovim --exact --silent
    Write-Host "Neovim installation complete!"
} else {
    Write-Host "Neovim is already installed."
}

# --- Install Neovide ---
# Adjust the package ID as needed; here we assume "Neovide.Neovide"
$neovideInstalled = winget list --id Neovide.Neovide -e | Select-String "Neovide"
if (-not $neovideInstalled) {
    Write-Host "Neovide is not installed. Installing Neovide..."
    winget install --id Neovide.Neovide --exact --silent
    Write-Host "Neovide installed."
} else {
    Write-Host "Neovide is already installed."
}

# --- Install Fonts ---
$FONT_NAME_MESLO = "MesloLGM Nerd Font Mono"
$FONT_NAME_KAWKAB = "Kawkab Mono"
# We'll use the user fonts folder (requires no admin rights)
$FontDir = "$env:LOCALAPPDATA\Microsoft\Windows\Fonts"

if (-not (Test-Path $FontDir)) {
    New-Item -ItemType Directory -Path $FontDir | Out-Null
}

# Check for MesloLGM Nerd Font Mono by looking for one of its known files
$mesloFontFile = Join-Path $FontDir "MesloLGM NF Regular.ttf"
if (-not (Test-Path $mesloFontFile)) {
    Write-Host "$FONT_NAME_MESLO not found, installing..."
    $mesloUrl = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip"
    $mesloZip = Join-Path $FontDir "Meslo.zip"
    
    Invoke-WebRequest -Uri $mesloUrl -OutFile $mesloZip -UseBasicParsing
    Expand-Archive -Path $mesloZip -DestinationPath $FontDir -Force
    Remove-Item $mesloZip
    Write-Host "$FONT_NAME_MESLO installed successfully."
} else {
    Write-Host "$FONT_NAME_MESLO is already installed."
}

# Check for Kawkab Mono by verifying a known file.
# (Adjust the filename as per what the zip provides. Here we assume "KawkabMono-Regular.ttf".)
$kawkabFontFile = Join-Path $FontDir "KawkabMono-Regular.ttf"
if (-not (Test-Path $kawkabFontFile)) {
    Write-Host "$FONT_NAME_KAWKAB not found, installing..."
    $kawkabUrl = "https://makkuk.com/kawkab-mono/downloads/kawkab-mono-0.500.zip"
    $kawkabZip = Join-Path $FontDir "kawkab-mono-0.500.zip"
    
    Invoke-WebRequest -Uri $kawkabUrl -OutFile $kawkabZip -UseBasicParsing
    Expand-Archive -Path $kawkabZip -DestinationPath $FontDir -Force
    Remove-Item $kawkabZip
    Write-Host "$FONT_NAME_KAWKAB installed successfully."
} else {
    Write-Host "$FONT_NAME_KAWKAB is already installed."
}
