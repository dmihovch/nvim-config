-- Editor options. See :help option-list.

local opt = vim.opt
local o = vim.o

-- Disable netrw. oil.nvim replaces it.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Leader keys. Must be set before plugins load.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Line numbers.
o.number = true
o.relativenumber = true

-- Mode display. lualine handles this.
o.showmode = false

-- System clipboard. Scheduled after UiEnter to avoid startup delay.
vim.schedule(function()
	o.clipboard = 'unnamedplus'
end)

-- Indentation. guess-indent.nvim overrides these per-buffer.
opt.expandtab = false
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4

-- Search.
o.ignorecase = true
o.smartcase = true

-- Editing.
o.breakindent = true
o.undofile = true
o.confirm = true
o.inccommand = 'split'

-- UI.
o.signcolumn = 'yes'
o.cursorline = true
o.scrolloff = 10
o.list = true
opt.listchars = { tab = '> ', trail = '.', nbsp = '+' }
opt.termguicolors = true
o.splitright = true
o.splitbelow = true

-- Block cursor in all modes.
o.guicursor = 'n-v-c-sm:block,i-ci-ve:block,r-cr-o:block'

-- Responsiveness.
o.updatetime = 250
o.timeoutlen = 300

-- Folding via treesitter.
o.foldmethod = 'expr'
o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
o.foldenable = false
o.foldlevel = 99

-- Command-line completion. Tab on :e, :cd, etc. autocompletes paths.
o.wildmenu = true
opt.wildmode = 'longest:full,full'
opt.wildignore = '*.o,*.obj,*.pyc,*.class,*.DS_Store'