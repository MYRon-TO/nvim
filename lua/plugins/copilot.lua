-- -- Disable default tab mapping for Copilot
-- vim.g.copilot_no_tab_map = true

-- -- Enable Copilot for all file types
-- vim.g.copilot_filetypes = {
--   ["*"] = true,
-- }

return {
  -- {
  --   "github/copilot.vim",
  --   lazy = false,
  --   event = "InsertEnter",
  --   config = function()
  --     vim.keymap.set('i', '<C-Y>', 'copilot#Accept("\\<CR>")', {
  --       expr = true,
  --       replace_keycodes = false
  --     })
  --     vim.keymap.set('i', '<C-/>', '<Plug>(copilot-next)')
  --     vim.keymap.set('i', '<C-\\>', '<Plug>(copilot-previous)')
  --   end,
  -- },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = true,
    version = false, -- set this if you want to always pull the latest change
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "hrsh7th/nvim-cmp",            -- autocompletion for avante commands and mentions
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua",      -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
    opts = {
      ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "vertex" | "cohere" | "copilot" | string
      provider = "copilot",
      auto_suggestions_provider = "copilot",
      mappings = {
        ---@class AvanteConflictMappings
        diff = {
          ours = "co",
          theirs = "ct",
          all_theirs = "ca",
          both = "cb",
          cursor = "cc",
          next = "]x",
          prev = "[x",
        },
        suggestion = {
          accept = "<M-l>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
        jump = {
          next = "]]",
          prev = "[[",
        },
        submit = {
          normal = "<CR>",
          insert = "<C-s>",
        },
        -- NOTE: The following will be safely set by avante.nvim
        ask = "<leader>aa",
        edit = "<leader>ae",
        refresh = "<leader>ar",
        focus = "<leader>af",
        toggle = {
          default = "<leader>at",
          debug = "<leader>ad",
          hint = "<leader>ah",
          suggestion = "<leader>as",
          repomap = "<leader>aR",
        },
        sidebar = {
          apply_all = "A",
          apply_cursor = "a",
          switch_windows = "<Tab>",
          reverse_switch_windows = "<S-Tab>",
          remove_file = "d",
          add_file = "@",
        },
        files = {
          add_current = "<leader>ac", -- Add current buffer to selected files
        },
      },
    }
  },
}
