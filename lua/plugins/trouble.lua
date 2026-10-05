-- =============================================================================
-- Diagnostics Buffer (Emacs-like: compilation-mode error list)
-- =============================================================================
-- trouble.nvim gives you a structured, interactive diagnostics list in a buffer.
-- Toggle with <leader>xx, see workspace diagnostics with <leader>xw,
-- document diagnostics with <leader>xd, or the quickfix list with <leader>xq.

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