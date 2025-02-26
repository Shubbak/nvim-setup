-- Enable syntax highlighting
vim.cmd("syntax on")

-- Enable modeline which means that a comment starting with vim: will override settings per file
vim.o.modeline = true

-- Line numbering: absolute and relative toggle
vim.wo.number = true
vim.wo.relativenumber = true

-- Autocommand for toggling relative line numbers
if vim.fn.has('autocmd') == 1 then
    vim.api.nvim_create_augroup('numbertoggle', { clear = true })
    vim.api.nvim_create_autocmd('InsertEnter', {
        group = 'numbertoggle',
        pattern = '*',
        command = 'set norelativenumber',
    })
    vim.api.nvim_create_autocmd('InsertLeave', {
        group = 'numbertoggle',
        pattern = '*',
        command = 'set relativenumber',
    })
else
    vim.wo.relativenumber = true
end

-- Disable swap files
vim.o.swapfile = false

-- Search settings
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.showcmd = true
vim.o.showmode = true
vim.o.showmatch = true

-- Disable persistent undo and backup files
vim.o.undofile = false
vim.o.backup = false

-- Scrolling and wrapping
vim.o.scrolloff = 7
vim.o.wrap = false

-- File type detection and plugins
vim.o.compatible = false
vim.cmd("filetype on")
vim.cmd("filetype plugin on")
vim.cmd("filetype indent on")

-- Highlight the current line
vim.wo.cursorline = true

-- Indentation settings
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.expandtab = true

-- Increase command history size
vim.o.history = 1000
