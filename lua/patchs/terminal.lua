local map = vim.api.nvim_set_keymap
local opts_si = { noremap = true, silent = true }

map ('n', '<leader>tt', ':tabe<CR>:term<CR>', opts_si)
map ('n', '<leader>th', ':set nosplitright<CR>:vsplit<CR>:term<CR>i', opts_si)
map ('n', '<leader>tl', ':set splitright<CR>:vsplit<CR>:term<CR>i', opts_si)
map ('n', '<leader>tj', ':set splitbelow<CR>:split<CR>:term<CR>i', opts_si)
map ('n', '<leader>tk', ':set nosplitright<CR>:split<CR>:term<CR>i', opts_si)
