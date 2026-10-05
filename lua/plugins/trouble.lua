-- Diagnostics list in a buffer via trouble.nvim.
--
--   <leader>xx  toggle diagnostics
--   <leader>xw  document diagnostics
--   <leader>xq  quickfix list
--   <leader>xl  location list

return {
	{
		'folke/trouble.nvim',
		cmd = { 'Trouble' },
		keys = {
			{ '<leader>xx', '<cmd>Trouble diagnostics toggle<CR>', desc = 'Diagnostics (buffer)' },
			{ '<leader>xw', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>', desc = 'Diagnostics (document)' },
			{ '<leader>xq', '<cmd>Trouble qflist toggle<CR>', desc = 'Quickfix list' },
			{ '<leader>xl', '<cmd>Trouble loclist toggle<CR>', desc = 'Location list' },
		},
		opts = {
			focus = true,
			win = { position = 'bottom', size = 0.3 },
		},
	},
}