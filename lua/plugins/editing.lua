-- Editing: indentation detection, git signs, file explorer, autopairs, compile.

return {
	-- Auto-detect indentation style per buffer.
	{ 'NMAC427/guess-indent.nvim' },

	-- Git signs in the sign column.
	{
		'lewis6991/gitsigns.nvim',
		opts = {
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '^' },
				changedelete = { text = '~' },
			},
		},
	},

	-- File explorer as editable buffer (dired-style).
	{
		'stevearc/oil.nvim',
		lazy = false,
		opts = {
			default_file_explorer = true,
			keymaps = {
				['<leader>e'] = 'actions.close',
				['<C-h>'] = false,
				['<C-l>'] = false,
			},
		},
	},

	-- Auto-close brackets and quotes.
	{
		'echasnovski/mini.pairs',
		event = 'VeryLazy',
		opts = {
			modes = { insert = true, command = false, terminal = false },
		},
	},

	-- Compile runner. <leader>cc compile, <leader>cr recompile, <leader>cq close.
	{
		'ej-shafran/compile-mode.nvim',
		version = '^5.0.0',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			vim.g.compile_mode = {}

			vim.keymap.set('n', '<leader>cc', '<cmd>Compile<cr>', { desc = 'Compile' })
			vim.keymap.set('n', '<leader>cr', '<cmd>Recompile<cr>', { desc = 'Recompile' })
			vim.keymap.set('n', '<leader>cq', function()
				for _, win in ipairs(vim.api.nvim_list_wins()) do
					local buf = vim.api.nvim_win_get_buf(win)
					if vim.bo[buf].filetype == 'compilation' then
						vim.api.nvim_win_close(win, false)
					end
				end
			end, { desc = 'Close compile window' })
		end,
	},
}