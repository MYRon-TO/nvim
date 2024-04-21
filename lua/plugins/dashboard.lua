local M = {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  opts = function()

    local logo = [[
███╗   ██╗███████╗ ██████╗     ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗    ██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║    ██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║    ╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝     ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝       ╚═══╝  ╚═╝╚═╝     ╚═╝
                                                      
      ]]
    logo = string.rep("\n", 8) .. logo .. "\n\n"

    local opts = {
      theme = "doom",
      config = {
        header = vim.split(logo, "\n"),
        center = {
          -- { action = 'Yazi',                      desc = " Open File",       icon = " ", key = "y", key_format = " %s" },
          { action = 'ene',                       desc = " New File",        icon = " ", key = "n", key_format = " %s" },
          { action = 'Telescope oldfiles',        desc = " Recent Files",    icon = " ", key = "r", key_format = " %s" },
          { action = 'e ~/.config/nvim/init.lua', desc = " Config",          icon = " ", key = "c", key_format = " %s" },
          -- { action = '',                          desc = " Restore Session", icon = " ", key = "s", key_format = " %s" },
          { action = 'Lazy',                      desc = " Lazy",            icon = "󰒲 ", key = "l", key_format = " %s" },
          { action = 'qa',                        desc = " Quit",            icon = " ", key = "q", key_format = " %s" },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
        end,
      },
    }

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
      button.key_format = "  %s"
    end

    return opts
  end,
}

return M
