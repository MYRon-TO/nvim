return {
    {
        'git@github.com:toppair/peek.nvim',
        -- 'git@github.com:cloudsftp/peek.nvim',
        -- branch = 'bundle',
        build = 'deno task --quiet build:fast',
        lazy = true,
        ft = { "markdown" },
        config = function()
            -- default config:
            require('peek').setup({
                -- whether to automatically load preview when entering another markdown buffer
                auto_load = true,
                -- close preview window on buffer delete
                close_on_bdelete = true,
                -- enable syntax highlighting, affects performance
                syntax = true,

                theme = 'dark',           -- 'dark' or 'light'

                update_on_change = true,

                -- 'webview', 'browser', string or a table of strings explained below
                -- app = {'brower', '--new-window'},
                 app = {'webview'},
                -- list of filetypes to recognize as markdown
                filetype = { 'markdown', 'html' },

                -- relevant if update_on_change is true
                -- start throttling when file exceeds this amount of bytes in size
                throttle_at = 200000,
                -- minimum amount of time in milliseconds that has to pass before starting new render
                throttle_time = 'auto',
            })
                -- local peek = require('peek')
                vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
                vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
        end,
    },
    {
        "Zeioth/markmap.nvim",
        build = "yarn global add markmap-cli",
        cmd = {"MarkmapOpen", "MarkmapSave", "MarkmapWatch", "MarkmapWatchStop"},
        opts = {
          html_output = "/tmp/markmap.html", -- (default) Setting a empty string "" here means: [Current buffer path].html
          hide_toolbar = false, -- (default)
          grace_period = 3600000 -- (default) Stops markmap watch after 60 minutes. Set it to 0 to disable the grace_period.
        },
        config = function(_, opts) require("markmap").setup(opts) end
    },
}

