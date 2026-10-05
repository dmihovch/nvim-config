-- Autocommands. See :help lua-guide-autocommands.

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight yanked text.
autocmd('TextYankPost', {
	desc = 'Highlight yanked text',
	group = augroup('highlight-yank', { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Leave snippet when cursor moves outside it.
autocmd('CursorMovedI', {
	desc = 'Leave snippet on cursor move',
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

-- Restore cursor to last position when reopening a file.
autocmd('BufReadPost', {
	desc = 'Restore cursor position',
	group = augroup('restore-cursor', { clear = true }),
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		if mark[1] > 1 and mark[1] <= vim.api.nvim_buf_line_count(0) then
			vim.api.nvim_win_set_cursor(0, mark)
		end
	end,
})

-- Equalize split sizes when terminal is resized.
autocmd('VimResized', {
	desc = 'Equalize splits on terminal resize',
	group = augroup('resize-splits', { clear = true }),
	command = 'wincmd =',
})