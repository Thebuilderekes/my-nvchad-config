return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts ={
      require "configs.conform",
      formatters_by_ft = {
      python = { "black", "isort" },
      htmldjango = { "djlint" },
      html = { "djlint" },
  },
   formatters = {
      djlint = {
        timeout_ms = 20000000,  -- 20 seconds
        -- optional extra args:
        -- args = { "--profile=django", "--quiet" },
      },
    },
  }
  },
  {
 'johnfrankmorgan/whitespace.nvim',
    -- Set event to 'VeryLazy' to load the plugin immediately after the
    -- configuration is processed, but only after Neovim has finished
    -- starting up.
    event = 'VeryLazy',

    -- The 'config' function runs the setup logic after the plugin is loaded.
    config = function()
        -- Setup the plugin with custom configuration options
        require('whitespace-nvim').setup({
            -- highlight: Which highlight group to use for trailing whitespace
            highlight = 'DiffDelete',

            -- ignored_filetypes: Filetypes to completely ignore
            ignored_filetypes = { 'TelescopePrompt', 'Trouble', 'help', 'dashboard', 'NvimTree', 'packer' },

            -- ignore_terminal: Ignore terminal buffers
            ignore_terminal = true,

            -- return_cursor: Return cursor to previous position after trimming
            return_cursor = true,
        })

        -- Define a keybinding to trigger the trim function.
        -- We use '<Leader>t' as requested.
        vim.keymap.set('n', '<Leader>t', require('whitespace-nvim').trim, {
            desc = 'Whitespace: Trim Trailing Whitespace',
            silent = true
        })
    end,
  },
{
  "kylechui/nvim-surround",
  event = "VeryLazy",
  opts = {
    -- This enables the legacy keybindings like ysiw
    keymaps = {
      insert = "<C-g>s",
      insert_line = "<C-g>S",
      normal = "ys",
      normal_cur = "yss",
      normal_line = "yS",
      normal_cur_line = "ySS",
      visual = "S",
      visual_line = "gS",
      delete = "ds",
      change = "cs",
    },
  },
},


-- ~/.config/nvim/lua/custom/plugins.lua (or a similar config file)

  -- This is how you override the 'neo-tree.nvim' plugin options
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      -- ... other neo-tree options
      filesystem = {
        git_ignore_files = false, -- Neotree's option to ignore files in .gitignore
      },
    },
  },


{
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
"html",
    "cssls",
        "black",
        "debugpy",
        "mypy",
        "ruff-lsp",
        "pyright",
      },
    }

  },
-- {
--   "stevearc/conform.nvim",
--   opts = {
--     formatters_by_ft = {
--       python = { "black", "isort" },
--     },
--   },
-- },
  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

-- In user/plugins/codi.lua
{
  "metakirby5/codi.vim",
  cmd = { "Codi", "CodiNew" },
  keys = {
    { "<leader>rc", "<cmd>Codi!!<cr>", desc = "Toggle Codi" },
  },
  config = function()
    vim.g.codi_autostart = false
  end,
},

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
