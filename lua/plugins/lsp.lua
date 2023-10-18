local servers = {
    "clangd",        -- C/C++
    "rust_analyzer", -- Rust
    "lua_ls",        -- Lua
    "jdtls",         -- Java
    "pyright",       -- Python
    "marksman",      -- Markdown
    -- "bashls",        -- Bash
    "gopls",         -- Go
    "omnisharp",     -- C#
    "biome",         -- JS/TS JSON
    "html",          -- HTML
    "cssls",          -- CSS
    "psalm",         -- PHP
}

local M = {
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate", -- :MasonUpdate updates registry contents
        lazy = false,
        event = "VeryLazy",
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

local B = {
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            position = "bottom",    -- position of the list can be: bottom, top, left, right
            height = 10,            -- height of the trouble list when position is top or bottom
            width = 50,             -- width of the list when position is left or right
            icons = true,           -- use devicons for filenames
            mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
            severity = nil,         -- nil (ALL) or vim.diagnostic.severity.ERROR | WARN | INFO | HINT
            fold_open = "",      -- icon used for open folds
            fold_closed = "",    -- icon used for closed folds
            group = true,           -- group results by file
            padding = true,         -- add an extra new line on top of the list
            cycle_results = true,   -- cycle item list when reaching beginning or end of list
            action_keys = {         -- key mappings for actions in the trouble list
                -- map to {} to remove a mapping, for example:
                -- close = {},
                close = "q",                                                               -- close the list
                cancel = "<esc>",                                                          -- cancel the preview and get back to your last window / buffer / cursor
                refresh = "r",                                                             -- manually refresh
                jump = { "<cr>", "<tab>", "<2-leftmouse>" },                               -- jump to the diagnostic or open / close folds
                open_split = { "<c-x>" },                                                  -- open buffer in new split
                open_vsplit = { "<c-v>" },                                                 -- open buffer in new vsplit
                open_tab = { "<c-t>" },                                                    -- open buffer in new tab
                jump_close = { "o" },                                                      -- jump to the diagnostic and close the list
                toggle_mode = "m",                                                         -- toggle between "workspace" and "document" diagnostics mode
                switch_severity = "s",                                                     -- switch "diagnostics" severity filter level to HINT / INFO / WARN / ERROR
                toggle_preview = "P",                                                      -- toggle auto_preview
                hover = "K",                                                               -- opens a small popup with the full multiline message
                preview = "p",                                                             -- preview the diagnostic location
                open_code_href = "c",                                                      -- if present, open a URI with more information about the diagnostic error
                close_folds = { "zM", "zm" },                                              -- close all folds
                open_folds = { "zR", "zr" },                                               -- open all folds
                toggle_fold = { "zA", "za" },                                              -- toggle fold of current file
                previous = "k",                                                            -- previous item
                next = "j",                                                                 -- next item
                help = "?"                                                                 -- help menu
            },
            multiline = true,                                                              -- render multi-line messages
            indent_lines = true,                                                           -- add an indent guide below the fold icons
            win_config = { border = "single" },                                            -- window configuration for floating windows. See |nvim_open_win()|.
            auto_open = false,                                                             -- automatically open the list when you have diagnostics
            auto_close = false,                                                            -- automatically close the list when you have no diagnostics
            auto_preview = true,                                                           -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
            auto_fold = false,                                                             -- automatically fold a file trouble list at creation
            auto_jump = { "lsp_definitions" },                                             -- for the given modes, automatically jump if there is only a single result
            include_declaration = { "lsp_references", "lsp_implementations", "lsp_definitions" }, -- for the given modes, include the declaration of the current symbol in the results
            signs = {
                -- icons / text used for a diagnostic
                error = "",
                warning = "",
                hint = "",
                information = "",
                other = "",
            },
            use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
        }
    }

}

return {
    M,
    L,
    B,
}
