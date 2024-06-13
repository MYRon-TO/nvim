local servers = require("lsp_conf").servers
local packages = require("lsp_conf").packages

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
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  for server_name, conf_opts in pairs(require("lsp_conf").lsp_servers) do
    opts = vim.tbl_deep_extend("force", conf_opts, opts)
    lspconfig[server_name].setup(opts)
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
      -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
      vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
      vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts)
      vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
      -- vim.keymap.set({ 'n', 'v' }, '<space>a', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      -- vim.keymap.set('n', '<space>f', function()
      --     vim.lsp.buf.format { async = true }
      -- end, opts)
    end,
  })
end

local M = {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents
    lazy = false,
    event = "VeryLazy",
    cmd = "Mason",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      lazy = true,
    },
    config = function()
      require("mason").setup()
      local registry = require("mason-registry")
      local ensure_installed = function()
        for _, name in pairs(packages) do
          if not registry.is_installed(name) then
            local package = registry.get_package(name)
            package:install()
          end
        end
      end
      registry.refresh(vim.schedule_wrap(ensure_installed))

      require("mason-lspconfig").setup({
        ensure_installed = servers,
        automatic_installation = false,
      })
    end,
  },
}

-- # A plugin to manage local lsp settings ( only json )
-- > Not Need yet
--
-- local C = {
--   'tamago324/nlsp-settings.nvim',
--   lazy = false,
--   cmd = {
--     "LspSettings"
--   },
--   config = function()
--     require("nlspsettings").setup({
--       -- config_home = vim.fn.stdpath('config') .. '/nlsp-settings',
--       -- local_settings_dir = ".nlsp-settings",
--       local_settings_root_markers_fallback = { '.no-git','.git' },
--       -- append_default_schemas = true,
--       loader = 'json'
--     })
--   end
-- }

return {
  M,
  L,
  -- C,
  {
    'weilbith/nvim-code-action-menu',
    lazy = true,
    cmd = 'CodeActionMenu',
    keys = {
      { "<leader>a", ":CodeActionMenu<CR>", "n" },
    },
  },
}
