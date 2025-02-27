-- Enable syntax highlighting
vim.cmd("syntax on")


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

-- Enable modeline which means that a comment starting with vim: will override settings per file
vim.o.modeline = true

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



-- Detect if Neovim is running in a GUI
if vim.g.neovide then
    -- Set the GUI font
    vim.opt.guifont = "MesloLGM Nerd Font Mono"
else
    -- Set terminal cursor shape settings
    -- vim.opt.t_SI = "\27[5 q"  -- Insert mode cursor
    -- vim.opt.t_EI = "\27[2 q"  -- Normal mode cursor
end

-- Set colorscheme and background
vim.cmd("colorscheme one")
vim.opt.background = "dark"

-- Disable error and visual bells
vim.opt.errorbells = false
vim.opt.visualbell = false

-- Function to optimize performance for Neovide
local function performance()
    -- Reduce cursor animation time
    vim.g.neovide_cursor_animation_length = 0

    -- Disable cursor trail
    vim.g.neovide_cursor_trail_length = 0

    -- Disable floating blur (if enabled)
    vim.g.neovide_floating_blur = 0

    -- Lower refresh rate (default is 60)
    vim.g.neovide_refresh_rate = 30

    -- Disable idle animation updates
    vim.g.neovide_no_idle = true
end

-- Run performance optimizations if in Neovide
if vim.g.neovide then
    performance()
end
