vim.g.copilot_no_tab_map = true

return {
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.keymap.set('i', '<C-Y>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = true
      })
      vim.keymap.set('i', '<C-/>', '<Plug>(copilot-next)')
      vim.keymap.set('i', '<C-\\>', '<Plug>(copilot-previous)')

      -- vim.g.copilot_enabled = true
      -- -- vim.g.copilot_no_tab_map = true
      -- -- vim.g.copilot_assume_mapped = true
      -- vim.cmd([[
      --           let g:copilot_no_tab_map = v:true
      --           " let g:copilot_assume_mapped = v:true
      --           imap <silent><script><expr> <C-Y> copilot#Accept("")
      --           " imap <silent><script><expr> <C-B> <Plug>(copilot-suggest)
      --       ]])
      -- vim.api.nvim_set_keymap("i", "<C-Y>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
      vim.g.copilot_filetypes = {
        ["*"] = true,
      }
    end,
  },

  -- Why I can not use ESC in this plugin???
  -- {
  --   "zbirenbaum/copilot.lua",
  --   lazy = true,
  --   event = "InsertEnter",
  --   config = function()
  --     require('copilot').setup({
  --       panel = {
  --         enabled = false,
  --         auto_refresh = false,
  --         keymap = {
  --           jump_prev = "[[",
  --           jump_next = "]]",
  --           accept = "<CR>",
  --           refresh = "gr",
  --           open = "<M-CR>"
  --         },
  --         layout = {
  --           position = "bottom", -- | top | left | right
  --           ratio = 0.4
  --         },
  --       },
  --       suggestion = {
  --         enabled = true,
  --         auto_trigger = true,
  --         debounce = 75,
  --         keymap = {
  --           accept = "<C-Y>",
  --           accept_word = false,
  --           accept_line = false,
  --           next = "<C-]>",
  --           prev = "<C-[>",
  --           dismiss = "<C-B>",
  --         },
  --       },
  --       filetypes = {
  --         -- yaml = false,
  --         -- markdown = false,
  --         help = false,
  --         -- gitcommit = false,
  --         -- gitrebase = false,
  --         -- hgcommit = false,
  --         -- svn = false,
  --         -- cvs = false,
  --         -- ["."] = false,
  --         ["*"] = true,
  --       },
  --       copilot_node_command = 'node', -- Node.js version must be > 16.x
  --       server_opts_overrides = {},
  --     })
  --   end
  -- },
}
