-- Interactive find and replace via grug-far.nvim.
-- <leader>sr opens a search-and-replace buffer.

return {
	{
		'MagicDuck/grug-far.nvim',
		cmd = 'GrugFar',
		keys = {
			{ '<leader>sr', '<cmd>GrugFar<CR>', desc = 'Search and replace' },
		},
		opts = {
			engines = {
				regex = 'ripgrep',
			},
		},
	},
}