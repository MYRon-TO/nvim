return
-- ---@type LazySpec
-- {
--   "mikavilpas/yazi.nvim",
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--   },
--   -- event = "VeryLazy",
--   lazy = true,
--   cmd = "Yazi",
--   keys = {
--     {
--       "<leader>fy",
--       function()
--         require("yazi").yazi()
--       end,
--       { desc = "Open the file manager" },
--     },
--   },
-- }
{
  "DreamMaoMao/yazi.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },

  keys = {
    { "<leader>fy", "<cmd>Yazi<CR>", desc = "Toggle Yazi" },
  },
}
