-- Entry point. Loads options, keymaps, autocmds, then plugins via lazy.nvim.
--
-- File layout:
--   lua/options.lua        Editor settings
--   lua/keymaps.lua        Global keybindings
--   lua/autocmds.lua       Autocommands
--   lua/local.lua          Machine-specific overrides (gitignored, optional)
--   lua/plugins/init.lua   Plugin index

require('options')
require('keymaps')
require('autocmds')

-- Machine-specific overrides. Copy lua/local.lua.example to lua/local.lua.
pcall(require, 'local')

-- Bootstrap lazy.nvim on first run.
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
	local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error('Error cloning lazy.nvim:\n' .. out)
	end
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup(require('plugins'), {
	ui = {
		icons = {
			cmd = '',
			config = '',
			event = '',
			ft = '',
			init = '',
			keys = '',
			plugin = '',
			runtime = '',
			require = '',
			source = '',
			start = '',
			task = '',
			lazy = '',
		},
	},
})