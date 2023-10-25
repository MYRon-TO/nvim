return{
    'akinsho/flutter-tools.nvim',
    lazy = true,
    ft = {'dart'},
    dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = function ()
        -- alternatively you can override the default configs
        require("flutter-tools").setup {
          widget_guides = {
            enabled = false,
          },
          dev_tools = {
            autostart = false, -- autostart devtools server if not detected
            auto_open_browser = false, -- Automatically opens devtools in the browser
          },
          lsp = {
            color = { -- show the derived colours for dart variables
              enabled = false, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
              background = false, -- highlight the background
              background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
              foreground = false, -- highlight the foreground
              virtual_text = true, -- show the highlight using virtual text
              virtual_text_str = "■", -- the virtual text character to highlight
            },
          }
        }
    end,
}
