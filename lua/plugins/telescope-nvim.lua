return {
    'nvim-telescope/telescope.nvim',
    -- tag = '0.1.3',
    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    lazy = true,
    keys = {
        { '<leader>ff' },
        { '<leader>fg' },
        { '<leader>fb' },
        { '<leader>fh' },
    },

    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.git_files, {})
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

        require('telescope').setup {
            defaults = {
                -- Default configuration for telescope goes here:
                -- config_key = value,
                mappings = {
                    i = {
                        -- map actions.which_key to <C-h> (default: <C-/>)
                        -- actions.which_key shows the mappings for your picker,
                        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                        ["<c-j>"] = require('telescope.actions').move_selection_next,
                        ["<c-k>"] = require('telescope.actions').move_selection_previous,
                        ["<esc>"] = require('telescope.actions').close,
                        ["<cr>"] = require('telescope.actions').select_default + require('telescope.actions').center,
                    }
                }
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
    end
}
