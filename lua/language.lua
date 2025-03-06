-- Enable spell checking for German
vim.opt.spell = true
vim.opt.spelllang = "de"

-- Function to switch to German (default QWERTZ keyboard)
function GerType()
    vim.opt.keymap = ""
    vim.opt.rightleft = false
    vim.opt.delcombine = false
    vim.api.nvim_set_keymap("i", "jk", "<ESC>", { noremap = true, silent = true })
    vim.opt.spell = true
    vim.opt.spelllang = "de"
    print("Switched to German (QWERTZ)")
end

-- Function to switch to English (default QWERTZ keyboard)
function EngType()
    vim.opt.keymap = ""
    vim.opt.rightleft = false
    vim.opt.delcombine = false
    vim.api.nvim_set_keymap("i", "jk", "<ESC>", { noremap = true, silent = true })
    vim.opt.spell = true
    vim.opt.spelllang = "en"
    print("Switched to English (QWERTZ)")
end


-- Function to switch to Arabic (custom arabic-pc keymap)
function AraType()
    vim.opt.delcombine = true
    vim.opt.keymap = "arabic-pc"
    vim.opt.rightleft = true
    vim.api.nvim_del_keymap("i", "jk")  -- Unmap jk in insert mode
    vim.opt.guifont = "Kawkab Mono"
    -- vim.opt.spell = true
    -- vim.opt.spelllang = "ar"
    vim.opt.spell = false
    print("Switched to Arabic (PC keymap)")
end

-- Function to switch to Arabic transcript keymap
function TranscriptType()
    vim.opt.keymap = "arabic-transcript"
    vim.opt.rightleft = false
    vim.opt.delcombine = false
    vim.api.nvim_del_keymap("i", "jk")  -- Unmap jk in insert mode
    vim.opt.spell = false
    print("Switched to Arabic Transcript")
end

-- Function to switch font to Meslo Nerd Font Mono and enable German spellcheck
function FontMesloGerman()
    vim.opt.guifont = "FiraCode Nerd Font Mono:h12"
    vim.opt.spell = true
    vim.opt.spelllang = "de"
    print("Switched to FiraCode + German Spellcheck")
end

function SpellBili()
    vim.opt.spell = true
    vim.opt.spelllang = "de,en"
    print("Spellcheck for both English and German.")
end

-- Keybindings
vim.api.nvim_set_keymap("n", "<Leader>e", ":lua EngType()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>g", ":lua GerType()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>a", ":lua AraType()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>t", ":lua TranscriptType()<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<Leader>f", ":lua FontMesloGerman()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>b", ":lua SpellBili()<CR>", { noremap = true, silent = true })
