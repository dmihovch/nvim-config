-- =============================================================================
-- Fuzzy Finder (Emacs-like: find-file / counsel / ivy)
-- =============================================================================
-- telescope.nvim is the central hub for finding everything:
--   <leader>ff → find files
--   <leader>fg → live grep (search file contents)
--   <leader>fb → switch buffers
--   <leader>fh → search help tags
--   <leader>fk → search keymaps
--   <leader>fc → search commands
--   <leader>f. → recent files (oldfiles)
--   <leader>fp → switch project
-- =============================================================================

return {
	{
		'nvim-telescope/telescope.nvim',
		event = 'VimEnter',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build = 'make',
				cond = function()
					return vim.fn.executable('make') == 1
				end,
			},
			'nvim-telescope/telescope-ui-select.nvim',
		},
		config = function()
			require('telescope').setup({
				defaults = {
					-- Use ripgrep for live_grep (respects .gitignore)
					vimgrep_arguments = {
						'rg',
						'--color=never',
						'--no-heading',
						'--with-filename',
						'--line-number',
						'--column',
						'--smart-case',
					},
				},
				pickers = {
					find_files = {
						-- Hide files listed in .gitignore
						find_command = { 'rg', '--files', '--hidden', '--glob', '!.git' },
					},
				},
			})

			local builtin = require('telescope.builtin')

			-- File finding
			vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
			vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = 'Recent files' })
			vim.keymap.set('n', '<leader>fp', builtin.git_files, { desc = 'Find files (git)' })

			-- Search
			vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep' })
			vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Grep word under cursor' })

			-- Buffers
			vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Switch buffer' })

			-- Help & config
			vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help tags' })
			vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Keymaps' })
			vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = 'Commands' })
		end,
	},
}