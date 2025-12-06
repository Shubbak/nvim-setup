#!/bin/bash


command_exists() {
    command -v "$1" &>/dev/null
}

list_apts=(
    "wget"
    "unzip"
    "neovim"
)


missing_packages=()
for apt in "${list_apts[@]}"; do
    if ! command_exists "$apt"; then
        missing_packages+=("$apt")
    fi
done

if [ ${#missing_packages[@]} -gt 0 ]; then
    sudo -v
    echo "installing missing packages: ${missing_packages[*]}"
    sudo apt install -y "${missing_packages[@]}" 
else
    echo "all packages are installed"
fi

sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install --only-upgrade neovim

if ! command_exists neovide; then
    echo "Neovide is not installed."

    read -p "Do you want to install neovide? (y/n)" choice

    # Convert input to lowercase
    choice=${choice,,}

    if [[ "$choice" == "y" ]]; then

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
          mkdir -p $HOME/Apps
          git clone https://github.com/neovide/neovide.git $HOME/Apps/neovide
          cd $HOME/Apps/neovide || exit
          cargo build --release
          sudo mv ./target/release/neovide /usr/local/bin/

          echo "Neovide has been installed."
      else
          echo "Neovide is already installed."
    fi
fi


read -p "Do you want to set up LSP for Python and LaTeX? (y/n)" choice
choice=${choice,,}
if [[ "$choice" == "y" ]]; then
    echo "Installing npm, luarocks, tree-sitter, and pyright..."

    if ! command_exists npm; then
        echo "npm not found, installing..."
        sudo apt install -y npm
        echo "npm installed."
    else
        echo "npm already installed"
    fi


    if ! command_exists luarocks; then
        echo "luarocks not found, installing..."
        sudo apt install -y luarocks
        echo "luarocks installed."
    else
        echo "luarocks already installes"
    fi


    if ! command_exists tree-sitter; then
        echo "tree-sitter not found, installing..."
        sudo npm install -g tree-sitter-cli
        echo "tree-sitter installed."
    else
        echo "tree-sitter already installed"
    fi

    if ! command_exists pyright; then
        echo "pyright not found, installing..."
        sudo npm install -g pyright
        echo "pyright installed."
    else
        echo "pyright already installed"
    fi

    if ! command_exists texlab; then
        echo "texlab not found, installing..."
        wget -q https://github.com/latex-lsp/texlab/releases/download/v5.22.1/texlab-x86_64-linux.tar.gz
        tar -xzf texlab-x86_64-linux.tar.gz
        sudo mv texlab /usr/local/bin/
        rm texlab-x86_64-linux.tar.gz
        echo "texlab installed."
    else
        echo "texlab already installed"
    fi
else
    echo "Skipping LSP setup"
fi

# Function to prompt user for TeX Live installation
choose_texlive_option() {
    while true; do
        echo -e "\nChoose TeX Live installation:\n"
        echo "  full  - Install texlive-full (~6GB, never worry about packages)"
        echo "  small - Install a science-based TeX Live setup"
        echo "  no    - Skip TeX Live installation"
        echo " hint: I only had trouble with anything but 'full', so only install anything else if space is a MAJOR concern."
        read -p "Your choice: " choice

        # Convert input to lowercase
        choice=${choice,,}

        if [[ "$choice" == "full" ]]; then
            echo "Installing full TeX Live..."
            sudo apt update && sudo apt install -y texlive-full
            echo "TeX Live installation complete!"
            break
        elif [[ "$choice" == "small" ]]; then
            echo "Installing minimal TeX Live..."
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
if command_exists tex || command_exits pdflatex; then
    echo "TeX Live is installed."
else
    choose_texlive_option
fi


# Install FiraCode Nerd Font Mono if not installed

FONT_NAME_MESLO="FiraCode Nerd Font Mono"
FONT_NAME_KAWKAB="Kawkab Mono"
FONT_DIR="$HOME/.local/share/fonts"

if [ ! -d "$FONT_DIR" ]
then
    mkdir -p "$FONT_DIR"
fi

if ! fc-list | grep -q "$FONT_NAME_MESLO"; then
    echo "$FONT_NAME_MESLO not found, installing..."
    FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/FiraCode.zip"
    FONT_ARCHIVE="$FONT_DIR/FiraCode.zip"

    wget -q -O "$FONT_ARCHIVE" "$FONT_URL"
    unzip -q "$FONT_ARCHIVE" -d "$FONT_DIR"
    fc-cache -fv
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
    fc-cache -fv
    rm "$FONT_ARCHIVE"

    echo "$FONT_NAME_KAWKAB installed successfully."
else
    echo "$FONT_NAME_KAWKAB is already installed."
fi


