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
" Neovim init.vim - Optimized for Ubuntu (adapted from a Windows gvim vimrc) 
" Place this file at: ~/.config/nvim/init.vim 
" ============================================================================== 
 
" ------------------------------------------------------------------------------ 
" PLUGINS (using vim-plug) 
" ------------------------------------------------------------------------------ 
call plug#begin('~/.local/share/nvim/plugged') 
 
" NERDTree for file browsing 
Plug 'preservim/nerdtree' 
 
" LaTeX support via vimtex and tex-conceal 
Plug 'lervag/vimtex' 
let g:tex_flavor = 'latex' 
" For Ubuntu, we typically use zathura as the PDF viewer: 
let g:vimtex_view_method = 'zathura' 
" Alternative viewer settings (for reference): 
" let g:vimtex_view_general_viewer = 'okular' 
" let g:vimtex_view_general_options = '--unique file:@pdf#src:@line@tex' 
let g:vimtex_quickfix_mode = 0 
let g:vimtex_complete_close_braces = 1 
 
Plug 'KeitaNakamura/tex-conceal.vim' 
set conceallevel=1 
let g:tex_conceal = 'abdmg' 
hi Conceal ctermbg=none 
 
" Snippets with UltiSnips 
Plug 'sirver/ultisnips' 
let g:UltiSnipsExpandTrigger = '<tab>' 
let g:UltiSnipsJumpForwardTrigger = '<tab>' 
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>' 
 
" Git integration with vim-fugitive 
Plug 'tpope/vim-fugitive' 

Plug 'morhetz/gruvbox'
Plug 'rakr/vim-one'

call plug#end() 
 
" ------------------------------------------------------------------------------ 
" GENERAL SETTINGS 
" ------------------------------------------------------------------------------ 
 
" Enable syntax highlighting 
syntax on 
 
" Line numbering: absolute and relative toggle 
set number 

" if has('autocmd') 
  " augroup numbertoggle 
    " autocmd! 
    " autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &number && mode() != "i" | set rnu | endif 
    " autocmd BufLeave,FocusLost,InsertEnter,WinLeave * if &number | set nornu | endif 
  " augroup END 
" else 
  " set rnu 
" endif 
 
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
 
" ------------------------------------------------------------------------------ 
" KEY MAPPINGS 
" ------------------------------------------------------------------------------ 
 
" Exit insert mode with <M-SPACE> or 'jk' 
inoremap <M-SPACE> <ESC> 
inoremap jk <ESC> 
inoremap <M-i> <ESC>o\item<Space> 
nnoremap <M-i> o\item<Space> 
 
" Set leader key to comma 
let mapleader = "," 
 
" Map space to enter command mode 
nnoremap <space> : 
 
" Center search results after moving with n/N 
nnoremap n nzz 
nnoremap N Nzz 
 
" Yank to the end of the line with Y 
nnoremap Y y$ 
 
" Map F5 to run the current Python script (saves, clears terminal, executes) 
nnoremap <F5> :w<CR>:!clear<CR>:!python %<CR> 
 
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
 
" Map enter to open new line without leaving normal mode
nnoremap <enter> o<esc>k

" ------------------------------------------------------------------------------ 
" GUI SPECIFIC SETTINGS (if using a GUI client for Neovim) 
" ------------------------------------------------------------------------------ 
if has('gui_running') 
    " Set the GUI font 
    " set guifont=MesloLGM\ NFM:h12 
    set guifont=MesloLGM\ Nerd\ Font\ Mono
    " Maximizing the window (the simalt command is Windows-specific and has been removed) 
    " Optionally, open NERDTree on startup: 
    " au VimEnter * NERDTree 
 
    " Enable German spell checking 
    set spell spelllang=de 
 
    " Use a preferred colorscheme for GUI 
    " colorscheme one 
    " set background=dark 
else 
    " For terminal Neovim, use a different colorscheme 
    " colorscheme quiet 
 

    " Set terminal cursor shape settings 
    let &t_SI = "\e[5 q" 
    let &t_EI = "\e[2 q" 
endif 
 
if has('gui_running')
    colorscheme one
else
    colorscheme gruvbox
    set background=dark
endif

" Disable error and visual bells 
set noerrorbells visualbell t_vb= 
if has('autocmd') 
  autocmd GUIEnter * set visualbell t_vb= 
endif 
 
" ------------------------------------------------------------------------------ 
" STATUS LINE CONFIGURATION 
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
 
" ------------------------------------------------------------------------------ 
" LANGUAGE SPECIFIC FUNCTIONS AND MAPPINGS 
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
 
" ------------------------------------------------------------------------------ 
" FOLDING SETTINGS (if desired) 
" ------------------------------------------------------------------------------ 
" vim:foldmethod=marker:foldlevel=0
"
"
"
"
"السلام عليكمتن 
