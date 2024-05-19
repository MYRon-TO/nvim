return {
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
  },
  -- {
  --   "kawre/leetcode.nvim",
  --   build = ":TSUpdate html",
  --   dependencies = {
  --     "nvim-telescope/telescope.nvim",
  --     "nvim-lua/plenary.nvim", -- telescope 所需
  --     "MunifTanjim/nui.nvim",

  --     -- 可选
  --     "nvim-treesitter/nvim-treesitter",
  --     "rcarriga/nvim-notify",
  --     "nvim-tree/nvim-web-devicons",
  --   },
  --   opts = {
  --     -- 配置放在这里
  --     arg = "leetcode",
  --     lang = "rust",
  --     cn = {
  --       enabled = true,
  --     },
  --     image_support = false,
  --   },
  -- }
}
