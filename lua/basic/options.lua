local opt = vim.opt

opt.backup         = false         -- no backup file
opt.swapfile       = false         -- no swap file
opt.undofile       = true          -- enable undo

opt.conceallevel   = 0             -- so that `` is visible in markdown files

opt.mouse          = "a"           -- enable mouse support
opt.fileencoding   = "utf-8"       -- the encoding written to a file
opt.clipboard      = "unnamedplus" -- use system clipboard
opt.cursorline     = true
opt.number         = true
opt.relativenumber = true

opt.hlsearch       = true          -- highlight all matches on previous search pattern
opt.ignorecase     = true          -- ignore case in search patterns
opt.smartcase      = true          -- override the 'ignorecase' option if the search pattern contains upper case characters

opt.showmode       = true          -- show current mode
opt.showcmd        = true          -- show (partial) command in status line
opt.cmdheight      = 1             -- height of the command bar
opt.showtabline    = 2             -- always show tabs

opt.smartindent    = true          -- insert indents automatically


opt.termguicolors  = true          -- true color support

opt.timeoutlen     = 500           -- time to wait for a mapped sequence to complete (in milliseconds)
opt.updatetime     = 300
--opt.writebackup

opt.expandtab      = true
opt.tabstop        = 4
opt.shiftwidth     = 4

opt.signcolumn     = "yes"

opt.wrap           = true
opt.linebreak      = true

opt.list           = true
opt.listchars      = {
    tab = ">-",
    trail = "·",
    extends = "…",
    precedes = "…",
    nbsp = "␣",
}

-- 复制后高亮
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	pattern = { "*" },
	callback = function()
		vim.highlight.on_yank({
			timeout = 300,
		})
	end,
})

opt.syntax = 'on'
--opt.compatible = false

--opt.termguicolors = true
--opt.tabstop = 4
--opt.shiftwidth = 4
--opt.expandtab = true
---- opt.sorfttabstop = 4

--opt.list = true
--opt.listchars = {
    --tab = '▸ ',
    --trail = '·',
    --extends = '…',
    --precedes = '…',
    --nbsp = '␣',
--}

---- mouse
--opt.mouse = 'a'

--opt.wrap = true
--opt.linebreak = true

--opt.clipboard = 'unnamedplus'

--opt.backspace=indent,eol,start
--opt.autochdir = true

--opt.encoding = 'utf-8'
--opt.nocompatible = true

--opt.showcmd = true
--opt.showmatch = true

--opt.wildmenu = true
--opt.wildmode = 'list:longest,full'

--opt.hlsearch = true
--opt.incsearch = true
--opt.smartcase = true

--opt.foldmethod = 'indent'
--opt.foldlevel = 99

----vim.bo.filetype = 'on'
----vim.bo.filetype.indent = true
----vim.bo.filetype.plugin = true

--vim.o.t_ut = ''

