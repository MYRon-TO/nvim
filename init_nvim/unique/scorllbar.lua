return {
  "petertriho/nvim-scrollbar",
  lazy = false,
  event = "UIEnter",
  config = function()
    require('gitsigns').setup()
    require("scrollbar.handlers.gitsigns").setup()
    require("scrollbar").setup({
      -- local colors = require("tokyonight.colors").setup()
      -- handle = {
      --   color = colors.bg_highlight,
      -- },
      -- marks = {
      --   Search = { color = colors.orange },
      --   Error = { color = colors.error },
      --   Warn = { color = colors.warning },
      --   Info = { color = colors.info },
      --   Hint = { color = colors.hint },
      --   Misc = { color = colors.purple },
      -- }
    })
  end,
}
