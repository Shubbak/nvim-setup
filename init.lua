-------------------------------------------------------------
--                
--          ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
--          ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
--          ██║   ██║██║██╔████╔██║██████╔╝██║     
--          ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║     
--           ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
--            ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
--               
-------------------------------------------------------------

vim.g.mapleader = ","

require("plugins")   -- Load plugins
require("settings")  -- Load options
require("keymaps")   -- Load keybindings
require("language")  -- Load language-settings
-- require("status")    -- Load statusline settings; not needed with statusline plugin
require("folding")   -- Load folding settings
