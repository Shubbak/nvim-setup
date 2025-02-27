-- Set up plugin directory based on OS
local is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
-- Function to get Unicode code of character under cursor

-- local function get_unicode()
    -- local char = vim.fn.getcharstr()
    -- return "Hex: 0x" .. string.format("%X", vim.fn.char2nr(char)) -- Get Hex of the character
-- end
-- Function to get Hex code of character under cursor
local function get_hex()
    -- Get the character under the cursor (without blocking)
    local char = vim.fn.matchstr(vim.fn.getline('.'), '\\%'..vim.fn.col('.')..'c')
    return "Hex: 0x" .. string.format("%X", vim.fn.char2nr(char)) -- Get Hex of the character
end

-- Ensure lazy.nvim is installed
local lazypath 
if is_windows then
    lazypath = vim.fn.stdpath("data") .. "\\lazy\\lazy.nvim"
else
    lazypath = vim.fn.stdpath("data") .. "lazy/lazy.nvim"
end
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin setup with lazy.nvim
require("lazy").setup({
    -- NERDTree alternative: nvim-tree
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup({
                view = {
                    width = 30,                 -- Set the width of the tree
                    side = 'left',              -- Position the tree on the left
                    -- auto_resize = true,         -- Automatically resize when window size changes
                },
                renderer = {
                    icons = {
                        webdev_colors = true,   -- Enable webdev icons (if you want)
                    }
                },
            })
            filters = {
            custom = {
              '\\.git$', '\\.jpg$', '\\.mp4$', '\\.ogg$', '\\.iso$', '\\.pdf$', '\\.pyc$', '\\.odt$', 
              '\\.png$', '\\.gif$', '\\.db$', '\\.aux$', '\\.bbl$', '\\.bcf$', '\\.blg$', '\\.fdb_latexmk$', 
              '\\.fls$', '\\.glg$', '\\.glo$', '\\.gls$', '\\.ist$', '\\.log$', '\\.out$', '\\.xml$', 
              '\\.gz$', '\\.latexmain$', '\\.toc$', '\\.xdv$', '\\.tdn$', '\\.tld$', '\\.tlg$', '\\.bdn$', 
              '\\.bld$', '\\.ldn$', '\\.lld$', '\\.llg$', '\\.ttf$', '\\.zip'
            }
          }
        end
    },
 

    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end
    },
    
    -- Statusline
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "auto",
                    section_separators = { left = "", right = "" },
                    component_separators = { left = "", right = "" },
                    disabled_filetypes = { "NvimTree", "packer" },
                },
                sections = {
                    lualine_b = { "branch", "diff" },
                    lualine_c = { "filename" },
                    lualine_x = {get_hex, "encoding", "fileformat", "filetype" },
                    -- lualine_x = {"encoding", "fileformat", "filetype" },
                    lualine_y = { "progress", "location" },
                    lualine_z = { "%m" },
                },
            })
        end
    },
   
    -- LaTeX support via vimtex
    {
        "lervag/vimtex",
        init = function()
            -- Set LaTeX flavor
            vim.g.tex_flavor = "latex"
            
            -- For Windows, use SumatraPDF, otherwise use Zathura
            if is_windows then
                vim.g.vimtex_view_general_viewer = "SumatraPDF"
                vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
            else
                vim.g.vimtex_view_method = "zathura"
            end
            
            -- General vimtex settings
            vim.g.vimtex_quickfix_mode = 0
            vim.g.vimtex_complete_close_braces = 1
            vim.g.vimtex_compiler_method = "latexmk"
        end
    },

    -- Conceal support for LaTeX
    {
        "KeitaNakamura/tex-conceal.vim",
        config = function()
            vim.opt.conceallevel = 1
            vim.g.tex_conceal = "abdmg"
            vim.cmd("hi Conceal ctermbg=none")
        end
    },

    -- Snippets (UltiSnips alternative: LuaSnip)
    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end
    },

    -- Git integration with vim-fugitive
    { "tpope/vim-fugitive" },

    -- Colorschemes
    { "morhetz/gruvbox" },
    { "rakr/vim-one" }
})
