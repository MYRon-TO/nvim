return {
  {
    'dhruvasagar/vim-table-mode',
    lazy = true,
    config = function()
      vim.cmd [[
                function! s:isAtStartOfLine(mapping)
                    let text_before_cursor = getline('.')[0 : col('.')-1]
                    let mapping_pattern = '\V' . escape(a:mapping, '\')
                    let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
                    return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
                endfunction
                inoreabbrev <expr> <bar><bar>
                    \ <SID>isAtStartOfLine('\|\|') ?
                    \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
                inoreabbrev <expr> __
                    \ <SID>isAtStartOfLine('__') ?
                    \ '<c-o>:silent! TableModeDisable<cr>' : '__'
            ]]
    end,
    keys = {
      { '<leader>tm', ':TableModeToggle<cr>', 'n' },
    },
    ft = { "markdown", "txt" },
  },
  {
    "iamcco/markdown-preview.nvim",
    lazy = true,
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    "bullets-vim/bullets.vim",
    lazy = true,
    ft = { "markdown", "txt" },
    config = function()
      vim.cmd [[
        let g:bullets_set_mappings = 0

        " \ ['inoremap', '<cr>', '<cr>'],
        let g:bullets_custom_mappings = [
          \ ['imap', '<cr>', '<Plug>(bullets-newline)'],
          \ ['inoremap', '<C-cr>', '<cr>'],
          \
          \ ['nmap', 'o', '<Plug>(bullets-newline)'],
          \
          \ ['vmap', 'gN', '<Plug>(bullets-renumber)'],
          \ ['nmap', 'gN', '<Plug>(bullets-renumber)'],
          \
          \ ['imap', '<C-t>', '<Plug>(bullets-demote)'],
          \ ['nmap', '>>', '<Plug>(bullets-demote)'],
          \ ['vmap', '>', '<Plug>(bullets-demote)'],
          \ ['imap', '<C-d>', '<Plug>(bullets-promote)'],
          \ ['nmap', '<<', '<Plug>(bullets-promote)'],
          \ ['vmap', '<', '<Plug>(bullets-promote)'],
          \ ]
      ]]
    end,
  },
  -- {
  --     "instant-markdown/vim-instant-markdown",
  --     ft = { "markdown" },
  --     build = "yarn install",
  --     config = function()

  --         vim.cmd("set shell=bash\\ -i")
  --         -- Uncomment to override defaults:
  --         vim.g.instant_markdown_slow = 1
  --         vim.g.instant_markdown_autostart = 0
  --         vim.g.instant_markdown_open_to_the_world = 1
  --         vim.g.instant_markdown_allow_unsafe_content = 1
  --         vim.g.instant_markdown_allow_external_content = 0
  --         vim.g.instant_markdown_mathjax = 1
  --         vim.g.instant_markdown_mermaid = 1
  --         vim.g.instant_markdown_logfile = '/tmp/instant_markdown.log'
  --         vim.g.instant_markdown_autoscroll = 0
  --         vim.g.instant_markdown_port = 8090
  --         vim.g.instant_markdown_python = 1
  --         vim.g.instant_markdown_theme = 'dark'
  --     end,
  -- },
}
