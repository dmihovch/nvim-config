-- Autocommands. See `:help lua-guide-autocommands`.

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Briefly highlight yanked text (try `yap`).
autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = augroup('highlight-yank', { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Leave a snippet if the cursor moves outside of it.
autocmd('CursorMovedI', {
	callback = function()
		local ok, luasnip = pcall(require, 'luasnip')
		if not ok then
			return
		end
		if luasnip.session.current_nodes[vim.api.nvim_get_current_buf()] and not luasnip.in_snippet() then
			luasnip.unlink_current()
		end
	end,
})
