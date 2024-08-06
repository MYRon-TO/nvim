return {
  -- {
  --   'dhruvasagar/vim-table-mode',
  --   lazy = true,
  --   config = function()
  --     vim.cmd [[
  --               function! s:isAtStartOfLine(mapping)
  --                   let text_before_cursor = getline('.')[0 : col('.')-1]
  --                   let mapping_pattern = '\V' . escape(a:mapping, '\')
  --                   let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  --                   return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
  --               endfunction
  --               inoreabbrev <expr> <bar><bar>
  --                   \ <SID>isAtStartOfLine('\|\|') ?
  --                   \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
  --               inoreabbrev <expr> __
  --                   \ <SID>isAtStartOfLine('__') ?
  --                   \ '<c-o>:silent! TableModeDisable<cr>' : '__'
  --           ]]
  --   end,
  --   keys = {
  --     { '<leader>tm', ':TableModeToggle<cr>', 'n' },
  --   },
  --   ft = { "markdown", "txt" },
  -- },
  --
  -- {
  --   "Kicamon/markdown-table-mode.nvim",
  --   lazy = true,
  --   ft = "markdown",
  -- },
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
    'Kicamon/markdown-table-mode.nvim',
    config = function()
      require('markdown-table-mode').setup()
    end
  },
  -- {
  --   "bullets-vim/bullets.vim",
  --   lazy = true,
  --   ft = { "markdown", "txt" },
  --   config = function()
  --     vim.cmd [[
  --       let g:bullets_set_mappings = 0

  --       " \ ['inoremap', '<cr>', '<cr>'],
  --       let g:bullets_custom_mappings = [
  --         \ ['imap', '<cr>', '<Plug>(bullets-newline)'],
  --         \ ['inoremap', '<C-cr>', '<cr>'],
  --         \
  --         \ ['nmap', 'o', '<Plug>(bullets-newline)'],
  --         \
  --         \ ['vmap', 'gN', '<Plug>(bullets-renumber)'],
  --         \ ['nmap', 'gN', '<Plug>(bullets-renumber)'],
  --         \
  --         \ ['imap', '<C-t>', '<Plug>(bullets-demote)'],
  --         \ ['nmap', '>>', '<Plug>(bullets-demote)'],
  --         \ ['vmap', '>', '<Plug>(bullets-demote)'],
  --         \ ['imap', '<C-d>', '<Plug>(bullets-promote)'],
  --         \ ['nmap', '<<', '<Plug>(bullets-promote)'],
  --         \ ['vmap', '<', '<Plug>(bullets-promote)'],
  --         \ ]
  --     ]]
  --   end,
  -- },
}
