return {
  'https://codeberg.org/esensar/nvim-dev-container',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  lazy = true,
  cmd = {
    'DevContainerAttach',
    'DevContainerDetach',
    'DevContainerStart',
    'DevContainerStop',
    'DevContainerRestart',
    'DevContainerRebuild',
    'DevContainerLogs',
    'DevContainerExec',
    'DevContainerOpen',
    'DevContainerClose',
    'DevContainerList',
    'DevContainerInfo',
  },
  config = function()
    require("devcontainer").setup {
      attach_mounts = {
        neovim_config = {
          enabled = true,
          options = { "readonly" }
        },
        neovim_data = {
          enabled = true,
          options = {}
        },
        -- Only useful if using neovim 0.8.0+
        neovim_state = {
          enabled = false,
          options = {}
        },
      },
    }
  end,
}
