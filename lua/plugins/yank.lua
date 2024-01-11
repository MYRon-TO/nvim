return {
  {
    "gbprod/yanky.nvim",
    dependencies = {
      -- "kkharji/sqlite.lua",
      'nvim-telescope/telescope.nvim',
    },
    lazy = true,
    config = function()
      local mapping = require("yanky.telescope.mapping")
      local utils = require("yanky.utils")
      require("yanky").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        ring = {
          history_length = 100,
          storage = "shada",
          sync_with_numbered_registers = true,
          cancel_event = "update",
        },
        picker = {
          select = {
            action = nil, -- nil to use default put action
          },
          telescope = {
            use_default_mappings = false, -- if default mappings should be used
            mappings = {
              i = {
                ["<cr>"] = mapping.put("p"),
                ["<c-cr>"] = mapping.put("P"),
                ["<c-x>"] = mapping.delete(),
                ["<c-r>"] = mapping.set_register(utils.get_default_register()),
              },
            }
          },
        },
        system_clipboard = {
          sync_with_ring = true,
        },
        highlight = {
          on_put = true,
          on_yank = true,
          timer = 500,
        },
        preserve_cursor_position = {
          enabled = true,
        },
      })
      require("telescope").load_extension("yank_history")
    end,
    keys = {
      { "p",         "<Plug>(YankyPutAfter)",       mode = { "n", "x" } },
      { "P",         "<Plug>(YankyPutBefore)",      mode = { "n", "x" } },
      { "gp",        "<Plug>(YankyGPutAfter)",      mode = { "n", "x" } },
      { "gP",        "<Plug>(YankyGPutBefore)",     mode = { "n", "x" } },
      { "<leader>y", ":Telescope yank_history<CR>", mode = { "n", "x" } },
    }
  },
}
