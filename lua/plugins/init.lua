-- Plugin specs are split one file per concern. Add new files here and import them.

return {
	{ import = 'plugins.colorscheme' },
	{ import = 'plugins.editing' },
	{ import = 'plugins.telescope' },
	{ import = 'plugins.treesitter' },
	{ import = 'plugins.lsp' },
	{ import = 'plugins.completion' },
	{ import = 'plugins.ui' },
}
