-- =============================================================================
-- Interactive Find & Replace (Emacs-like: wgrep / project-query-replace)
-- =============================================================================
-- grug-far.nvim gives you an interactive search-and-replace buffer.
-- Search across the project, preview results, edit replacements inline,
-- and apply them all at once. Open with <leader>sr.

return {
	{
		'MagicDuck/grug-far.nvim',
		cmd = 'GrugFar',
		keys = {
			{ '<leader>sr', '<cmd>GrugFar<CR>', desc = 'Search and replace' },
		},
		opts = {
			-- Use ripgrep for searching
			engines = {
				regex = 'ripgrep',
			},
		},
	},
}