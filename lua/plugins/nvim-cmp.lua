return {
    {
        'hrsh7th/nvim-cmp',
        -- event = "VeryLazy",
        event = "InsertEnter",
        dependencies = {
            'neovim/nvim-lspconfig',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',

            'onsails/lspkind-nvim',

            --snips
            'SirVer/ultisnips',
            'quangnguyen30192/cmp-nvim-ultisnips',
            'honza/vim-snippets',
            --'hrsh7th/cmp-vsnip',
            --'hrsh7th/vim-vsnip',
        },
        config = function()

            local cmp_kinds = {
              Text = '  ',
              Method = '  ',
              Function = '  ',
              Constructor = '  ',
              Field = '  ',
              Variable = '  ',
              Class = '  ',
              Interface = '  ',
              Module = '  ',
              Property = '  ',
              Unit = '  ',
              Value = '  ',
              Enum = '  ',
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
            }

            local cmp = require('cmp')
            require("cmp_nvim_ultisnips").setup{
                filetype_source = "treesitter",
                show_snippets = "all",
                documentation = function(snippet)
                    return snippet.description
                end
            }
            local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
            vim.g.UltiSnipsRemoveSelectModeMappings = 1
            cmp.setup {
                view = {
                    entries = "custom",
                },
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                       vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                    end,
                },
                window = {
                  -- completion = cmp.config.window.bordered(),
                  -- documentation = cmp.config.window.bordered(),
                },

                mapping = {
                    -- ... Your other mappings ...
                    ["<Tab>"] = cmp.mapping(
                        function(fallback)
                            cmp_ultisnips_mappings.compose{"select_next_item", "expand"}(fallback)
                        end,
                        { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
                    ),
                    ["<S-Tab>"] = cmp.mapping(
                        function(fallback)
                            cmp_ultisnips_mappings.compose{"select_prev_item", "expand"}(fallback)
                        end,
                        { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
                    ),
                    ["<c-j>"] = cmp.mapping(
                        function(fallback)
                            cmp_ultisnips_mappings.compose{"jump_forwards"}(fallback)
                        end,
                        { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
                    ),
                    ["<c-k>"] = cmp.mapping(
                        function(fallback)
                            cmp_ultisnips_mappings.compose{"jump_backwards"}(fallback)
                        end,
                        { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
                    ),
                    ['<CR>'] = cmp.mapping.confirm({select = false }),
                },

                sources = cmp.config.sources({
                     { name = 'nvim_lsp' },
                     -- { name = 'vsnip' }, -- For vsnip users.
                     -- { name = 'luasnip' }, -- For luasnip users.
                     { name = 'ultisnips' }, -- For ultisnips users.
                     -- { name = 'snippy' }, -- For snippy users.
                     { name = 'buffer' },
                     { name = 'path' },
                     { name = 'treesitter' },
                   }
                 ),

              formatting = {
                  format = function(_, vim_item)
                     vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. vim_item.kind
                     return vim_item
                end,
              },

                                    -- ... Your other configuration ...

             }

             -- Set configuration for specific filetype.
             cmp.setup.filetype('gitcommit', {
               sources = cmp.config.sources({
                 { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
               }, {
                 { name = 'buffer' },
               })
             })

            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ '/', '?' }, {
              mapping = cmp.mapping.preset.cmdline(),
              sources = {
                { name = 'buffer' }
              }
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
              mapping = cmp.mapping.preset.cmdline(),
              sources = cmp.config.sources({
                { name = 'path' }
              }, {
                { name = 'cmdline' }
              })
          })

          -- Set up lspconfig.
          local capabilities = require('cmp_nvim_lsp').default_capabilities()
          -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
           require('lspconfig')['lua_ls'].setup {
             capabilities = capabilities
           }
           require('lspconfig')['marksman'].setup {
             capabilities = capabilities
           }
           require('lspconfig')['jsonls'].setup {
             capabilities = capabilities
           }
                                     -- icon
            -- gray
            vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg='NONE', strikethrough=true, fg='#808080' })
            -- blue
            vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg='NONE', fg='#569CD6' })
            vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link='CmpIntemAbbrMatch' })
            -- light blue
            vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg='NONE', fg='#9CDCFE' })
            vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link='CmpItemKindVariable' })
            vim.api.nvim_set_hl(0, 'CmpItemKindText', { link='CmpItemKindVariable' })
            -- pink
            vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg='NONE', fg='#C586C0' })
            vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link='CmpItemKindFunction' })
            -- front
            vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg='NONE', fg='#D4D4D4' })
            vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link='CmpItemKindKeyword' })
            vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link='CmpItemKindKeyword' })

        end,
    },
    {
        "folke/neodev.nvim",
        opts = {},
        lazy = true,
        config = function()
            require("neodev").setup {
                library = {
                  enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
                  -- these settings will be used for your Neovim config directory
                  runtime = true, -- runtime path
                  types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
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
}
