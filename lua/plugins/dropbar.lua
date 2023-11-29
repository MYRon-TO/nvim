return {
  'Bekaboo/dropbar.nvim',
  lazy = false,
  dependencies = {
    -- optional, but required for fuzzy finder support
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  },
  config = function()
    local api = require('dropbar.api')
    local utils = require('dropbar.utils')
    vim.keymap.set('n', '<leader>b', api.pick)
    require('dropbar').setup({
      menu = {
        -- When on, preview the symbol under the cursor on CursorMoved
        preview = true,
        -- When on, automatically set the cursor to the closest previous/next
        -- clickable component in the direction of cursor movement on CursorMoved
        quick_navigation = true,
        entry = {
          padding = {
            left = 1,
            right = 1,
          },
        },
        ---@type table<string, string|function|table<string, string|function>>
        keymaps = {
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
          ['<esc>'] = function()
            local menu = utils.menu.get_current()
            if menu then
              menu:close()
            end
          end
        },
        ---@alias dropbar_menu_win_config_opts_t any|fun(menu: dropbar_menu_t):any
        ---@type table<string, dropbar_menu_win_config_opts_t>
        ---@see vim.api.nvim_open_win
        win_configs = {
          border = 'none',
          style = 'minimal',
          row = function(menu)
            return menu.prev_menu
                and menu.prev_menu.clicked_at
                and menu.prev_menu.clicked_at[1] - vim.fn.line('w0')
                or 0
          end,
          ---@param menu dropbar_menu_t
          col = function(menu)
            if menu.prev_menu then
              return menu.prev_menu._win_configs.width
                  + (menu.prev_menu.scrollbar and 1 or 0)
            end
            local mouse = vim.fn.getmousepos()
            local bar = utils.bar.get({ win = menu.prev_win })
            if not bar then
              return mouse.wincol
            end
            local _, range = bar:get_component_at(math.max(0, mouse.wincol - 1))
            return range and range.start or mouse.wincol
          end,
          relative = 'win',
          win = function(menu)
            return menu.prev_menu and menu.prev_menu.win
                or vim.fn.getmousepos().winid
          end,
          height = function(menu)
            return math.max(
              1,
              math.min(
                #menu.entries,
                vim.go.pumheight ~= 0 and vim.go.pumheight
                or math.ceil(vim.go.lines / 4)
              )
            )
          end,
          width = function(menu)
            local min_width = vim.go.pumwidth ~= 0 and vim.go.pumwidth or 8
            if vim.tbl_isempty(menu.entries) then
              return min_width
            end
            return math.max(
              min_width,
              math.max(unpack(vim.tbl_map(function(entry)
                return entry:displaywidth()
              end, menu.entries)))
            )
          end,
        },
      },
      fzf = {
        ---@type table<string, string | fun()>
        keymaps = {
          ['<Esc>'] = function()
            api.fuzzy_find_toggle()
          end,
          ['<Enter>'] = function()
            api.fuzzy_find_click()
          end,
          ['<S-Enter>'] = function()
            api.fuzzy_find_click(-1)
          end,
          ['<Up>'] = function()
            api.fuzzy_find_navigate('up')
          end,
          ['<Down>'] = function()
            api.fuzzy_find_navigate('down')
          end,
          ['<C-k>'] = function()
            api.fuzzy_find_navigate('up')
          end,
          ['<C-j>'] = function()
            api.fuzzy_find_navigate('down')
          end,
        },
        win_configs = {},
        prompt = '%#htmlTag# ',
        char_pattern = '[%w%p]',
        retain_inner_spaces = true,
        fuzzy_find_on_click = true,
      },
      sources = {
        terminal = {
          ---@type string|fun(buf: integer): string
          icon = function(buf)
            local icon = M.opts.icons.kinds.symbols.Terminal
            if M.opts.icons.kinds.use_devicons then
              icon = require('nvim-web-devicons').get_icon_by_filetype(
                vim.bo[buf].filetype
              ) or icon
            end
            return icon
          end,
          ---@type string|fun(buf: integer): string
          name = vim.api.nvim_buf_get_name,
          ---@type boolean
          ---Show the current terminal buffer in the menu
          show_current = true,
        },
      },
    })
  end,
}
