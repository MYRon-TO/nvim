return {
  {
    'gorbit99/codewindow.nvim',
    lazy = true,
    keys = {
      "<leader>mm",
    },
    config = function()
      local codewindow = require('codewindow')
      codewindow.setup()
      codewindow.apply_default_keybinds()
    end,
  },
}
