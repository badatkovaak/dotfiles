vim.cmd("set whichwrap+=h,l,<,>,[,]")
vim.cmd("set backspace=indent,eol,start")
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set expandtab")
vim.cmd("set softtabstop=4")
vim.o.relativenumber = true
vim.diagnostic.config({ signs = false })
-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
