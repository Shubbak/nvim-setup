
# Windows PowerShell script for installing Neovim, Neovide, and fonts

# Check if winget is installed
if (-not (Get-Command "winget.exe" -ErrorAction SilentlyContinue)) {
    Write-Host "Winget is not installed. Please install Winget first."
    exit 1
}

# --- Check if Python is installed ---
$pythonInstalled = winget list --id Python.Python -e | Out-String

if ($pythonInstalled -match "Python.Python") {
    Write-Host "Python is already installed."
} else {
    Write-Host "Python is not installed. Installing Python..."
    winget install --id Python.Python --exact --silent
    Write-Host "Python installation complete!"
}

# --- Check if pip is installed ---
# We will check if pip is available by running "python -m pip --version"
$pipInstalled = python -m pip --version 2>&1

if ($pipInstalled -match "pip") {
    Write-Host "pip is already installed."
} else {
    Write-Host "pip is not installed. Installing pip..."
    
    # Install pip using ensurepip (Python 3.4+ includes this method)
    python -m ensurepip --upgrade
    Write-Host "pip installation complete!"
}

# --- Check if the Neovim Python package is installed ---
# We will check if the 'neovim' package is installed by running "pip show neovim"
$neovimInstalled = python -m pip show neovim 2>&1

if ($neovimInstalled -match "Name: neovim") {
    Write-Host "Neovim Python package is already installed."
} else {
    Write-Host "Neovim Python package is not installed. Installing..."
    
    # Install the Neovim Python package
    python -m pip install neovim
    Write-Host "Neovim Python package installation complete!"
}

# --- Install Neovim ---
$nvimInstalled = winget list --id Neovim.Neovim -e | Out-String
if ($nvimInstalled -notmatch "Neovim") {
    Write-Host "Neovim is not installed. Installing Neovim..."
    winget install --id Neovim.Neovim --exact --silent
    Write-Host "Neovim installation complete!"
} else {
    Write-Host "Neovim is already installed."
}

# --- Install Neovide ---
$neovideInstalled = winget list --id Neovide.Neovide -e | Out-String
if ($neovideInstalled -notmatch "Neovide") {
    Write-Host "Neovide is not installed. Installing Neovide..."
    winget install --id Neovide.Neovide --exact --silent
    Write-Host "Neovide installed."
} else {
    Write-Host "Neovide is already installed."
}

# --- Install Fonts ---
$FONT_NAME_MESLO = "MesloLGM Nerd Font Mono"
$FONT_NAME_KAWKAB = "Kawkab Mono"
$FontDir = "$env:LOCALAPPDATA\Microsoft\Windows\Fonts"

if (-not (Test-Path $FontDir)) {
    New-Item -ItemType Directory -Path $FontDir | Out-Null
}

$mesloFontFile = Join-Path $FontDir "MesloLGMNerdFontMono-Regular.ttf"
if (-not (Test-Path $mesloFontFile)) {
    Write-Host "$FONT_NAME_MESLO not found, installing..."
    $mesloUrl = "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/FiraCode.zip"
    $mesloZip = Join-Path $FontDir "FiraCode.zip"

    Invoke-WebRequest -Uri $mesloUrl -OutFile $mesloZip -UseBasicParsing
    Expand-Archive -Path $mesloZip -DestinationPath $FontDir -Force
    Remove-Item $mesloZip
    Write-Host "$FONT_NAME_MESLO installed successfully."
} else {
    Write-Host "$FONT_NAME_MESLO is already installed."
}

$kawkabFontFile = Join-Path $FontDir "KawkabMono-Regular.ttf"
if (-not (Test-Path $kawkabFontFile)) {
    Write-Host "$FONT_NAME_KAWKAB not found, installing..."
    $kawkabUrl = "https://makkuk.com/kawkab-mono/downloads/kawkab-mono-0.500.zip"
    $kawkabZip = Join-Path $FontDir "kawkab-mono-0.500.zip"

    Invoke-WebRequest -Uri $kawkabUrl -OutFile $kawkabZip -UseBasicParsing
    Expand-Archive -Path $kawkabZip -DestinationPath $FontDir -Force

    # Move the files out of the subfolder and into the Fonts directory
    $extractedFolder = Join-Path $FontDir "kawkab-mono-0.500"
    if (Test-Path $extractedFolder) {
        Get-ChildItem -Path $extractedFolder -File | Move-Item -Destination $FontDir
        Remove-Item -Recurse -Force $extractedFolder
    }

    Remove-Item $kawkabZip
    Write-Host "$FONT_NAME_KAWKAB installed successfully."
} else {
    Write-Host "$FONT_NAME_KAWKAB is already installed."
}


# Force a refresh of the font files
$fontFiles = Get-ChildItem -Path $fontDir -Filter *.ttf

foreach ($font in $fontFiles) {
    $fontName = [System.IO.Path]::GetFileNameWithoutExtension($font.FullName)
    Write-Host "Registering font: $fontName"
    $fontRegKey = "HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"
    Set-ItemProperty -Path $fontRegKey -Name $fontName -Value $font.FullName
}

& "RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters"

# Add Neovim to PATH if not already present
$nvimPath = "$env:ProgramFiles\Neovim\bin"
$path = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User)

if ($path -notlike "*$nvimPath*") {
    $newPath = "$path;$nvimPath" -replace ';;', ';'
    [System.Environment]::SetEnvironmentVariable("Path", $newPath, [System.EnvironmentVariableTarget]::User)
    Write-Output "Added $nvimPath to PATH. Restart your terminal."
} else {
    Write-Output "$nvimPath is already in PATH."
}

# Install Plugins using vim-plug
& "$nvimPath\nvim.exe" --headless +PlugInstall +qall 2>$null


