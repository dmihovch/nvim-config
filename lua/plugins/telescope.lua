-- Fuzzy finder.

return {
	{
		'nvim-telescope/telescope.nvim',
		event = 'VimEnter',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				-- `build` runs once on install/update, not on every startup.
				build = 'make',
				cond = function()
					return vim.fn.executable 'make' == 1
				end,
			},
			'nvim-telescope/telescope-ui-select.nvim',
		},
		config = function()
			require('telescope').setup {}

			local builtin = require 'telescope.builtin'
			vim.keymap.set('n', '<leader>ff', builtin.find_files)
			vim.keymap.set('n', '<leader>fg', builtin.live_grep)
			vim.keymap.set('n', '<leader>fb', builtin.buffers)
		end,
	},
}
