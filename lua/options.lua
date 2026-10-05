-- =============================================================================
-- Editor Options
-- =============================================================================
-- See `:help option-list` for the full list of available options.
--
-- To override any of these on a specific machine, copy
-- lua/local.lua.example → lua/local.lua and add your overrides there.
-- =============================================================================

local opt = vim.opt
local o = vim.o

-- ---- File Explorer ----
-- Disable netrw; oil.nvim replaces it with a dired-like buffer.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- ---- Leader Keys ----
-- Must be set before any plugin loads. Space is the leader.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- ---- Line Numbers ----
o.number = true -- absolute line number on current line
o.relativenumber = true -- relative line numbers everywhere else

-- ---- Mode Display ----
-- Show -- INSERT -- / -- VISUAL -- etc. in the statusline.
o.showmode = false -- lualine handles this; set false to avoid duplication

-- ---- System Clipboard ----
-- Sync Neovim's clipboard with the OS clipboard.
-- Scheduled after UiEnter to avoid slowing down startup.
vim.schedule(function()
	o.clipboard = 'unnamedplus'
end)

-- ---- Indentation ----
-- Default: real tabs, 4 columns wide.
-- guess-indent.nvim will override these per-buffer when it detects a
-- different style (e.g., spaces in a Python file).
opt.expandtab = false -- use real tabs by default
opt.tabstop = 4 -- visual width of a tab character
opt.shiftwidth = 4 -- number of spaces for each indent step
opt.softtabstop = 4 -- <Tab> key inserts this many spaces (or 1 tab)

-- ---- Search ----
o.ignorecase = true -- case-insensitive search…
o.smartcase = true -- …unless you type an uppercase letter

-- ---- Editing Behaviour ----
o.breakindent = true -- wrapped lines preserve indentation
o.undofile = true -- persistent undo (survives closing the file)
o.confirm = true -- confirm before closing unsaved buffers
o.inccommand = 'split' -- live preview of :substitute commands

-- ---- UI ----
o.signcolumn = 'yes' -- always show the sign column (avoids layout shifts)
o.cursorline = true -- highlight the current line
o.scrolloff = 10 -- keep 10 lines of context above/below cursor
o.list = true -- show invisible characters
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
opt.termguicolors = true -- enable 24-bit color (most terminals support this)
o.splitright = true -- new vertical splits open on the right
o.splitbelow = true -- new horizontal splits open below

-- ---- Cursor ----
-- Keep a solid block cursor in every mode (no skinny insert-mode bar).
o.guicursor = 'n-v-c-sm:block,i-ci-ve:block,r-cr-o:block'

-- ---- Responsiveness ----
o.updatetime = 250 -- faster CursorHold trigger (for LSP highlights)
o.timeoutlen = 300 -- faster which-key popup

-- ---- Folding ----
o.foldmethod = 'expr'
o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
o.foldenable = false -- start with all folds open
o.foldlevel = 99

-- ---- Command-Line Completion (Emacs-like minibuffer) ----
-- When you type :e , :cd , etc. and press Tab, you get a wildmenu
-- at the bottom that autocompletes paths through the filesystem.
o.wildmenu = true
opt.wildmode = 'longest:full,full' -- complete longest common, then cycle
opt.wildignore = '*.o,*.obj,*.pyc,*.class,*.DS_Store' -- hide junk