-- =============================================================================
-- Entry Point
-- =============================================================================
-- This file is the first thing Neovim loads from this config.
-- It sets up core options, keymaps, and autocmds, then hands off to
-- lazy.nvim for plugin management.
--
-- File structure:
--   lua/options.lua     → Editor settings (tabs, search, UI, etc.)
--   lua/keymaps.lua     → Global keybindings
--   lua/autocmds.lua    → Autocommands (yank highlight, cursor restore, etc.)
--   lua/local.lua       → Machine-specific overrides (gitignored, optional)
--   lua/plugins/init.lua → Plugin index (imports all plugin spec files)
-- =============================================================================

-- ---- Core Configuration ----
require('options')
require('keymaps')
require('autocmds')

-- ---- Machine-Specific Overrides ----
-- Copy lua/local.lua.example → lua/local.lua and add your overrides there.
-- This file is gitignored, so it won't be shared across machines.
local local_ok, _ = pcall(require, 'local')
if not local_ok then
	-- No local.lua found — that's fine, everything works without it.
end

-- ---- Plugin Manager Bootstrap ----
-- lazy.nvim is installed automatically on first run.
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
	local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error('Error cloning lazy.nvim:\n' .. out)
	end
end

vim.opt.rtp:prepend(lazypath)

-- ---- Plugin Setup ----
-- All plugin specs are imported from lua/plugins/init.lua.
require('lazy').setup(require('plugins'), {
	ui = {
		icons = {
			cmd = '⌘',
			config = '🛠',
			event = '📅',
			ft = '📂',
			init = '⚙',
			keys = '🗝',
			plugin = '🔌',
			runtime = '💻',
			require = '🌙',
			source = '📄',
			start = '🚀',
			task = '📌',
			lazy = '💤 ',
		},
	},
})