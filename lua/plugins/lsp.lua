local servers = require("lsp_conf").servers
local packages = require("lsp_conf").packages

-- ### Debug ###
function _PrintTable(my_table, indent)
  indent = indent or 0
  for key, value in pairs(my_table) do
    if type(value) == "table" then
      print(string.rep(" ", indent) .. key .. " = {")
      _PrintTable(value, indent + 2)
      print(string.rep(" ", indent) .. "}")
    else
      print(string.rep(" ", indent) .. key .. " = " .. tostring(value))
    end
  end
end

local L = {
  "neovim/nvim-lspconfig",
  lazy = "LazyFile",
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

  for server_name, conf_opts in pairs(require("lsp_conf").lsp_servers) do
    local opts = conf_opts
    -- opts.on_attach = on_attach
    opts.capabilities = vim.tbl_deep_extend("force", conf_opts.capabilities or {}, capabilities)
    -- if server_name == "tinymist" then
    --   _PrintTable(opts)
    -- end
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
--

local A = {
  "aznhe21/actions-preview.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
  },
  lazy = true,
  keys = {
    "<leader>a",
  },
  config = function()
    vim.keymap.set({ "v", "n" }, "<leader>a", require("actions-preview").code_actions)

    require("actions-preview").setup {

      -- priority list of external command to highlight diff
      -- disabled by defalt, must be set by yourself
      highlight_command = {
        require("actions-preview.highlight").delta(ENV.delta_path),
        -- require("actions-preview.highlight").diff_so_fancy(),
        -- require("actions-preview.highlight").diff_highlight(),
      },

      -- priority list of preferred backend
      backend = { "telescope", "nui" },

      -- options related to telescope.nvim
      telescope = vim.tbl_extend(
        "force",
        -- telescope theme: https://github.com/nvim-telescope/telescope.nvim#themes
        -- require("telescope.themes").get_cursor(),
        require("telescope.themes").get_dropdown(),
        -- a table for customizing content
        {
          -- a function to make a table containing the values to be displayed.
          -- fun(action: Action): { title: string, client_name: string|nil }
          make_value = nil,

          -- a function to make a function to be used in `display` of a entry.
          -- see also `:h telescope.make_entry` and `:h telescope.pickers.entry_display`.
          -- fun(values: { index: integer, action: Action, title: string, client_name: string }[]): function
          make_make_display = nil,
        }),

    }
  end,
}



return {
  M,
  L,
  -- C,
  A
}
