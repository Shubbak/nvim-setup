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
luafile ~/.config/nvim/lua/plugins.lua
 
" ------------------------------------------------------------------------------ 
" GENERAL SETTINGS ----------{{{ 
" ------------------------------------------------------------------------------ 
 
" Enable syntax highlighting 
syntax on 

" Enable modeline which means that a comment starting with vim: will override
" settings per file
set modeline
 
" Line numbering: absolute and relative toggle 
set number 
set relativenumber

if has('autocmd') 
  augroup numbertoggle 
    autocmd! 
    " When entering insert mode, disable relative numbers
    autocmd InsertEnter * set norelativenumber
    " When leaving insert mode, enable relative numbers
    autocmd InsertLeave * set relativenumber
  augroup END 
else 
  set rnu 
endif 
 
" Disable swap files 
set noswapfile 
 
" Search settings 
set hlsearch 
set ignorecase 
set smartcase 
set incsearch 
set showcmd 
set showmode 
set showmatch 
 
" Disable persistent undo and backup files 
set noundofile 
set nobackup 
 
" Scrolling and wrapping 
set scrolloff=7 
set nowrap 
 
" File type detection and plugins 
set nocompatible 
filetype on 
filetype plugin on 
filetype indent on 
 
" Highlight the current line 
set cursorline 
 
" Indentation settings 
set shiftwidth=4 
set tabstop=4 
set expandtab 
 
" Increase command history size 
set history=1000 
" ---}}}
 
" ------------------------------------------------------------------------------ 
" KEY MAPPINGS ----------{{{ 
" ------------------------------------------------------------------------------ 
 
" Exit insert mode with <M-SPACE> or 'jk' 
" inoremap <M-SPACE> <ESC>
inoremap jk <ESC>
inoremap <M-i> <ESC>o\item<Space> 
nnoremap <M-i> o\item<Space> 
 
 
" Map space to enter command mode 
nnoremap <space> : 
 
" Center search results after moving with n/N 
nnoremap n nzz 
nnoremap N Nzz 
 
" Yank to the end of the line with Y 
nnoremap Y y$ 
 
" Map F5 to run the current Python script (saves, clears terminal, executes) 
" nnoremap <F5> :w<CR>:!clear<CR>:!python %<CR> 
nnoremap <F5> :w<CR>:!gnome-terminal -- bash -c "python3 %; exec bash"<CR>
 

" Window splitting and navigation 
nnoremap <C-j> <C-w>j 
nnoremap <C-k> <C-w>k 
nnoremap <C-h> <C-w>h 
nnoremap <C-l> <C-w>l 
 
" Resize split windows with arrow keys 
nnoremap <C-Up>    <C-w>+ 
nnoremap <C-Down>  <C-w>- 
nnoremap <C-Left>  <C-w>< 
nnoremap <C-Right> <C-w>> 
 
" Toggle NERDTree with leader+nt 
nnoremap <leader>nt :NERDTreeToggle<CR> 
 
" Set files/directories to ignore in NERDTree 
let NERDTreeIgnore = ['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$', '\.aux$', '\.bbl$', '\.bcf$', '\.blg$', '\.fdb_latexmk$', '\.fls$', '\.glg$', '\.glo$', '\.gls$', '\.ist$', '\.log$', '\.out$', '\.xml$', '\.gz$', '\.latexmain$', '\.toc$', '\.xdv$', '\.tdn$', '\.tld$', '\.tlg', '\.bdn', '\.bld', '\.ldn', '\.lld', '\.llg', '\.ttf', '\.zip'] 
 
 
" Map the Guillemet symbol
" inoremap << «
" inoremap >> »
"
" Map enter to open new line without leaving normal mode
nnoremap <enter> o<esc>k

nnoremap <leader>s :VimtexView<CR>

" ---}}}

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
 
colorscheme one 
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

