--require("vim._core.ui2").enable({})




vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "
-- In your custom mappings file (e.g., lua/custom/mappings.lua)
-- Use <leader>r (Space + r) to quickly reload the main config file
-- Enable Tree-sitter motions (they should be default, but sometimes get lost)
-- vim.keymap.set('n', ']m', function()
--   require('nvim-treesitter.incremental_selection').init_selection()
-- end)
--
-- set textwidth=80 tto all markdown files
-- Define an autocommand group to hold your filetype-specific settings
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("MarkdownConfig", { clear = true }),
  -- Only execute the commands when the filetype is 'markdown'
  pattern = "markdown",
  callback = function()
    -- Set the max line length for wrapping and formatting (gq)
    vim.opt_local.textwidth = 80

    -- Set 'wrap' to true so lines exceeding 80 characters display on multiple screen lines
    vim.opt_local.wrap = true

    -- Ensure formatting (gq) uses textwidth and not just 'wrap'
    -- 't': auto-wrap using textwidth
    -- 'c': auto-wrap comments (optional, but harmless for Markdown)
    vim.opt_local.formatoptions = "tcqn"

    -- Set 'conceallevel' to 2 for better markdown rendering (hides common syntax like **)
    vim.opt_local.conceallevel = 2
  end,
})



-- Get rid of whitespaces
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*', -- Apply to all file types
  callback = function()
    -- Save cursor position to restore later
    local curpos = vim.api.nvim_win_get_cursor(0)
    -- Search and replace trailing whitespaces
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, curpos)
  end,
})

-- Auto-set filetype for Django templates to enable Tree-sitter injections
-- Assuming your Django templates use the .html extension
vim.filetype.add({
  extension = {
    html = function(path)
      -- Simple heuristic: check if the file path contains "templates" or a common Django folder structure
      if path:match("templates[/\\]") or path:match("[/\\]django[/\\]") or path:match("_(base|list|detail|form|include)%.html$") then
        return "htmldjango"
      end
      -- Fallback to default html
      return "html"
    end,
  },
})
-- highlight yank
vim.api.nvim_create_augroup("HighlightYank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  group = "HighlightYank",
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})
-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

local uv = vim.uv or vim.loop
if not uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
--dofile(vim.g.base46_cache .. "defaults")
--dofile(vim.g.base46_cache .. "statusline")

-- Replace the load theme section with this safer version:
local base46_path = vim.g.base46_cache .. "defaults"
if vim.fn.filereadable(base46_path) == 1 then
  dofile(base46_path)
  dofile(vim.g.base46_cache .. "statusline")
end

require "options"
require "autocmds"
vim.schedule(function()
  require "mappings"
end)
-- Place this in your custom config file (e.g., custom/init.lua)

-- ~/.config/nvim/lua/custom/init.lua

local function format_markdown_80()
  -- Set textwidth locally for the current buffer to 80
  vim.opt_local.textwidth = 80

  -- Reformat the entire buffer using the set textwidth
  -- vim.cmd executes a Vim/Neovim command string
  -- The command gggqG means: Go to top (gg), format (gq) to bottom (G)
  vim.cmd("normal! gggqG")
end

-- 2. Create the custom user command (Corrected API usage)
-- Use nvim_buf_create_user_command and pass '0' for the current buffer.
vim.api.nvim_buf_create_user_command(
  0,                  -- The current buffer (0)
  "Format80",         -- Command name
  format_markdown_80, -- The Lua function to execute
  {
    desc = "Set textwidth to 80 and reformat the entire file.",
    -- The 'buffer' key is now REMOVED from the attributes table
    -- because the function itself (nvim_buf_create_user_command) makes it buffer-local.
  }
)

-- Optional: You should also use the buffer-local keymap function
vim.keymap.set("n", "<leader>fm", ":Format80<CR>", {
  desc = "Format file to 80 characters (using :Format80)",
  -- The keymap function is the correct place to use buffer = true
  buffer = true,
})


-- Automatically set filetype for files inside a common 'templates' directory
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "**/templates/**/*.html",
  callback = function()
    -- Ensure the filetype is set correctly for Django template support
    vim.bo.filetype = "htmldjango"
  end,
})

-- Neovim options for relative line numbers and spellcheck

-- 1. Relative Line Numbers (Hybrid style)
-- If vim.opt.number is already set by NvChad, this creates the hybrid style.
--
vim.opt.relativenumber = true

-- 2. Spellcheck always on for English
vim.opt.spell = true
vim.opt.spelllang = "en_us"

--require('nvim-biscuits').setup({


 --python = {
   --   disabled = false
   -- }
--})

local map = vim.keymap.set
-- But map 'L' to do what ; used to do
vim.keymap.set("n", "L", ";", { desc = "Repeat jump forward" })

-- Jump to any word on the screen
map("n", "<leader>hw", "<cmd>HopWord<CR>", { desc = "Hop Word" })

-- Jump to any character (like a super-powered 'f')
map("n", "<leader>hc", "<cmd>HopChar1<CR>", { desc = "Hop Character" })

-- Jump to any line
map("n", "<leader>hl", "<cmd>HopLine<CR>", { desc = "Hop Line" })

vim.keymap.set('n', 'gD', '<CMD>Glance definitions<CR>')
vim.keymap.set('n', 'gR', '<CMD>Glance references<CR>')
vim.keymap.set('n', 'gY', '<CMD>Glance type_definitions<CR>')
vim.keymap.set('n', 'gM', '<CMD>Glance implementations<CR>')

-- disable Hardtime on start
vim.api.nvim_create_autocmd({"BufReadPre"}, {
  pattern = {"*.md", "*.markdown"}, -- Disable Hardtime for Markdown files
  command = "silent! :Hardtime disable",
  group = vim.api.nvim_create_augroup("HardtimeDisable", {clear = true}),
})
-- You can add more patterns or file types as needed
-- vim.api.nvim_create_autocmd({"BufReadPre"}, {pattern = {"/path/to/specific/file.txt"}, command = "silent! :Hardtime disable", group = "HardtimeDisable"})

-- Set the title to the current folder name on startup
vim.opt.title = true
vim.api.nvim_create_autocmd({"VimEnter", "DirChanged"}, {
  callback = function()
    -- Get the last part of the current path (the folder name)
    local folder_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    vim.opt.titlestring = folder_name
  end,
})

-- Optional: Reset the title when leaving Neovim
vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    vim.opt.titlestring = "" -- Reverts to default shell title
  end,
})

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false })
  end,
})



vim.cmd("iabbrev cons console.log();")
vim.keymap.set('n', '<leader>hd', '<cmd>Hardtime disable<cr>', { desc = 'Disable Hardtime' })

vim.keymap.set('n', '<leader>aa', 'ggVG')
