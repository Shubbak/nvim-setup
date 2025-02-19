# Intro
This is setup to configure neovim with a few key considerations:
+ Arabic support
+ latex Snippets
+ Works on linux and Windows

# How to use
## On Linux
+ Clone the Repo into any directory (let's call it `.`).
```bash
git clone https://github.com/Shubbak/nvim-setup.git
```
+ Move `./nvim-setup/nvim` to `~/.config/` 
```bash
mv ./nvim-setup/nvim ~/.config/
```
+ Make sure the script in `./nvim-setup/scripts` is executable
```bash
chmod +x ./nvim-setup/scripts/script_linux.sh
```
+ Run the appropriate script in `./nvim-setup/scripts`
```bash
# Navigate to .
./nvim-setup/scripts/script_linux.sh
``` 
+ Open nvim and run `:PlugInstall`

## On Windows
+ Clone the Repo into any directory (let's call it `.`).
```bash
git clone https://github.com/Shubbak/nvim-setup.git
```
+ Move `.\nvim-setup\nvim` to `~\AppData\Local\`
```Powershell
mv .\nvim-setup\nvim ~\AppData\Local\
```
+ Run the appropriate script in `.\nvim-setup\scripts`
```Powershell
# Navigate to .
.\scripts\script_windows.ps1
```


# Additional considerations:
+ Check whether the two fonts `MesloLGM Nerd Font Mono` and `Kawkab Mono` are correctly installed.
+ Check whether nvim can access python3 with `:checkhealth provider.python`
+ Recommended to install latexmk (included in Linux script)


