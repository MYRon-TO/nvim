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

        { 'SirVer/ultisnips', },
        { 'quangnguyen30192/cmp-nvim-ultisnips', },
        { 'honza/vim-snippets', },

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

-- local setCompHL = function()
--     local fgdark = "#2E3440"

--     vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bg = "NONE", bold = true })
--     vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bg = "NONE", bold = true })
--     vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })

--     vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#808080", bg = "NONE", italic = true })
--     vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = fgdark, bg = "#B5585F" })
--     vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = fgdark, bg = "#B5585F" })
--     vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = fgdark, bg = "#B5585F" })

--     vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = fgdark, bg = "#9FBD73" })
--     vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = fgdark, bg = "#9FBD73" })
--     vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = fgdark, bg = "#9FBD73" })

--     vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = fgdark, bg = "#D4BB6C" })
--     vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = fgdark, bg = "#D4BB6C" })
--     vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = fgdark, bg = "#D4BB6C" })

--     vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = fgdark, bg = "#A377BF" })
--     vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = fgdark, bg = "#A377BF" })
--     vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = fgdark, bg = "#A377BF" })
--     vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = fgdark, bg = "#A377BF" })
--     vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = fgdark, bg = "#A377BF" })

--     vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = fgdark, bg = "#7E8294" })
--     vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = fgdark, bg = "#7E8294" })

--     vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = fgdark, bg = "#D4A959" })
--     vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = fgdark, bg = "#D4A959" })
--     vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = fgdark, bg = "#D4A959" })

--     vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = fgdark, bg = "#6C8ED4" })
--     vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = fgdark, bg = "#6C8ED4" })
--     vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = fgdark, bg = "#6C8ED4" })

--     vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = fgdark, bg = "#58B5A8" })
--     vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = fgdark, bg = "#58B5A8" })
--     vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = fgdark, bg = "#58B5A8" })
-- end

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
-- local limitStr = function(str)
--     if #str > 25 then
--         str = string.sub(str, 1, 22) .. "..."
--     end
--     return str
-- end

function M.config()
    local cmp = require "cmp"
    local lspkind = require("lspkind")
    -- setCompHL()
    require("cmp_nvim_ultisnips").setup {
        filetype_source = "treesitter",
        show_snippets = "all",
        documentation = function(snippet)
            return snippet.description
        end
    }
    local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
    vim.g.UltiSnipsRemoveSelectModeMappings = 1

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
                vim.fn["UltiSnips#Anon"](args.body)
            end
        },
        mapping = {
            ["<C-h>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping({ i = cmp.mapping.close(), c = cmp.mapping.close() }),
            ['<CR>'] = cmp.mapping({
                i = function(fallback)
                    if cmp.visible() and cmp.get_active_entry() then
                        cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                    else
                        fallback()
                    end
                end
            }),
            ["<Tab>"] = cmp.mapping({
                i = function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end,
            }),
            ["<S-Tab>"] = cmp.mapping({
                i = function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                    else
                        fallback()
                    end
                end,
            }),
            ["<c-j>"] = cmp.mapping(
                function(fallback)
                    cmp_ultisnips_mappings.compose { "jump_forwards" } (fallback)
                end,
                { "i", "s", "c" }
            ),
            ["<c-k>"] = cmp.mapping(
                function(fallback)
                    cmp_ultisnips_mappings.compose { "jump_backwards" } (fallback)
                end,
                { "i", "s", "c" }
            ),
            ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
            ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
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
            { name = 'ultisnips' }, -- For ultisnips users.
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
