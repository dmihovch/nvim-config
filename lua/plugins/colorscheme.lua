-- Colorscheme.
--
-- To change:
--   1. Replace the repo URL.
--   2. Change the colorscheme command in config().
--   3. Restart Neovim.
--
-- Alternatives:
--   'catppuccin/nvim'           -> vim.cmd.colorscheme 'catppuccin-mocha'
--   'folke/tokyonight.nvim'     -> vim.cmd.colorscheme 'tokyonight'
--   'EdenEast/nightfox.nvim'    -> vim.cmd.colorscheme 'carbonfox'
--   'rebelot/kanagawa.nvim'     -> vim.cmd.colorscheme 'kanagawa'
--   'rose-pine/neovim'          -> vim.cmd.colorscheme 'rose-pine'

return {
	{
		'olimorris/onedarkpro.nvim',
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme('onedark_dark')
		end,
	},
}