-- =============================================================================
-- Treesitter: Parser-Based Syntax Highlighting & Indentation
-- =============================================================================
-- Treesitter provides more accurate highlighting and indentation than
-- regex-based syntax files. Parsers are installed automatically.
--
-- To add a language:
--   1. Add it to the `ensure_installed` list below
--   2. Restart Neovim — it will be installed automatically
-- =============================================================================

return {
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		config = function(_, opts)
			local ok, configs = pcall(require, 'nvim-treesitter.configs')
			if not ok then
				return
			end
			configs.setup(opts)
		end,
		opts = {
			ensure_installed = {
				'bash',
				'c',
				'diff',
				'html',
				'lua',
				'luadoc',
				'markdown',
				'markdown_inline',
				'query',
				'vim',
				'vimdoc',
				'typescript',
				'javascript',
				'css',
			},
			auto_install = true,
			highlight = {
				enable = true,
				-- Use regex highlighting for Ruby (treesitter Ruby parser can be slow).
				additional_vim_regex_highlighting = { 'ruby' },
			},
			indent = { enable = true, disable = { 'ruby' } },
		},
	},
}