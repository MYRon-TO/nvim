return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>F",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  -- Everything in opts will be passed to setup()
  opts = {
    -- Define your formatters
    formatters_by_ft = {

      -- * config/data
      json = { "biome" },

      -- * web
      -- ** xml
      xml = { "xmlformatter" },
      html = { "prettierd" },
      svelte = { "prettierd" },
      -- ** css
      css = { "prettierd" },
      scss = { "prettierd" },
      -- ** js/ts
      javascript = { { "biome", "prettierd", "prettier" } }, -- prettierd or prettier
      typescript = { { "biome", "prettierd", "prettier" } }, -- prettierd or prettier

      -- * markup
      latex = { "latexindent" },
      tex = { "latexindent" },
      markdown = { "prettierd" },
      typst = { "typstfmt" },

      -- * code

      lua = { "stylua" },
      python = { "isort", "black" }, -- isort first, then black
      shell = { "shfmt" },

      rust = { "rustfmt" },

    },
    -- Set up format-on-save
    -- format_on_save = { timeout_ms = 500, lsp_fallback = true },

    -- Customize formatters
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2" },
      },
    },
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
