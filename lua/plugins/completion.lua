-- Autocompletion via blink.cmp. Sources: LSP, path, snippets, lazydev.

return {
	{
		'saghen/blink.cmp',
		event = 'VimEnter',
		version = '1.*',
		dependencies = {
			{
				'L3MON4D3/LuaSnip',
				version = '2.*',
				build = (function()
					if vim.fn.has('win32') == 1 or vim.fn.executable('make') == 0 then
						return
					end
					return 'make install_jsregexp'
				end)(),
			},
			'folke/lazydev.nvim',
		},
		--- @module 'blink.cmp'
		--- @type blink.cmp.Config
		opts = {
			keymap = {
				preset = 'default',
				-- Tab accepts the selected completion. Ctrl+n/p navigate.
				-- When no completion menu is open, Tab falls through to
				-- indent or snippet-next.
				['<Tab>'] = { 'accept', 'fallback' },
				['<C-y>'] = {},
			},

			completion = {
				documentation = { auto_show = false, auto_show_delay_ms = 500 },
			},

			sources = {
				default = { 'lsp', 'path', 'snippets', 'lazydev' },
				providers = {
					lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
				},
			},

			snippets = { preset = 'luasnip' },
			fuzzy = { implementation = 'lua' },
			signature = { enabled = true },
		},
	},
}