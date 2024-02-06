return {
  {
    'mbbill/undotree',
    lazy = true,
    keys = {
      { "cud", ":UndotreeToggle<CR>", "n" },
    },
  },
  {
    'weilbith/nvim-code-action-menu',
    lazy = true,
    cmd = 'CodeActionMenu',
    keys = {
      { "<leader>a", ":CodeActionMenu<CR>", "n" },
    },
  },
  -- {
  --   "wakatime/vim-wakatime",
  --   event = "VeryLazy",
  -- }
  {
    "willothy/flatten.nvim",
    -- A plugin that avoids nested opening of nvim
    -- config = true,
    -- or pass configuration with
    opts = { window = { open = "alternate" } },
    -- Ensure that it runs first to minimize delay when opening file from terminal
    lazy = false,
    event = "VeryLazy",
    priority = 1001,
  },
  {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
    -- opts = {
    --   override = {
    --     toml = {
    --       icon = "",
    --       color = "#428850",
    --       name = "Toml"
    --     }
    --   }
    -- }
  },
}
