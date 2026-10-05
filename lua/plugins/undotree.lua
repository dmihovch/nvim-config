-- =============================================================================
-- Undo Tree Visualization (Emacs-like: undo-tree)
-- =============================================================================
-- Visualize and navigate the undo history as a tree.
-- Toggle with <leader>u.

return {
	{
		'mbbill/undotree',
		cmd = 'UndotreeToggle',
		keys = {
			{ '<leader>u', '<cmd>UndotreeToggle<CR>', desc = 'Undo tree' },
		},
	},
}