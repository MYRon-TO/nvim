local M = {
  "hrsh7th/nvim-cmp",
  cond = vim.g.vscode == nil,
  dependencies = {
    { "hrsh7th/cmp-nvim-lsp", },
    { "hrsh7th/cmp-buffer", },
    { "hrsh7th/cmp-path", },
    { "hrsh7th/cmp-cmdline", },
    { "hrsh7th/cmp-calc", },

    { "kdheepak/cmp-latex-symbols", },

    {
      "zbirenbaum/copilot-cmp",
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
      lazy = true,
      config = function()
        require("copilot_cmp").setup()
      end
    },

    {
      'L3MON4D3/LuaSnip',
      build = "make install_jsregexp",
      dependencies = { "rafamadriz/friendly-snippets" },
    },
    { 'saadparwaiz1/cmp_luasnip', },
    {
      'onsails/lspkind-nvim',
      config = function()
        require('lspkind').init({
          -- DEPRECATED (use mode instead): enables text annotations
          --
          -- default: true
          -- with_text = true,

          -- defines how annotations are shown
          -- default: symbol
          -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
          mode = 'text_symbol',

          -- default symbol map
          -- can be either 'default' (requires nerd-fonts font) or
          -- 'codicons' for codicon preset (requires vscode-codicons font)
          --
          -- default: 'default'
          preset = 'default',

          -- override preset symbols
          --
          -- default: {}
        })
      end
    },
  },
  event = {
    "InsertEnter",
    "CmdlineEnter",
  },
}

-- local has_words_before = function()
--     local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--     return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end
-- local limitStr = function(str)
--     if #str > 25 then
--         str = string.sub(str, 1, 22) .. "..."
--     end
--     return str
-- end

function M.config()
  local symbol_map = {
    Text = '  ',
    Variable = '  ',
    Class = '  ',
    Interface = '  ',
    Module = '  ',
    Property = '  ',
    Unit = '  ',
    Keyword = '  ',
    Snippet = '󱪇  ',
    Color = '  ',
    File = '  ',
    Reference = '  ',
    Folder = '  ',
    EnumMember = '  ',
    Constant = '  ',
    Struct = '  ',
    Event = '  ',
    Operator = '  ',
    TypeParameter = '  ',
    Method = "m",
    Function = "󰊕",
    Constructor = "",
    Field = "",
    Value = "󰎠",
    Enum = "",
    Codeium = "󰚩",
    Copilot = "",
  }

  -- require("luasnip/loaders/from_vscode").lazy_load()  -- load the friendly-snippets
  require("luasnip/loaders/from_vscode").lazy_load({ paths = require("env/snip_path") }) -- load the friendly-snippets

  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end
  local luasnip = require("luasnip")
  local cmp = require("cmp")
  local compare = require('cmp.config.compare')
  cmp.setup {
    sorting = {
      comparators = {
        compare.sort_text,
        compare.offset,
        compare.exact,
        compare.score,
        compare.recently_used,
        compare.kind,
        compare.length,
        compare.order,
      }
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    mapping = {
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),

      ["<C-h>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<C-e>"] = cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },
      -- Accept currently selected item. If none selected, `select` first item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      ["<CR>"] = cmp.mapping.confirm { select = false },

      ["<c-j>"] = cmp.mapping(function(fallback)
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),

      ["<c-k>"] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),

      ["<Tab>"] = cmp.mapping(function(fallback)
        if luasnip.choice_active() then
          luasnip.change_choice(1)
        elseif cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expandable() then
          luasnip.expand()
        else
          fallback()
        end
      end, {
        "i",
        "s",
        "c",
      }),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if luasnip.choice_active() then
          luasnip.change_choice(-1)
        elseif cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, {
        "i",
        "s",
        "c",
      }),
    },
    formatting = {
      -- fields = { "kind", "abbr", "menu" },
      -- maxwidth = 80,
      -- maxheight = 10,
      -- format = function(entry, vim_item)
      --     local kind = lspkind.cmp_format({
      --         mode = "symbol_text",
      --         symbol_map = symbol_map,
      --     })(entry, vim_item)
      --     local strings = vim.split(kind.kind, "%s", { trimempty = true })
      --     kind.kind = " " .. (strings[1] or "") .. " "
      --     kind.menu = limitStr(entry:get_completion_item().detail or "")

      --     return kind
      -- end,
      format = require('lspkind').cmp_format({
        mode = 'symbol_text',  -- show only symbol annotations
        maxwidth = 100,        -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

        -- The function below will be called before any actual modifications from lspkind
        -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
        -- before = function(entry, vim_item)
        --      vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. vim_item.kind
        --     return vim_item
        -- end
        before = function(_, vim_item)
          vim_item.kind = (symbol_map[vim_item.kind] or '') .. '[' .. vim_item.kind .. ']'
          return vim_item
        end
      })
    },
    sources = {
      { name = "copilot"},
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
      { name = 'luasnip' },
      { name = "orgmode" },
      { name = "buffer" },
      { name = "path" },
      { name = 'treesitter' },
      {
        name = "latex_symbols",
        option = {
          strategy = 0, -- mixed
        },
      },
    },
    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    window = {
      -- completion = {
      --     -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
      --     col_offset = -3,
      --     side_padding = 0,
      -- },
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    experimental = {
      ghost_text = false,
    },
    view = {
      entries = "custom",
    },
  }
  cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
      },
      {
        {
          name = "cmdline",
          option = {
            -- ignore_cmds = { "Man", "!" },
          },
        },
      }),
  })
end

local N = {
  "folke/neodev.nvim",
  lazy   = true,
  event  = {
    "BufReadPre " .. vim.fn.expand "~" .. "/.config/nvim/**.lua",
  },
  config = function()
    require("neodev").setup {
      library = {
        enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
        -- these settings will be used for your Neovim config directory
        runtime = true, -- runtime path
        types = true,   -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
        -- plugins = true, -- installed opt or start plugins in packpath
        -- you can also specify the list of plugins to make available as a workspace library
        plugins = { "nvim-dap-ui", "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
      },
      setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
      -- for your Neovim config directory, the config.library settings will be used as is
      -- for plugin directories (root_dirs having a /lua directory), config.library.plugins will be disabled
      -- for any other directory, config.library.enabled will be set to false
      lspconfig = true,
      -- much faster, but needs a recent built of lua-language-server
      -- needs lua-language-server >= 3.6.0
      pathStrict = true,
    }
  end,
}

return { M, N }
