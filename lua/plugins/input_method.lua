return {
  {
    "keaising/im-select.nvim",
    lazy = true,
    event = "InsertEnter",
    config = function()
      require('im_select').setup({
        -- IM will be set to `default_im_select` in `normal` mode
        -- For Windows/WSL, default: "1033", aka: English US Keyboard
        -- For macOS, default: "com.apple.keylayout.ABC", aka: US
        -- For Linux, default:
        --               "keyboard-us" for Fcitx5
        --               "1" for Fcitx
        --               "xkb:us::eng" for ibus
        -- You can use `im-select` or `fcitx5-remote -n` to get the IM's name
        default_im_select       = ENV.im_select.default_im_select,

        -- Can be binary's name or binary's full path,
        -- e.g. 'im-select' or '/usr/local/bin/im-select'
        -- For Windows/WSL, default: "im-select.exe"
        -- For macOS, default: "im-select"
        -- For Linux, default: "fcitx5-remote" or "fcitx-remote" or "ibus"
        default_command         = ENV.im_select.default_command,

        -- Restore the default input method state when the following events are triggered
        set_default_events      = { "VimEnter", "FocusGained", "InsertLeave", "CmdlineLeave" },

        -- Restore the previous used input method state when the following events
        -- are triggered, if you don't want to restore previous used im in Insert mode,
        -- e.g. deprecated `disable_auto_restore = 1`, just let it empty
        -- as `set_previous_events = {}`
        set_previous_events     = { "InsertEnter" },

        -- Show notification about how to install executable binary when binary missed
        keep_quiet_on_no_binary = false,

        -- Async run `default_command` to switch IM or not
        async_switch_im         = true
      })
    end,
  },
  {
    "liubianshi/cmp-lsp-rimels",
    -- keys = { { ";f", mode = "i" } },
    lazy = true;
    event = "InsertEnter",
    config = function()

      local detector_for_norg = function(info)
        info = info or vim.inspect_pos()
        local trees = info.treesitter
        local extmarks = info.extmarks
        local englist_env = false
        for _, ts in ipairs(trees) do
          if
              ts.capture == "neorg.markup.variable"
              or ts.capture == "neorg.markup.verbatim"
              or ts.capture == "neorg.markup.inline_math"
          then
            return true
          elseif ts.capture == "comment" then
            return false
          end
        end
        for _, ext in ipairs(extmarks) do
          if
              ext.opts
              and ext.opts.hl_group == "@neorg.tags.ranged_verbatim.code_block"
          then
            return true
          end
        end
        return englist_env
      end

      vim.system({ 'rime_ls', '--listen', '127.0.0.1:9257' })
      require('rimels').setup(
        {
          keys = { start = ";f", stop = ";;", esc = ";j", undo = ";u" },
          cmd = vim.lsp.rpc.connect("127.0.0.1", 9257),
          shared_data_dir = ENV.rime_shared_data_dir,
          -- schema_trigger_character = "&", -- [since v0.2.0] 当输入此字符串时请求补全会触发 “方案选单”
          schema_trigger_character = "&", -- [since v0.2.0] 当输入此字符串时请求补全会触发 “方案选单”
          detectors = {
            with_treesitter = {
              norg = detector_for_norg,
            },
          },
        }
      )
    end,
  }
}
