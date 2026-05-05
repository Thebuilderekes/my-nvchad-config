require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Jump to any word on the screen
map("n", "<leader>hw", "<cmd>HopWord<CR>", { desc = "Hop Word" })

-- Jump to any character (like a super-powered 'f')
map("n", "<leader>hc", "<cmd>HopChar1<CR>", { desc = "Hop Character" })

-- Jump to any line
map("n", "<leader>hl", "<cmd>HopLine<CR>", { desc = "Hop Line" })
