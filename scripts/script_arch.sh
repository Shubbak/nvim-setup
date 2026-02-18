#!/usr/bin/env bash
set -euo pipefail

echo "=== Neovim Setup for EndeavourOS (Arch-based) ==="

# Helper functions
command_exists() { command -v "$1" &>/dev/null; }

ask_yes_no() {
    local prompt="$1"
    local ans
    read -rp "$prompt (y/n): " ans
    ans=${ans,,}  # lowercase
    [[ "$ans" =~ ^(y|yes)$ ]]
}

# 1. Update system
echo "[1/5] Updating system..."
sudo pacman -Syu --noconfirm

# 2. Core dependencies
echo "[2/5] Installing essential tools..."
sudo pacman -S --noconfirm \
  neovim git ripgrep fd python-pynvim nodejs 

# 3. Optional: Tree-sitter
if ask_yes_no "Do you want to install tree-sitter CLI (for Treesitter parsers)?"; then
    sudo pacman -S --noconfirm tree-sitter-cli
fi

# 4. Optional: LSP servers
if ask_yes_no "Do you want to install common LSP servers (Python, TypeScript, Bash, Lua, LaTeX)?"; then
    sudo pacman -S --noconfirm \
        pyright \
        typescript-language-server \
        bash-language-server \
        lua-language-server \
        texlab
    echo "✅ LSP servers installed."
fi

# 5. Optional: Neovide
if ask_yes_no "Do you want to install Neovide (GUI for Neovim)?"; then
    if pacman -Si neovide &>/dev/null; then
        sudo pacman -S --noconfirm neovide
    else
        echo "Neovide not in official repos. Installing via AUR..."
        if ! command_exists yay; then
            echo "Installing yay (AUR helper)..."
            git clone https://aur.archlinux.org/yay.git /tmp/yay
            pushd /tmp/yay
            makepkg -si --noconfirm
            popd
        fi
        yay -S --noconfirm neovide
    fi
    echo "✅ Neovide installed."
fi

# 6. Fonts (Nerd Font for icons)
if ask_yes_no "Do you want to install Nerd Font (Fira Code) for icons?"; then
    sudo pacman -S --noconfirm ttf-firacode-nerd
    fc-cache -fv
fi

echo ""
echo "=== Setup Complete ==="
echo "Next steps:"
echo " • Clone your Neovim config into ~/.config/nvim"
echo " • Open Neovim and run :checkhealth"
echo " • If you installed LSP, verify with :LspInfo or Mason inside Neovim"
