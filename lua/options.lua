require "nvchad.options"

-- add yours here!
-- Inside ~/.config/nvim/lua/options.lua
local opt = vim.opt

-- Common NvChad options
opt.laststatus = 3 -- global statusline
opt.showmode = false

opt.clipboard = "unnamedplus"
opt.cursorline = true

-- Your existingrelative number settings
opt.relativenumber = true
opt.number = true
-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
