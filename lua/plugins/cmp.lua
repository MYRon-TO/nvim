local M = {
    "hrsh7th/nvim-cmp",
    cond = vim.g.vscode == nil,
    dependencies = {
        { "hrsh7th/cmp-nvim-lsp", },
        { "hrsh7th/cmp-buffer", },
        { "hrsh7th/cmp-path", },
        { "hrsh7th/cmp-cmdline", },
        { "saadparwaiz1/cmp_luasnip", },
        { "kdheepak/cmp-latex-symbols", },
        { "hrsh7th/cmp-nvim-lua", },
        {
            "L3MON4D3/LuaSnip",
            event = "InsertEnter",
            dependencies = {
                "rafamadriz/friendly-snippets",
            },
        },
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

function M.config()
    local cmp = require "cmp"
    local luasnip = require "luasnip"
    require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/snippets" } })
    -- require("../snippets").setup_snippets()

    -- local check_backspace = function()
    --     local col = vim.fn.col "." - 1
    --     return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
    -- end
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

    cmp.setup {
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)     -- For `luasnip` users.
            end,
        },
        mapping = {
            ["<S-Tab>"] = cmp.mapping.select_prev_item(),
            ["<Tab>"] = cmp.mapping.select_next_item(),
            ["<C-b>"] = cmp.mapping.scroll_docs(-2),
            ["<C-f>"] = cmp.mapping.scroll_docs(2),
            ["<C-h>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.close(),
            ["<CR>"] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
            },
            ["<C-j>"] = cmp.mapping(function(fallback)
                    if luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end,
                { "i", "s", }
            ),
            ["<C-k>"] = cmp.mapping(function(fallback)
                    if luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end,
                { "i", "s", }
            ),
        },
        formatting = {
            format = require('lspkind').cmp_format({
                mode = 'symbol_text',      -- show only symbol annotations
                maxwidth = 100,             -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                ellipsis_char = '...',     -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

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
            { name = "nvim_lsp" },
            { name = "nvim_lua" },
            { name = "luasnip" },
            { name = "orgmode" },
            { name = "buffer" },
            { name = "path" },
            {
                name = "latex_symbols",
                option = {
                    strategy = 0,     -- mixed
                },
            },
        },
        confirm_opts = {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        experimental = {
            ghost_text = true,
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
    opts = {},
    lazy = true,
    config = function()
        require("neodev").setup {
            library = {
                enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
                -- these settings will be used for your Neovim config directory
                runtime = true, -- runtime path
                types = true,   -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
                plugins = true, -- installed opt or start plugins in packpath
                -- you can also specify the list of plugins to make available as a workspace library
                -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
            },
            setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
            -- for your Neovim config directory, the config.library settings will be used as is
            -- for plugin directories (root_dirs having a /lua directory), config.library.plugins will be disabled
            -- for any other directory, config.library.enabled will be set to false
            override = function(root_dir, options) end,
            -- With lspconfig, Neodev will automatically setup your lua-language-server
            -- If you disable this, then you have to set {before_init=require("neodev.lsp").before_init}
            -- in your lsp start options
            lspconfig = true,
            -- much faster, but needs a recent built of lua-language-server
            -- needs lua-language-server >= 3.6.0
            pathStrict = true,
        }
    end,
}


return { M, N }
