return {
  -- {
  --     "aurum77/live-server.nvim",
  --     build = function()
  --         require "live_server.util".install()
  --     end,
  --     lazy = true,
  --     ft = { "html", "markdown" },
  --     cmd = { "LiveServer", "LiveServerStart", "LiveServerStop" },
  --     config = function()
  --         local status_ok, live_server = pcall(require, "live_server")
  --         if not status_ok then
  --             return
  --         end

  --         live_server.setup({
  --             port = 8080,
  --             browser_command = "", -- Empty string starts up with default browser
  --             quiet = false,
  --             no_css_inject = true, -- Disables css injection if true, might be useful when testing out tailwindcss
  --             install_path = vim.fn.stdpath "config" .. "/live-server/",
  --         })
  --     end,
  -- },
  {
    -- make sure installled pnpm and live-server
    'barrett-ruth/live-server.nvim',
    lazy = true,
    build = 'pnpm add -g live-server',
    cmd = { 'LiveServerStart', 'LiveServerStop' },
    ft = { 'html' },
    config = true
  },
  {
    'NvChad/nvim-colorizer.lua',
    -- event = "VeryLazy",
    config = function()
      require("colorizer").setup {
        filetypes = { "*" },
        user_default_options = {
          RGB = true,      -- #RGB hex codes
          RRGGBB = true,   -- #RRGGBB hex codes
          names = false,   -- "Name" codes like Blue or blue
          RRGGBBAA = true, -- #RRGGBBAA hex codes
          AARRGGBB = true, -- 0xAARRGGBB hex codes
          rgb_fn = true,   -- CSS rgb() and rgba() functions
          hsl_fn = true,   -- CSS hsl() and hsla() functions
          css = true,      -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn = true,   -- Enable all CSS *functions*: rgb_fn, hsl_fn
          -- Available modes for `mode`: foreground, background,  virtualtext
          -- mode = "background", -- Set the display mode.
          mode = "virtualtext", -- Set the display mode.
          -- Available methods are false / true / "normal" / "lsp" / "both"
          -- True is same as normal
          tailwind = true,                                 -- Enable tailwind colors
          -- parsers can contain values used in |user_default_options|
          sass = { enable = false, parsers = { "css" }, }, -- Enable sass colors
          virtualtext = "■",
          -- update color values even if buffer is not focused
          -- example use: cmp_menu, cmp_docs
          always_update = false
        },
        -- all the sub-options of filetypes apply to buftypes
        buftypes = {},
      }
    end,
  },
}
