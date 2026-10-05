-- =============================================================================
-- Terminal Integration (Emacs-like: eshell / ansi-term)
-- =============================================================================
-- toggleterm.nvim gives you persistent, buffer-like terminal windows.
-- Float a terminal with <leader>tt, open a horizontal split with <leader>th,
-- or send commands to a running terminal from any buffer.

return {
	{
		'akinsho/toggleterm.nvim',
		version = '*',
		cmd = { 'ToggleTerm', 'TermExec' },
		keys = {
			{ '<leader>tt', '<cmd>ToggleTerm direction=float<CR>', desc = 'Terminal (float)' },
			{ '<leader>tT', '<cmd>ToggleTerm direction=horizontal<CR>', desc = 'Terminal (horizontal)' },
			{ '<leader>tv', '<cmd>ToggleTerm direction=vertical<CR>', desc = 'Terminal (vertical)' },
		},
		opts = {
			size = function(term)
				if term.direction == 'horizontal' then
					return 15
				elseif term.direction == 'vertical' then
					return vim.o.columns * 0.4
				end
			end,
			open_mapping = false, -- we define our own keymaps above
			hide_numbers = true,
			shade_filetypes = {},
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = true,
			persist_size = true,
			direction = 'float',
			close_on_exit = true,
			float_opts = {
				border = 'curved',
				winblend = 3,
			},
		},
	},
}