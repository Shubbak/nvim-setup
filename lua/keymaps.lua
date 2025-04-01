-- Exit insert mode with <M-SPACE> or 'jk' 
-- vim.keymap.set("i", "<M-SPACE>", "<ESC>", { noremap = true })
vim.keymap.set("i", "jk", "<ESC>", { noremap = true })
vim.keymap.set("i", "<M-i>", "<ESC>o\\item<Space>", { noremap = true })

-- Normal mode: Insert \item when pressing <M-i>
vim.keymap.set("n", "<M-i>", "o\\item<Space>", { noremap = true })

-- Map space to enter command mode
vim.keymap.set("n", "<space>", ":", { noremap = true })

-- Center search results after moving with n/N
vim.keymap.set("n", "n", "nzz", { noremap = true })
vim.keymap.set("n", "N", "Nzz", { noremap = true })

-- Yank to the end of the line with Y
vim.keymap.set("n", "Y", "y$", { noremap = true })

-- Map F5 to run the current Python script (saves, clears terminal, executes)
-- vim.keymap.set("n", "<F5>", ":w<CR>:!clear<CR>:!python %<CR>", { noremap = true })
-- if vim.fn.has("wsl") == 1 then
    -- WSL environment (assuming you want to use a WSL-compatible terminal)
    -- vim.keymap.set("n", "<F5>", ":w<CR>:!wsl bash -i -c 'python3 %; echo Press any key to exit...; read -n 1 -s'<CR>", { noremap = true })
-- elseif vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
    -- Windows environment
    -- vim.keymap.set("n", "<F5>", ":w<CR>:!start cmd /c 'python % && pause'<CR>", { noremap = true })
-- else
    -- Linux environment (Ubuntu, etc.)
    -- vim.keymap.set("n", "<F5>", ":w<CR>:!gnome-terminal -- bash -c 'python3 %; exec bash'<CR>", { noremap = true })
-- end

vim.keymap.set("n", "<F5>", ":w<CR>:terminal python3 %<CR>", {noremap = true})

-- file explorer
vim.keymap.set("n", "<leader>d", ":NvimTreeToggle<CR>", { desc = "Toggle Nvim Tree" })

-- Window splitting and navigation
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true })
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true })

-- Resize split windows with arrow keys
vim.keymap.set("n", "<C-Up>", "<C-w>+", { noremap = true })
vim.keymap.set("n", "<C-Down>", "<C-w>-", { noremap = true })
vim.keymap.set("n", "<C-Left>", "<C-w><", { noremap = true })
vim.keymap.set("n", "<C-Right>", "<C-w>>", { noremap = true })

-- Map the Guillemet symbol
-- vim.keymap.set("i", "<<", "«", { noremap = true })
-- vim.keymap.set("i", ">>", "»", { noremap = true })

-- Map enter to open a new line without leaving normal mode
vim.keymap.set("n", "<enter>", "o<esc>k", { noremap = true })

-- Map leader+s to open the LaTeX viewer
vim.keymap.set("n", "<leader>s", ":VimtexView<CR>", { noremap = true })

-- LSP specific keybindings
vim.keymap.set("n", "<leader>ls", ":lua vim.diagnostic.open_float()<CR>", {noremap = true, desc = "Show floating error message"})
vim.keymap.set("n", "<leader>lp", ":lua vim.diagnostic.goto_prev()<CR>", {noremap = true, desc = "Go to previous error"})
vim.keymap.set("n", "<leader>ln", ":lua vim.diagnostic.goto_next()<CR>", {noremap = true, desc = "Go to next error"})

-- Pomodoro specific keybindings
vim.keymap.set("n", "<leader>p8", ":TimerSession eight<CR>", {noremap = true, desc = "Start 8 hours Pomodoro session"})
vim.keymap.set("n", "<leader>p6", ":TimerSession six<CR>", {noremap = true, desc = "Start 6 hours Pomodoro session"})
vim.keymap.set("n", "<leader>ps", ":TimerSession pomodoro<CR>", {noremap = true, desc = "Start single Pomodoro session"})
vim.keymap.set("n", "<leader>ph", ":TimerHide<CR>", {noremap = true, desc = "Hide Pomodoro timer"})
vim.keymap.set("n", "<leader>pp", ":TimerPause<CR>", {noremap = true, desc = "Pause Pomodoro timer"})
vim.keymap.set("n", "<leader>pr", ":TimerResume<CR>", {noremap = true, desc = "Resume Pomodoro timer"})

