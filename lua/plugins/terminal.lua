-- Terminal buffers via toggleterm.nvim.
--
--   <leader>tt  horizontal split terminal
--   <leader>tT  floating terminal
--   <leader>tv  vertical split terminal
--
-- Inside a terminal: Ctrl-w h/j/k/l navigates windows.
-- Ctrl-t exits terminal insert mode (then use normal-mode keys).

return {
	{
		'akinsho/toggleterm.nvim',
		version = '*',
		cmd = { 'ToggleTerm', 'TermExec' },
		keys = {
			{ '<leader>tt', '<cmd>ToggleTerm direction=horizontal<CR>', desc = 'Terminal (horizontal)' },
			{ '<leader>tT', '<cmd>ToggleTerm direction=float<CR>', desc = 'Terminal (float)' },
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
			open_mapping = false,
			hide_numbers = true,
			shade_filetypes = {},
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = true,
			persist_size = true,
			direction = 'horizontal',
			close_on_exit = true,
			float_opts = {
				border = 'curved',
				winblend = 3,
			},
			on_open = function(term)
				-- Ctrl-t exits terminal insert mode so you can navigate windows.
				vim.keymap.set('t', '<C-t>', '<C-\\><C-n>', { buffer = term.bufnr, desc = 'Exit terminal mode' })
			end,
		},
	},
}