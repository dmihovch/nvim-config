-- =============================================================================
-- Editing: File Explorer, Git Signs, Autopairs, Compile Runner
-- =============================================================================
-- These plugins enhance the editing experience without getting in your way.

return {
	-- ---- Auto-detect Indentation ----
	-- Detects whether a file uses tabs or spaces and adjusts shiftwidth/tabstop
	-- accordingly. Overrides the defaults set in options.lua per-buffer.
	{ 'NMAC427/guess-indent.nvim' },

	-- ---- Git Signs ----
	-- Shows added/modified/deleted lines in the sign column.
	{
		'lewis6991/gitsigns.nvim',
		opts = {
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
		},
	},

	-- ---- File Explorer (dired-style) ----
	-- oil.nvim replaces netrw with an editable directory buffer.
	-- Open with <leader>e. Edit file paths directly to rename/move.
	-- Press <leader>e again or <CR> on a file to close and open it.
	{
		'stevearc/oil.nvim',
		lazy = false,
		opts = {
			default_file_explorer = true,
			keymaps = {
				['<leader>e'] = 'actions.close', -- toggle: same key opens and closes
				['<C-h>'] = false, -- let global <C-h> handle window nav
				['<C-l>'] = false,
			},
		},
	},

	-- ---- Auto-pairs ----
	-- Automatically closes brackets, quotes, etc. Lightweight (part of mini.nvim).
	{
		'echasnovski/mini.pairs',
		event = 'VeryLazy',
		opts = {
			modes = { insert = true, command = false, terminal = false },
		},
	},

	-- ---- Compile Runner (Emacs-like: M-x compile) ----
	-- Run build commands and see output in a dedicated buffer.
	-- <leader>cc → compile, <leader>cr → recompile, <leader>cq → close output.
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