-- Fuzzy finder.
--
--   <leader>ff  find files
--   <leader>f.  recent files
--   <leader>fp  git files
--   <leader>fg  live grep
--   <leader>fw  grep word under cursor
--   <leader>fb  switch buffer
--   <leader>fh  help tags
--   <leader>fk  keymaps
--   <leader>fc  commands

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
						find_command = { 'rg', '--files', '--hidden', '--glob', '!.git' },
					},
				},
			})

			local builtin = require('telescope.builtin')

			vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
			vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = 'Recent files' })
			vim.keymap.set('n', '<leader>fp', builtin.git_files, { desc = 'Find files (git)' })
			vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep' })
			vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Grep word under cursor' })
			vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Switch buffer' })
			vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help tags' })
			vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Keymaps' })
			vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = 'Commands' })
		end,
	},
}