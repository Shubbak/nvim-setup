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
+ In case you want to add an alias in Windows, call `nvim $PROFILE` and add `New-Alias your-alias nvim` to the last line
+ If in Windows running the script doesn't do anything, try running winget and see if it prompts you to grant it rights.
+ If scripts can't run in Windows, `Get-ExecutionPolicy` and if Restricted `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser`
+ You will need to install lsp-servers manually. maybe a #todo to automate it

# Various other things I'll need
## Connect smb server (exp4)
```
sudo apt install cifs-utils smbclient
mkdir -p /mnt/exp4_all
sudo mount -t cifs -o username=username,password=password,domain=its-ad \\\\smb.domain.de\\server /mnt/exp4_all/
```
