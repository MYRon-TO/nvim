vim.g.copilot_no_tab_map = true
vim.g.copilot_filetypes = {
  ["*"] = true,
}

return {
  {
    "github/copilot.vim",
    lazy = false,
    event = "InsertEnter",
    config = function()
      vim.keymap.set('i', '<C-Y>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false
      })
      vim.keymap.set('i', '<C-/>', '<Plug>(copilot-next)')
      vim.keymap.set('i', '<C-\\>', '<Plug>(copilot-previous)')
    end,
  },
}
