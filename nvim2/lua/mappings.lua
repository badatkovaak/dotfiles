require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

local del = vim.keymap.del

map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")

del("n", "<leader>h")
del("n", "<leader>v")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
