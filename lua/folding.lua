vim.o.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"
vim.o.foldenable = true  -- Start with folds open
vim.o.foldlevel = 5      -- Expand all folds by default
vim.o.foldlevelstart = 5 -- Keeps folds open when opening a file
