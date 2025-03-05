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
            keys = {"<leader>nt"},
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
                    filters = {
                        custom = {
                            '\\.git$', '\\.jpg$', '\\.mp4$', '\\.ogg$', '\\.iso$', '\\.pdf$', '\\.pyc$', '\\.odt$', 
                            '\\.png$', '\\.gif$', '\\.db$', '\\.aux$', '\\.bbl$', '\\.bcf$', '\\.blg$', '\\.fdb_latexmk$', 
                            '\\.fls$', '\\.glg$', '\\.glo$', '\\.gls$', '\\.ist$', '\\.log$', '\\.out$', '\\.xml$', 
                            '\\.gz$', '\\.latexmain$', '\\.toc$', '\\.xdv$', '\\.tdn$', '\\.tld$', '\\.tlg$', '\\.bdn$', 
                            '\\.bld$', '\\.ldn$', '\\.lld$', '\\.llg$', '\\.ttf$', '\\.zip'
                        }
                    }
                })
            end
        },

        {
            "neovim/nvim-lspconfig",
            ft = {"python", "tex"},
            config = function()
                local lspconfig = require("lspconfig")

                lspconfig.texlab.setup {} 
                lspconfig.pyright.setup {}

                vim.keymap.set("n", "gd", vim.lsp.buf.definition, {desc = "Got to definition"})
                vim.keymap.set("n", "K", vim.lsp.buf.hover, {desc = "Hover documentation"})
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {desc = "Rename symbol"})
            end,
        },

        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            config = function()
                require("nvim-treesitter.configs").setup({
                ensure_installed = {"python", "latex"},
                highlight = {enable = true},
                indent = {enale = true},
                fold = {enable = true},
                })
            end
        },

        {
            "github/copilot.vim",
            ft = {"python"},
            config = function()
		    vim.g.copilot_no_tab_map = true  -- Disable default `<Tab>` mapping
		    vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { expr = true, silent = true })
            end
        },

        {
            "nvim-telescope/telescope.nvim",
            cmd = "Telescope",  -- Lazy-load on command
            ft = "python",  -- Load when opening a Python file
            keys = {  -- Load when pressing these keymaps
                { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
                { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
                { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
                { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find Help" },
            },
            dependencies = { "nvim-lua/plenary.nvim" },
            config = function()
                local telescope = require("telescope")
                telescope.setup({
                    defaults = {
                        layout_strategy = "horizontal",
                        layout_config = { prompt_position = "top" },
                        sorting_strategy = "ascending",
                        winblend = 0,
                    },
                    pickers = {
                        find_files = { hidden = true },
                        live_grep = { only_sort_text = true },
                    },
                })
                -- Keybindings
                local builtin = require("telescope.builtin")
                vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
                vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
                vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
                vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
            end,
        },

        {
            "epwalsh/pomo.nvim",
            version = "*",  -- Recommended, use latest release instead of latest commit
            lazy = true,
            cmd = { "TimerStart", "TimerRepeat", "TimerSession" },
            dependencies = {
                -- Optional, but highly recommended if you want to use the "Default" timer
                "rcarriga/nvim-notify",
            },
            config = function()
                require("pomo").setup({
                    sessions = {
                        pomodoro = {
                            { name = "Work", duration = "25m" },
                            { name = "Short Break", duration = "5m" },
                            { name = "Work", duration = "25m" },
                            { name = "Short Break", duration = "5m" },
                            { name = "Work", duration = "25m" },
                            { name = "Long Break", duration = "15m" }
                        }
                    }
                })
            end
        },

        {
            "lewis6991/gitsigns.nvim",
            config = function()
                require("gitsigns").setup()
            end
        },

        {
            "windwp/nvim-autopairs",
            config = function()
                require("nvim-autopairs").setup({
                    check_ts = false,  -- Use Treesitter for better pairing
                    map_cr = true,  -- Map <CR> to insert newlines inside pairs
                    map_complete = true,  -- Automatically close when typing in insert mode
                })
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
            ft = "tex",
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
            ft = "tex",
            config = function()
                vim.opt.conceallevel = 1
                vim.g.tex_conceal = "abdmg"
                vim.cmd("hi Conceal ctermbg=none")
            end
        },

        {
            "sirver/ultisnips",
            dependencies = {'honza/vim-snippets'},
            config = function()
                vim.g.UltiSnipsExpandTrigger = "<tab>"
                vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
                vim.g.UltiSnipsJumpBackwardTrigger = "<S-Tab>"
                vim.g.UltiSnipsSnippetDirectories = {vim.fn.getcwd() .. "/snippets", "UltiSnips"}
            end
        },

        {
            'ellisonleao/glow.nvim',
            config = function()
                require('glow').setup()
            end,
            ft = 'markdown'
        },

        {
            "epwalsh/obsidian.nvim",
            ft = "markdown",
            dependencies = {
                "nvim-lua/plenary.nvim",        
                "hrsh7th/nvim-cmp",
                'mzlogin/vim-markdown-toc',
                "nvim-telescope/telescope.nvim"
            },
            config = function()
                vim.opt.conceallevel = 1
                require("obsidian").setup({
                    workspaces = {
                        {
                            name = "Books",
                            path = "~/Documents/Obsidian"

                        }
                    },
                    completion = {
                        nvim_cmp = true,
                        min_chars = 2,
                    },
                    -- daily_notes = {
                        -- -- Optional, if you keep daily notes in a separate directory.
                        -- folder = "notes/dailies",
                        -- -- Optional, if you want to change the date format for the ID of daily notes.
                        -- date_format = "%Y-%m-%d",
                        -- -- Optional, if you want to change the date format of the default alias of daily notes.
                        -- alias_format = "%B %-d, %Y",
                        -- -- Optional, default tags to add to each new daily note created.
                        -- default_tags = { "daily-notes" },
                        -- -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
                        -- template = nil
                        -- },
                        mappings = {
                            -- Toggle check-boxes.
                            ["<leader>ch"] = {
                                action = function()
                                    return require("obsidian").util.toggle_checkbox()
                                end,
                                -- opts = { buffer = true },
                            },
                        },
                        templates = {
                            folder = "Vorlagen",
                            date_format = "%Y-%m-%d-%a",
                            time_format = "%H:%M",
                            },
                        })
                    end,
                },

                {
                    "hrsh7th/nvim-cmp",
                    dependencies = {
                        "hrsh7th/cmp-nvim-lsp",
                        "hrsh7th/cmp-buffer",
                        "hrsh7th/cmp-path",
                        "hrsh7th/cmp-cmdline",
                    },
                    config = function()
                        local cmp = require("cmp")  -- Stelle sicher, dass cmp geladen ist
                        cmp.setup({
                            mapping = {
                                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                                -- Weitere Mappings, z.B. für Tab:
                                ["<Tab>"] = cmp.mapping.select_next_item() ,
                                ["<S-Tab>"] = cmp.mapping.select_prev_item() ,
                            },
                            sources = {
                                { name = "nvim_lsp" },
                                { name = "buffer" },
                                { name = "path" },
                                { name = "cmdline" },
                            },
                        })
                    end
                },


                -- Colorschemes
                { "morhetz/gruvbox" },
                { "rakr/vim-one" }
            })
