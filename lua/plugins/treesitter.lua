-- Treesitter: parser-based highlighting and indentation.

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
				additional_vim_regex_highlighting = { 'ruby' },
			},
			indent = { enable = true, disable = { 'ruby' } },
		},
	},
}
