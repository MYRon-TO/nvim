local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = false }
local opts_si = { noremap = true, silent = true }


-- Leader key
vim.g.mapleader = ' '

-- useful
map('n', 'c<space>', 'o<Esc>', opts)
map('n', 'cd', '0D', opts)
map('n', 'cnh', ':nohl<CR>', opts_si)
-- map('n', 'cfm', ':lua vim.lsp.buf.format({async = false })<CR>', opts)

-- quick move
vim.keymap.set({ "n", "v", "x", }, '<c-j>', '10j', opts)
vim.keymap.set({ "n", "v", "x", }, '<c-k>', '10k', opts)
vim.keymap.set({ "n", "v", "x", }, '<c-h>', '10h', opts)
vim.keymap.set({ "n", "v", "x", }, '<c-l>', '10l', opts)

-- split window
map('n', '<c-w>sh', ':set nosplitright<CR>:vsplit<CR>', opts_si)
map('n', '<c-w>sl', ':set splitright<CR>:vsplit<CR>', opts_si)
map('n', '<c-w>sj', ':set splitbelow<CR>:split<CR>', opts_si)
map('n', '<c-w>sk', ':set nosplitright<CR>:split<CR>', opts_si)
-- map('n', '<c-w>h', '<C-w>h', opts_si)
-- map('n', '<c-w>l', '<C-w>l', opts_si)
-- map('n', '<c-w>j', '<C-w>j', opts_si)
-- map('n', '<c-w>k', '<C-w>k', opts_si)
map('n', '<c-w><left>', ':vertical resize-5<CR>', opts_si)
map('n', '<c-w><right>', ':vertical resize+5<CR>', opts_si)
map('n', '<c-w><down>', ':res +5<CR>', opts_si)
map('n', '<c-w><up>', ':res -5<CR>', opts_si)

-- tab
map('n', '<c-w>t', ':tabe<CR>', opts_si)
map('n', '<c-w>J', ':-tabnext<CR>', opts_si)
map('n', '<c-w>K', ':+tabnext<CR>', opts_si)
map('n', '<c-w>H', ':-tabmove<CR>', opts_si)
map('n', '<c-w>L', ':+tabmove<CR>', opts_si)

-- buffer
-- map('n', '<LEADER>F', ':bfirst<CR>', opts_si)
-- map('n', '<LEADER>B', ':blast<CR>', opts_si)

-- stay in visual mode after indent
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)

-- stay in visual mode after + and -
map('v', '<c-a>', '<c-a>gv', opts)
map('v', '<c-x>', '<c-x>gv', opts)

-- move selected line / block of text in visual mode
map('v', 'J', ":m '>+1<CR>gv=gv", opts)
map('v', 'K', ":m '<-2<CR>gv=gv", opts)
map('x', 'J', ":m '>+1<CR>gv=gv", opts)
map('x', 'K', ":m '<-2<CR>gv=gv", opts)

-- copy to clipboard
map('v', 'y', '"+y', opts)

map('i', '<c-space>', '<c-space>', opts_si)
