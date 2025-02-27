local function git_branch()
    local gitsigns = vim.b.gitsigns_head
    return gitsigns and " " .. gitsigns or ""
end
 
local function git_diff()
    local added   = vim.b.gitsigns_status_dict and vim.b.gitsigns_status_dict.added or 0
    local changed = vim.b.gitsigns_status_dict and vim.b.gitsigns_status_dict.changed or 0
    local removed = vim.b.gitsigns_status_dict and vim.b.gitsigns_status_dict.removed or 0

    return string.format("+%d ~%d -%d", added, changed, removed)
end

vim.opt.statusline = table.concat({
    "%f",        -- File path
    " %Y",       -- File type
    "%=",        -- Separator between left and right
    git_branch(),-- git branch using gitsigns.
    git_diff(),  -- git diff using gitsigns
    "%=",        -- Separator between left and right
    "ascii: %b", -- ASCII code of character under cursor
    " hex: 0x%B",-- Hex code of character under cursor
    " %p%%",     -- Percentage through file
    " %04l",     -- Zero-padded line number
    ":",         -- Separator for column
    "%-2c",      -- Column number (padded)
    " %m"        -- Modified flag
}, "")

vim.opt.laststatus = 2
