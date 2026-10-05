-- =============================================================================
-- Plugin Index
-- =============================================================================
-- Each `import` points to a file in lua/plugins/ that returns a list of
-- plugin specs. Add new plugin files here to register them.
--
-- To add a new plugin:
--   1. Create lua/plugins/my-plugin.lua
--   2. Add `{ import = 'plugins.my-plugin' }` below
-- =============================================================================

return {
	-- Core
	{ import = 'plugins.colorscheme' },
	{ import = 'plugins.editing' },
	{ import = 'plugins.telescope' },
	{ import = 'plugins.treesitter' },
	{ import = 'plugins.lsp' },
	{ import = 'plugins.completion' },
	{ import = 'plugins.ui' },

	-- Emacs-like / IDE enhancements
	{ import = 'plugins.terminal' },
	{ import = 'plugins.trouble' },
	{ import = 'plugins.search-replace' },
	{ import = 'plugins.session' },
	{ import = 'plugins.undotree' },
}