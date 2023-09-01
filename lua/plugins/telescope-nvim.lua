return {
    'nvim-telescope/telescope.nvim',
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
        require('telescope').setup {
            defaults = {
                -- Default configuration for telescope goes here:
                vimgrep_arguments = vimgrep_arguments,
                -- config_key = value,
                -- borderchars = { "█", " ", "▀", "█", "█", " ", " ", "▀" },
                mappings = {
                    i = {
                        -- map actions.which_key to <C-h> (default: <C-/>)
                        -- actions.which_key shows the mappings for your picker,
                        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                        -- ["<C-h>"] = "which_key"
                        ["<C-j>"] = "move_selection_next",
                        ["<C-k>"] = "move_selection_previous",
                        ["<C-h>"] = "preview_scrolling_up",
                        ["<C-l>"] = "preview_scrolling_down",
                    }
                },
            },
            pickers = {
                -- Default configuration for builtin pickers goes here:
                -- picker_name = {
                --   picker_config_key = value,
                --   ...
                -- }
                find_files = {
                    -- theme = "ivy",
                    find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                },
                -- Now the picker_config_key will be applied every time you call this
                -- builtin picker
            },
            extensions = {
                -- Your extension configuration goes here:
                -- extension_name = {
                --   extension_config_key = value,
                -- }
                -- please take a look at the readme of the extension you want to configure
            }
        }
    end,
}
