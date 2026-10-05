-- Undo tree visualization. <leader>u toggles the undo history buffer.

return {
	{
		'mbbill/undotree',
		cmd = 'UndotreeToggle',
		keys = {
			{ '<leader>u', '<cmd>UndotreeToggle<CR>', desc = 'Undo tree' },
		},
	},
}