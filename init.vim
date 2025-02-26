"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""               
"               
"               ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"               ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"               ██║   ██║██║██╔████╔██║██████╔╝██║     
"               ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║     
"                ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"                 ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
"               
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""               

" ============================================================================== 
" Neovim init.vim - Optimized for working on Ubuntu as well as Windows 
" Place this file at: ~/.config/nvim/init.vim for Ubuntu or
" ~\AppData\Local\nvim\init.vim for Windows.
" ============================================================================== 
 
" Set leader key to comma 
let mapleader=","

" ------------------------------------------------------------------------------ 
if has('win32') || has('win64')
    luafile ~\AppData\Local\nvim\lua\plugins.lua
else
    luafile ~/.config/nvim/lua/plugins.lua
endif
 
" ------------------------------------------------------------------------------ 
if has('win32') || has('win64')
    luafile ~\AppData\Local\nvim\lua\settings.lua
else
    luafile ~/.config/nvim/lua/settings.lua
endif
 
" ------------------------------------------------------------------------------ 
if has('win32') || has('win64')
    luafile ~\AppData\Local\nvim\lua\keymaps.lua
else
    luafile ~/.config/nvim/lua/keymaps.lua
endif



" GUI SPECIFIC SETTINGS (if using a GUI client for Neovim) ----------{{{ 
" ------------------------------------------------------------------------------ 
if has('gui_running') 
    " Set the GUI font 
    set guifont=MesloLGM\ Nerd\ Font\ Mono

    " Optionally, open NERDTree on startup: 
    " au VimEnter * NERDTree 
 
    " Enable German spell checking 
    set spell spelllang=de 
 
    " Use a preferred colorscheme for GUI 
    " colorscheme one 
    " set background=dark 
else 
    " For terminal Neovim, use a different colorscheme 
    " colorscheme gruvbox 
    " set background=dark 

    " Set terminal cursor shape settings 
    let &t_SI = "\e[5 q" 
    let &t_EI = "\e[2 q" 
endif 
 
colorscheme gruvbox 
set background=dark 

" Disable error and visual bells 
set noerrorbells visualbell t_vb= 
if has('autocmd') 
  autocmd GUIEnter * set visualbell t_vb= 
endif 

function! Performance() " lets neovide run smoother
    " Reduce cursor animation time  
    let g:neovide_cursor_animation_length = 0  

    " Disable cursor trail  
    let g:neovide_cursor_trail_length = 0  

    " Disable floating blur (if enabled)  
    let g:neovide_floating_blur = 0  

    " Lower refresh rate (default is 60)  
    let g:neovide_refresh_rate = 30  

    " Disable idle animation updates  
    let g:neovide_no_idle = v:true  
endfunction

" ---}}}
 
" ------------------------------------------------------------------------------ 
" STATUS LINE CONFIGURATION ----------{{{ 
" ------------------------------------------------------------------------------ 
set statusline= 
set statusline+=%f              " File path 
set statusline+=\ %Y            " File type 
set statusline+=%=              " Separator between left and right 
set statusline+=ascii:\ %b     " ASCII code of character under cursor 
set statusline+=\ hex:\ 0x%B   " Hex code of character under cursor 
set statusline+=\ %p%%          " Percentage through file 
set statusline+=\ %04l          " Zero-padded line number 
set statusline+=:               " Separator for column 
set statusline+=%-2c            " Column number (padded) 
set statusline+=\ %m            " Modified flag 
set laststatus=2 
" ---}}}
 
" ------------------------------------------------------------------------------ 
" LANGUAGE SPECIFIC FUNCTIONS AND MAPPINGS----------{{{  
" ------------------------------------------------------------------------------ 
 
function! EngType() 
    " Switch to English (default US keyboard) 
    set keymap= 
    set norightleft 
    set nodelcombine 
    inoremap jk <ESC> 
endfunction 
 
function! AraType() 
    " Switch to Arabic (using a custom arabic-pc keymap) 
    set delcombine
    set keymap=arabic-pc
    set rightleft
    " silent "iunmap jk"
    iunmap jk
    set guifont=Kawkab\ Mono
    set nospell 
endfunction 
 
function! TranscriptType() 
    " Switch to Arabic transcript keymap 
    set keymap=arabic-transcript 
    set norightleft 
    set nodelcombine 
    iunmap jk
endfunction 

function! FontMeslo() 
    " Quickly switch to Courier New font for Arabic text in GUI mode 
    " set guifont=Courier\ New:h14 
    " set guifont=Kawkab\ Mono
    set guifont=MesloLGM\ Nerd\ Font\ Mono
    set spell 
endfunction 
 
nnoremap <Leader>e :<C-U>call EngType()<CR> 
nnoremap <Leader>a :<C-U>call AraType()<CR> 
nnoremap <Leader>t :<C-U>call TranscriptType()<CR> 
nnoremap <Leader>f :<C-U>call FontMeslo()<CR> 
 
" ---}}}
" ------------------------------------------------------------------------------ 
"
" FOLDING SETTINGS  ----------{{{

" Set default foldmethod to 'syntax' (can be 'indent' or 'manual')
set foldmethod=syntax
set foldlevel=1

" Automatically set folding for specific file types
augroup filetype_folding
  autocmd!
  
  " Enable folding for Python files based on indentation 
  autocmd FileType python setlocal foldmethod=indent 
  "
  " Enable folding for Tex files based on markers 
  autocmd FileType tex setlocal foldmethod=marker 

augroup END
"---}}}
"
"
" vim:set fdm=marker fdl=0:

