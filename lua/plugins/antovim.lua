return {
  'theniceboy/antovim',
  lazy = true,
  keys = {
    { "<leader>s", ":Anto<CR>", "n" },
  },
  config = function()
    vim.g.custom_antovim_definitions = {
      { 'yes', 'no' },
      { '.', '。' },
    }
  end,
}
