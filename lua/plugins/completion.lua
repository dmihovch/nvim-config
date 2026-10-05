-- =============================================================================
-- Autocompletion: blink.cmp + LuaSnip
-- =============================================================================
-- blink.cmp is a modern, fast completion engine. It pulls from:
--   - LSP servers (code completions)
--   - File paths
--   - LuaSnip snippets
--   - lazydev (Lua API completions for Neovim config)
-- =============================================================================

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
				-- Tab accepts the selected completion (IDE-like).
				-- Ctrl+n / Ctrl+p still navigate the list.
				-- When no completion menu is open, Tab falls through to
				-- its normal behaviour (indent, snippet next, etc.).
				['<Tab>'] = { 'accept', 'fallback' },
				['<C-y>'] = {},
			},

			completion = {
				-- Don't auto-show documentation (press K or <C-k> to see it).
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