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

-- Make `gf` find C/C++ headers anywhere in the project. Vim's default `path`
-- only searches the current directory and the file's own directory, so an
-- `#include` whose header lives in include/ or src/ fails with E447. Search
-- from the buffer up to the project root instead.
autocmd('FileType', {
	desc = 'Resolve C/C++ includes for gf',
	group = augroup('c-include-path', { clear = true }),
	pattern = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
	callback = function()
		local dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':p:h')
		local root = vim.fs.root(dir, { '.git', 'compile_commands.json', 'CMakeLists.txt', 'Makefile' })
		local path = { '.', dir }
		if root then
			path[#path + 1] = root
			path[#path + 1] = root .. '/**'
		end
		vim.opt_local.path = path
		vim.opt_local.suffixesadd:append({ '.h', '.hpp', '.hh', '.hxx', '.inl' })
	end,
})