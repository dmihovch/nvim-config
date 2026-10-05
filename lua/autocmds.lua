-- =============================================================================
-- Autocommands
-- =============================================================================
-- See `:help lua-guide-autocommands` for the full API.
-- =============================================================================

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- ---- Highlight Yanked Text ----
-- Briefly flash the region you just yanked (try `yap` to see it).
autocmd('TextYankPost', {
	desc = 'Briefly highlight yanked text',
	group = augroup('highlight-yank', { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- ---- Auto-leave Snippet on Cursor Move ----
-- If the cursor moves outside a LuaSnip snippet, unlink it automatically.
autocmd('CursorMovedI', {
	desc = 'Leave snippet when cursor moves outside it',
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

-- ---- Restore Cursor Position ----
-- When re-opening a file, jump to the last known cursor position.
autocmd('BufReadPost', {
	desc = 'Restore cursor to last position',
	group = augroup('restore-cursor', { clear = true }),
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		if mark[1] > 1 and mark[1] <= vim.api.nvim_buf_line_count(0) then
			vim.api.nvim_win_set_cursor(0, mark)
		end
	end,
})

-- ---- Auto-resize Splits on Window Resize ----
autocmd('VimResized', {
	desc = 'Equalize split sizes when terminal is resized',
	group = augroup('resize-splits', { clear = true }),
	command = 'wincmd =',
})