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

if has('win32') || has('win64')
    luafile ~\AppData\Local\nvim\lua_settings.lua
else
    luafile ~/.config/nvim/lua_settings.lua
endif
 
 
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

