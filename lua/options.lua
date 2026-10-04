-- Editor options. See `:help option-list` for the full list.

local opt = vim.opt
local o = vim.o

-- Disable netrw; oil.nvim is our file explorer.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Leader keys (must be set before plugins load).
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Line numbers and status.
o.number = true
o.relativenumber = true
o.showmode = true

-- Sync the OS clipboard. Scheduled after UiEnter to avoid slowing startup.
-- Remove this if you want the OS clipboard to stay independent.
vim.schedule(function()
	o.clipboard = 'unnamedplus'
end)

-- Indentation: keep real tabs, 4 columns wide.
opt.expandtab = false -- keep real tabs
opt.tabstop = 4 -- visual width of a tab
opt.shiftwidth = 4 -- indent level = 1 tab
opt.softtabstop = 4 -- <Tab> inserts one tab

-- Search.
o.ignorecase = true
o.smartcase = true

-- Editing behaviour.
o.breakindent = true
o.undofile = true
o.confirm = true
o.inccommand = 'split'

-- UI.
o.signcolumn = 'yes'
o.cursorline = true
o.scrolloff = 10
o.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
opt.termguicolors = true
o.splitright = true
o.splitbelow = true

-- Keep a solid block cursor in every mode (no skinny insert-mode bar).
o.guicursor = 'n-v-c-sm:block,i-ci-ve:block,r-cr-o:block'

-- Faster feedback.
o.updatetime = 250
o.timeoutlen = 300
