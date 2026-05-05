return {
-- cursor flashes when you move from one window to the next
--
{
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {},
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
},

{
    "chriswritescode-dev/consolelog.nvim",
    lazy= false,
    config = function()
      require("consolelog").setup()
    end,
},
{
  "zbirenbaum/neodim",
  event = "LspAttach",
  config = function()
    require("neodim").setup({
      alpha = 0.5, -- Adjust transparency (0 to 1)
      blend_color = "#000000", -- Your background color
    })
  end,
},

-- task manager
{
  "Hashino/doing.nvim",
  lazy = false,
  opts = {},
  keys = {
    { "<leader>da", function() require("doing").add() end, desc = "[D]oing: [A]dd", },
    { "<leader>dn", function() require("doing").done() end, desc = "[D]oing: Do[n]e", },
    { "<leader>de", function() require("doing").edit() end, desc = "[D]oing: [E]dit", },
  },
},


-- floating window hover definitions
{
    "Cpoing/microscope.nvim",
    cmd = "MicroscopePeek",
    keys = {
        { "<leader>r", ":MicroscopePeek<CR>", desc = "Peek definition" },
    },
    config = function()
        require("microscope")
    end,
},
{
    'smoka7/hop.nvim',
    version = "*",
    opts = {
        keys = 'etovxqpdygfblzhckisuran'
    }
},
{
  "typed-rocks/ts-worksheet-neovim",
  lazy = false, -- Force load on startup
  ft = { "typescript", "javascript", "typescriptreact" }, -- Load only for these files
  opts = {
    severity = vim.diagnostic.severity.WARN,
  },
  config = function(_, opts)
    require("tsw").setup(opts)
  end
},
{
	"dmmulroy/tsc.nvim",
	config = function()
		require("tsc").setup({
            -- Your config here
		})
	end,
},



{
  -- The plugin repository on GitHub
  "sitiom/nvim-numbertoggle",
  -- The 'event' tells lazy.nvim when to load the plugin.
  -- Loading it on 'VeryLazy' ensures it is ready for basic file editing.
  event = "VeryLazy",
  -- The 'config' function runs when the plugin is loaded.
  -- nvim-numbertoggle simplifies things by not needing a setup() call,
  -- but you must ensure the core options are set for it to toggle between them.
  config = function()
    -- Set the core number options. nvim-numbertoggle will handle the toggling.
    vim.opt.number = true      -- Enable absolute line numbers
    vim.opt.relativenumber = true -- Enable relative line numbers (this is the one that gets toggled off/on)

    -- OPTIONAL: Add a keymap to manually toggle the feature on/off if desired
    vim.keymap.set("n", "<leader>tn", function()
      vim.g.numbertoggle_enabled = not vim.g.numbertoggle_enabled
      -- Re-run the autocmd to apply the change immediately
      vim.cmd("autocmd User NumberToggle")
    end, { desc = "Toggle NumberToggle Plugin" })
  end,
},
  -- Show the closing braces context in code

{
  "folke/trouble.nvim",
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  cmd = "Trouble",
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>cs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>cl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  },
},


---if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize None-ls sources

---@type LazySpec
{
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    -- opts variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics

    -- Only insert new sources, do not replace the existing ones
    -- (If you wish to replace, use `opts.sources = {}` instead of the `list_insert_unique` function)
    opts.sources = require("astrocore").list_insert_unique(opts.sources, {
      -- Set a formatter
      -- null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.pylint.with({
        diagnostics_postprocess = function(diagnostic)
        diagnostic.code = diagnostic.message_id
      end,
      }),
    --null_ls.builtins.formatting.isort,
    --null_ls.builtins.formatting.black,
      --null_ls.builtins.formatting.prettier,
    })
  end,
},


-- Hardtime
  --
{
   "m4xshen/hardtime.nvim",
   lazy = false,
   dependencies = { "MunifTanjim/nui.nvim" },
   opts = {},
},
{
    "mason-org/mason.nvim",
opts = {
      ensure_installed = {
        "black",      -- Python formatter
        "isort",      -- Python import sorter
        "stylua",     -- Lua formatter
        "prettier",   -- HTML/JS/CSS formatter
      },
},
  },
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
    version = "^4.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    -- Optional: See `:h nvim-surround.configuration` and `:h nvim-surround.setup` for details
    -- config = function()
    --     require("nvim-surround").setup({
    --         -- Put your configuration here
    --     })
    -- end
},

-- ~/.config/nvim/lua/custom/plugins.lua (or a similar config file)

  -- This is how you override the 'neo-tree.nvim' plugin options


--  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

-- In user/plugins/codi.lua
-- {
--   "metakirby5/codi.vim",
--   cmd = { "Codi", "CodiNew" },
--   keys = {
--     { "<leader>rc", "<cmd>Codi!!<cr>", desc = "Toggle Codi" },
--   },
--   config = function()
--     vim.g.codi_autostart = false
--   end,
-- },
 {
    "michaelb/sniprun",
    lazy= false,
    branch = "master",

    build = "sh install.sh",
    -- do 'sh install.sh 1' if you want to force compile locally
    -- (instead of fetching a binary from the github release). Requires Rust >= 1.65

    config = function()
      require("sniprun").setup({
      -- your options
      })
    end,
  },
{
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require('lint').linters_by_ft = {
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      python = { 'pylint' },
    }
  end,
}
}

