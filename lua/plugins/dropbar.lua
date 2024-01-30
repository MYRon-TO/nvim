M = {
  'Bekaboo/dropbar.nvim',
  lazy = false,
  dependencies = {
    -- optional, but required for fuzzy finder support
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-tree/nvim-web-devicons' },
  },
  config = function()
    local api = require('dropbar.api')
    -- local utils = require('dropbar.utils')
    --
    vim.keymap.set('n', '<leader>b', api.pick)

    require('dropbar').setup(
      {
        menu = {
          ---@type table<string, string|function|table<string, string|function>>
          keymaps = {
            ['q'] = '<C-w>q',
            ['<Esc>'] = '<C-w>q',
            ['<LeftMouse>'] = function()
              local menu = utils.menu.get_current()
              if not menu then
                return
              end
              local mouse = vim.fn.getmousepos()
              local clicked_menu = utils.menu.get({ win = mouse.winid })
              -- If clicked on a menu, invoke the corresponding click action,
              -- else close all menus and set the cursor to the clicked window
              if clicked_menu then
                clicked_menu:click_at({ mouse.line, mouse.column - 1 }, nil, 1, 'l')
                return
              end
              utils.menu.exec('close')
              utils.bar.exec('update_current_context_hl')
              if vim.api.nvim_win_is_valid(mouse.winid) then
                vim.api.nvim_set_current_win(mouse.winid)
              end
            end,
            ['<CR>'] = function()
              local menu = utils.menu.get_current()
              if not menu then
                return
              end
              local cursor = vim.api.nvim_win_get_cursor(menu.win)
              local component = menu.entries[cursor[1]]:first_clickable(cursor[2])
              if component then
                menu:click_on(component, nil, 1, 'l')
              end
            end,
            ['<MouseMove>'] = function()
              local menu = utils.menu.get_current()
              if not menu then
                return
              end
              local mouse = vim.fn.getmousepos()
              utils.menu.update_hover_hl(mouse)
              if M.opts.menu.preview then
                utils.menu.update_preview(mouse)
              end
            end,
            ['i'] = function()
              local menu = utils.menu.get_current()
              if not menu then
                return
              end
              menu:fuzzy_find_open()
            end,
            ['o'] = function ()
              goto_context_start()
            end
          },
          sources = {
            terminal = {
              name = function(buf)
                local name = vim.api.nvim_buf_get_name(buf)
                -- the second result val is the terminal object
                local term = select(2, require("toggleterm.terminal").indentify(name))
                if term then
                  return term.display_name or term.name
                else
                  return name
                end
              end,
            },
          },
        }
      }
    )
  end
}

return M
