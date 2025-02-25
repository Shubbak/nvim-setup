#!/bin/bash


command_exists() {
  command -v "$1" &>/dev/null
}

# Install Snap if not installed
if ! command_exists snap 
then
    echo "Snap is not installed. Installing Snap..."
    sudo apt update
    sudo apt install -y snapd
fi

# Install wget and unzip if not installed

if ! command_exists wget ; then
    echo "wget not found, installing..."
    sudo apt install -y wget
fi

if ! command_exists unzip ; then
    echo "unzip not found, installing..."
    sudo apt install -y unzip
fi

# Install nvim if not installed
if ! command_exists nvim 
then
    echo "Neovim is not installed. Installing Neovim..."
    sudo snap install nvim --classic
    echo "Neovim installation complete!"
else
    echo "Neovim is already installed."
fi

read -p "Do you want to install neovide? (y/n)" choice

# Convert input to lowercase
choice=${choice,,}

if [[ "$choice" == "y" ]]; then

    # Check if neovide is installed
    if ! command_exists neovide; then
      echo "Neovide is not installed."

      # Check if rust is installed
      if ! command_exists rustc; then
        echo "Rust is not installed. Installing Rust..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        source $HOME/.cargo/env
        echo "Rust has been installed."
      else
        echo "Rust is already installed."
      fi

      # Install neovide using rust
      echo "Installing Neovide..."
      git clone https://github.com/neovide/neovide.git
      cd neovide || exit
      cargo build --release
      sudo mv ./target/release/neovide /usr/local/bin/

      echo "Neovide has been installed."
    else
      echo "Neovide is already installed."
    fi
fi

# Install zathura if not installed
if ! command_exists zathura 
then 
    echo "Installing zathura..."
    sudo apt install -y zathura
    echo "zathura installed."
else
    echo "zathura already installed."
fi

# Function to prompt user for TeX Live installation
    choose_texlive_option() {
        while true; do
            echo -e "\nChoose TeX Live installation:\n"
            echo "  full  - Install texlive-full (~6GB, never worry about packages)"
            echo "  small - Install a recommended TeX Live setup"
            echo "  no    - Skip TeX Live installation"
            read -p "Your choice: " choice

            # Convert input to lowercase
            choice=${choice,,}

            if [[ "$choice" == "full" ]]; then
                echo "Installing full TeX Live..."
                sudo apt update && sudo apt install -y texlive-full
                echo "TeX Live installation complete!"
                break
            elif [[ "$choice" == "small" ]]; then
                echo "Installing recommended TeX Live..."
                sudo apt update && sudo apt install -y texlive-latex-extra texlive-xetex texlive-luatex texlive-science
                echo "TeX Live installation complete!"
                break
            elif [[ "$choice" == "no" ]]; then
                echo "Skipping TeX Live installation."
                break
            else
                echo "Invalid choice. Please enter 'full', 'small', or 'no'."
            fi
        done
    }

# Call the function
if command -v tex >/dev/null 2>&1; then
    echo "TeX Live is installed."
else
    choose_texlive_option
fi

# Prompt user for latexmk installation

if command -v latexmk >/dev/null 2>&1; then
    read -p "Do you want to install latexmk? (y/n): " choice

    # Convert input to lowercase to handle 'Y' or 'y'
    choice=${choice,,}

    if [[ "$choice" == "y" ]]; then
        echo "Installing latexmk..."
        sudo apt update
        sudo apt install -y latexmk
        echo "latexmk installation complete!"
    else
        echo "Skipping latexmk installation."
    fi
fi

# Install MesloLGM Nerd Font Mono if not installed

FONT_NAME_MESLO="MesloLGM Nerd Font Mono"
FONT_NAME_KAWKAB="Kawkab Mono"
FONT_DIR="$HOME/.local/share/fonts"

if [ ! -d "$FONT_DIR" ]
then
    mkdir -p "$FONT_DIR"
fi

if ! fc-list | grep -q "$FONT_NAME_MESLO"; then
    echo "$FONT_NAME_MESLO not found, installing..."
    FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip"
        FONT_ARCHIVE="$FONT_DIR/Meslo.zip"
        
        wget -q -O "$FONT_ARCHIVE" "$FONT_URL"
        unzip -q "$FONT_ARCHIVE" -d "$FONT_DIR"
        sudo fc-cache -fv
        rm "$FONT_ARCHIVE"

        echo "$FONT_NAME_MESLO installed successfully."
else
    echo "$FONT_NAME_MESLO is already installed."
fi

if ! fc-list | grep -q "$FONT_NAME_KAWKAB"; then
    echo "$FONT_NAME_KAWKAB not found, installing..."
    FONT_URL="https://makkuk.com/kawkab-mono/downloads/kawkab-mono-0.500.zip"
        FONT_ARCHIVE="$FONT_DIR/kawkab-mono-0.500.zip"
        
        wget -q -O "$FONT_ARCHIVE" "$FONT_URL"
        unzip -q "$FONT_ARCHIVE" -d "$FONT_DIR"
        sudo fc-cache -fv
        rm "$FONT_ARCHIVE"

        echo "$FONT_NAME_KAWKAB installed successfully."
else
    echo "$FONT_NAME_KAWKAB is already installed."
fi

echo "Installing Vim-Plug plugins..."
nvim --headless: +PlugInstall +qall
echo "Plugins installed successfully."

