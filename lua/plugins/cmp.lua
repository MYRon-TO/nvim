-- for rime_ls
vim.opt.iskeyword = "_,49-57,A-Z,a-z"

local blink = {
  'saghen/blink.cmp',
  lazy = true,
  event = "InsertEnter",
  -- optional: provides snippets for the snippet source
  dependencies = {
    'rafamadriz/friendly-snippets',
    {
      'echasnovski/mini.icons',
      version = false,
      lazy = true,
      opts = function()
        require('mini.icons').mock_nvim_web_devicons()
        return {
          lsp = {
            copilot = { glyph = '', hl = 'CmpCopilot' },
          }
        }
      end
    },
    "kdheepak/cmp-latex-symbols",
    {
      "giuxtaposition/blink-cmp-copilot",
      dependencies = {
        {
          "zbirenbaum/copilot.lua",
          lazy = true,
          config = function()
            require("copilot").setup({
              suggestion = { enabled = false },
              panel = { enabled = false },
            })
          end
        },
      },
    },
  },
  -- use a release tag to download pre-built binaries
  version = '*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- See the full "keymap" documentation for information on defining your own keymap.
    keymap = {
      ---@alias preset "defualt" | "super-tab"| "enter"
      preset = "enter",

      ['<C-h>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide' },
      ['<C-j>'] = { 'select_next', 'fallback' },
      ['<C-k>'] = { 'select_prev', 'fallback' },
      ['<C-p>'] = { 'fallback' },
      ['<C-n>'] = { 'fallback' },
      ['<C-space>'] = { 'fallback' },

      cmdline = {
        preset = "super-tab",

        ['<C-h>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-p>'] = { 'fallback' },
        ['<C-n>'] = { 'fallback' },
        ['<C-space>'] = { 'fallback' },
      }
    },

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- Will be removed in a future release
      use_nvim_cmp_as_default = true,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },
    completion = {
      list = {
        selection = {
          preselect = false,
          auto_insert = true
        }
      },
      menu = {
        border = 'none',
        draw = {
          components = {
            kind_icon = {
              ellipsis = false,
              text = function(ctx)
                local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                return kind_icon
              end,
              -- Optionally, you may also use the highlights from mini.icons
              highlight = function(ctx)
                local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                return hl
              end,
            },
            source_name = {
              text = function(ctx) return '[' .. ctx.source_name .. ']' end
            },
          },
          columns = {
            { "kind_icon", "label", "label_description", gap = 1 },
            { "kind" }
          },
          -- treesitter = { "lsp" },
        },
      }
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = {
        "lazydev",
        "lsp",
        "path",
        "snippets",
        "buffer",
        "latex_symbols",
        "avante_commands",
        "avante_mentions",
        "avante_files",
        "copilot",
      },
      providers = {
        lsp = {
          score_offset = 100,
          transform_items = function(_, items)
            -- the default transformer will do this
            for _, item in ipairs(items) do
              if item.kind == require('blink.cmp.types').CompletionItemKind.Snippet then
                item.score_offset = item.score_offset - 3
              end
            end
            -- you can define your own filter for rime item
            return items
          end
        },
        copilot = {
          name = "copilot",
          module = "blink-cmp-copilot",
          score_offset = -10,
          async = true,
          transform_items = function(_, items)
            local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
            local kind_idx = #CompletionItemKind + 1
            CompletionItemKind[kind_idx] = "Copilot"
            for _, item in ipairs(items) do
              item.kind = kind_idx
            end
            return items
          end,
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
        avante_commands = {
          name = "avante_commands",
          module = "blink.compat.source",
          score_offset = 100,
          opts = {},
        },
        avante_files = {
          name = "avante_commands",
          module = "blink.compat.source",
          score_offset = 100, -- show at a higher priority than lsp
          opts = {},
        },
        avante_mentions = {
          name = "avante_mentions",
          module = "blink.compat.source",
          score_offset = 1000, -- show at a higher priority than lsp
          opts = {},
        },
        latex_symbols = {
          name = 'latex_symbols',
          module = "blink.compat.source",
          score_offset = 100,
          opts = {
          },
        }
      },
    },
  },
  opts_extend = { "sources.default" }
}

local blink_compat = {
  'saghen/blink.compat',
  -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
  version = '*',
  -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
  lazy = true,
  -- make sure to set opts so that lazy.nvim calls blink.compat's setup
  opts = {},
}

local lazydev = {
  "folke/lazydev.nvim",
  ft = "lua", -- only load on lua files
  opts = {
    library = {
      -- See the configuration section for more details
      -- Load luvit types when the `vim.uv` word is found
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
}

return {
  blink_compat,
  blink,
  lazydev
}
