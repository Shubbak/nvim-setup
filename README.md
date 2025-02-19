# Intro
This is setup to configure neovim with a few key considerations:
+ Arabic support
+ latex Snippets
+ Works on linux and Windows

# How to use
## On Linux
+ Clone the Repo into `~/.config/nvim/`
```bash
git clone https://github.com/Shubbak/nvim-setup.git ~/.config/nvim
```
+ Make sure the script in `~/.config/nvim/scripts` is executable
```bash
chmod +x ~/.config/nvim/scripts/script_linux.sh
```
+ Run the appropriate script in `~/.config/nvim/scripts`
```bash
~/.config/nvim/scripts/script_linux.sh
``` 

## On Windows
+ Clone the Repo into `~\AppData\Local\`
```bash
git clone https://github.com/Shubbak/nvim-setup.git $env:USERPROFILE\AppData\Local\nvim
```
+ Run the appropriate script in `.\nvim-setup\scripts`
```Powershell
~\AppData\Local\nvim\scripts\script_windows.ps1
```


# Additional considerations:
+ Check whether the two fonts `MesloLGM Nerd Font Mono` and `Kawkab Mono` are correctly installed.
+ Check whether nvim can access python3 with `:checkhealth provider.python`
+ Recommended to install latexmk (included in Linux script)
+ Sometimes neovide just doesn't want to. In that case ask ChatGPT :)

