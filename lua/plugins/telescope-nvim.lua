return {
    'git@github.com:nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = true,
    keys = {
      { '<leader>ff', ':Telescope find_files<cr>' },
      { '<leader>fg', ':Telescope live_grep<cr>' },
      { '<leader>fb', ':Telescope buffers<cr>' },
      { '<leader>fh', ':Telescope help_tags<cr>' },
    },
    config = function()
      require('telescope').setup{
          defaults = {
              borderchars = { "█", " ", "▀", "█", "█", " ", " ", "▀" },
          }
      }
    end,
    }
