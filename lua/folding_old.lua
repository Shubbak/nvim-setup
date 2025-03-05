-- Set default foldmethod to 'syntax' (can be 'indent' or 'manual')
vim.opt.foldmethod = 'syntax'
vim.opt.foldlevel = 1

-- Automatically set folding for specific file types
vim.api.nvim_create_augroup('filetype_folding', { clear = true })

-- Enable folding for Python files based on indentation
vim.api.nvim_create_autocmd('FileType', {
    group = 'filetype_folding',
    pattern = 'python',
    callback = function()
        vim.opt_local.foldmethod = 'indent'
    end
})

-- Enable folding for TeX files based on markers
vim.api.nvim_create_autocmd('FileType', {
    group = 'filetype_folding',
    pattern = 'tex',
    callback = function()
        vim.opt_local.foldmethod = 'marker'
    end
})
