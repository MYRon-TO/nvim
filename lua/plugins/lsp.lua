local servers = {
    "clangd",        -- C/C++
    "rust_analyzer", -- Rust
    "lua_ls",        -- Lua
    "jdtls",         -- Java
    "pyright",       -- Python
    "marksman",      -- Markdown
    "bashls",        -- Bash
    -- "golangci_lint_ls", -- Go
    "omnisharp",     -- C#
    "biome",         -- JS/TS JSON
    "html-lsp",      -- HTML
}

local M = {
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate", -- :MasonUpdate updates registry contents
        lazy = false,
        event = "BufReadPre",
        cmd = "Mason",
        depancies = {
            "williamboman/mason-lspconfig.nvim",
            lazy = true,
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = servers,
                automatic_installation = false,
            })
        end,
    },
}

local L = {
    "neovim/nvim-lspconfig",
    lazy = true,
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
    },
}

function L.config()
    -- Setup language servers.
    local lspconfig = require('lspconfig')

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    for _, server in pairs(servers) do
        Opts = {
            -- on_attach = on_attach,
            capabilities = capabilities,
            -- offset_encoding = "utf-16",
        }

        server = vim.split(server, "@")[1]

        local require_ok, conf_opts = pcall(require, "lsp." .. server)
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
            -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
            vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
            vim.keymap.set('n', '<space>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, opts)
            vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
            -- vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            vim.keymap.set('n', '<space>f', function()
                vim.lsp.buf.format { async = true }
            end, opts)
        end,
    })
end

return {
    M,
    L,
}
