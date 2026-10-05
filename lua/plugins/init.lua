-- Plugin index. Each import loads a file from lua/plugins/.
--
-- To add a plugin:
--   1. Create lua/plugins/<name>.lua
--   2. Add { import = 'plugins.<name>' } below

return {
	{ import = 'plugins.colorscheme' },
	{ import = 'plugins.editing' },
	{ import = 'plugins.telescope' },
	{ import = 'plugins.treesitter' },
	{ import = 'plugins.lsp' },
	{ import = 'plugins.completion' },
	{ import = 'plugins.ui' },
	{ import = 'plugins.terminal' },
	{ import = 'plugins.trouble' },
	{ import = 'plugins.search-replace' },
	{ import = 'plugins.session' },
	{ import = 'plugins.undotree' },
}