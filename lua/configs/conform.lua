local options = {
  formatters_by_ft = {
    lua = { "stylua" },
      python = { "isort", "black" },
    -- css = { "prettier" },
    -- html = { "prettier" },
  },

   format_on_save = {
  --   -- These options will be passed to conform.format()
      formatters = {
        -- Python
        black = {
            prepend_args = {
                "--fast",
                "--line-length",
                "80",
            },
        },
        isort = {
            prepend_args = {
                "--profile",
                "black",
            },
        },
    },
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  },
}

return options
