-- =============================================================================
-- Colorscheme
-- =============================================================================
-- To change the colorscheme:
--   1. Replace 'olimorris/onedarkpro.nvim' with your preferred colorscheme repo
--   2. Change the colorscheme command in config()
--   3. Restart Neovim — lazy.nvim cleans up the old plugin automatically
--
-- Popular alternatives:
--   'catppuccin/nvim'              → vim.cmd.colorscheme 'catppuccin-mocha'
--   'folke/tokyonight.nvim'        → vim.cmd.colorscheme 'tokyonight'
--   'EdenEast/nightfox.nvim'       → vim.cmd.colorscheme 'carbonfox'
--   'rebelot/kanagawa.nvim'        → vim.cmd.colorscheme 'kanagawa'
--   'rose-pine/neovim'             → vim.cmd.colorscheme 'rose-pine'
-- =============================================================================

return {
	{
		'olimorris/onedarkpro.nvim',
		lazy = false, -- load immediately (before UI renders)
		priority = 1000, -- load before other plugins
		config = function()
			vim.cmd.colorscheme('onedark_dark')
		end,
	},
}