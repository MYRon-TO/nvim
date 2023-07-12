local servers = {
    "clangd",
    "rust_analyzer",
    "lua_ls",
    "jdtls",
    "pyright",
    "marksman",
    "jsonls",
    "bashls",
    "golangci_lint_ls",
    "omnisharp",
}
return {
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = servers,
                automatic_installation = true,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            -- require("mason-lspconfig").setup_handlers{
            --     -- The first entry (without a key) will be the default handler
            --     -- and will be called for each installed server that doesn't have
            --     -- a dedicated handler.
            --     -- function (server_name) -- default handler (optional)
            --     --     require("lspconfig")[server_name].setup {}
            --     -- end,
            --     -- Next, you can provide a dedicated handler for specific servers.
            --     -- For example, a handler override for the `rust_analyzer`:
            --     -- ["rust_analyzer"] = function ()
            --     --     require("rust-tools").setup {}
            --     -- end,
            --     --
            --     ["lua_ls"] = function ()
            --         lspconfig.lua_ls.setup {
            --             capabilities = capabilities,
            --             settings = {
            --                     Lua = {
            --                       diagnostics = {
            --                         globals = { "vim" }
            --                       }
            --                     }
            --                 }
            --         }
            --     end,
            --     ["marksman"] = function ()
            --         lspconfig.marksman.setup {
            --             capabilities = capabilities,
            --             settings = {
            --                 marksman = {
            --                     check = {
            --                         enable = true,
            --                         mode = "workspace",
            --                     },
            --                     lint = {
            --                         enable = true,
            --                         mode = "workspace",
            --                     },
            --                 },
            --             },
            --         }
            --     end,
            --     ["jsonls"] = function ()
            --         lspconfig.jsonls.setup {}
            --     end,
            --     ["jdtls"] = function ()
            --         lspconfig.jdtls.setup {}
            --     end,
            -- }
            for _, server in pairs(servers) do
                Opts = {
                    on_attach = on_attach,
                    capabilities = capabilities,
                    -- offset_encoding = "utf-16",
                }

                server = vim.split(server, "@")[1]

                local require_ok, conf_opts = pcall(require, "settings." .. server)
                if require_ok then
                    Opts = vim.tbl_deep_extend("force", conf_opts, Opts)
                end

                lspconfig[server].setup(Opts)
            end
            -- Global mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
            vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = { buffer = ev.buf }
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    --vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
                    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
                    vim.keymap.set('n', '<space>wl',
                        function()
                            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                        end,
                    opts)
                    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
                    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                    vim.keymap.set('n', '<space>f',
                        function()
                            vim.lsp.buf.format { async = true }
                        end,
                    opts)
                end,
            })
        end,
    },
}
