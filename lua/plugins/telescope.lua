-- Fuzzy finder.
--
--   <leader>ff  find files
--   <leader>fa  find files (home)
--   <leader>fA  find files (root)
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

			-- <leader>fa / <leader>fA: find any file by name. fd runs with the query
			-- as its pattern, so only matching paths are produced. A recursive scan
			-- instead would load every file up front (812k in home, 1.6M from /).
			local finders = require('telescope.finders')
			local make_entry = require('telescope.make_entry')
			local pickers = require('telescope.pickers')
			local conf = require('telescope.config').values

			-- fd is named fdfind on Debian.
			local fd = vim.fn.executable('fd') == 1 and 'fd' or 'fdfind'

			local function find_from(root)
				-- Exclude pseudo filesystems, but only when searching from /.
				local excludes = root == '/' and { 'proc', 'sys', 'dev', 'run' } or {}
				local prefix = root:sub(-1) == '/' and root or root .. '/'

				return function()
					local opts = { cwd = root }
					local entry_maker = make_entry.gen_from_file(opts)
					pickers.new(opts, {
						prompt_title = 'Find files (' .. root .. ')',
						finder = finders.new_job(function(prompt)
							if not prompt or prompt == '' then
								return nil
							end
							local args = { fd, '--type', 'f', '--hidden' }
							for _, dir in ipairs(excludes) do
								args[#args + 1] = '--exclude'
								args[#args + 1] = dir
							end
							args[#args + 1] = prompt
							return args
						end, function(line)
							local entry = entry_maker(line)
							-- gen_from_file joins cwd "/" into a doubled slash.
							rawset(entry, 'path', line:sub(1, 1) == '/' and line or prefix .. line)
							return entry
						end, nil, opts.cwd),
						sorter = conf.file_sorter(opts),
						previewer = conf.grep_previewer(opts),
					}):find()
				end
			end

			vim.keymap.set('n', '<leader>fa', find_from(vim.fn.expand('~')), { desc = 'Find files (home)' })
			vim.keymap.set('n', '<leader>fA', find_from('/'), { desc = 'Find files (root)' })
		end,
	},
}