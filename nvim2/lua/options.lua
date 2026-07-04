require "nvchad.options"

-- add yours here!

local cmd = vim.cmd
local opt = vim.opt

cmd "set whichwrap+=h,l,<,>,[,]"
cmd "set backspace=indent,eol,start"
cmd "set tabstop=4"
cmd "set shiftwidth=4"
cmd "set expandtab"
cmd "set softtabstop=4"
vim.o.relativenumber = true
vim.diagnostic.config { signs = false }
opt.clipboard = nil

