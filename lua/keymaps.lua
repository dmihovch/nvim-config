-- Global keymaps. Plugin-local maps live in their plugin spec files.
--
-- Conventions:
--   <leader>f  Find / Files
--   <leader>s  Search
--   <leader>b  Buffer
--   <leader>w  Window
--   <leader>t  Toggle / Terminal
--   <leader>x  Diagnostics / Trouble
--   <leader>c  Cd / Compile
--   <leader>g  Git

local map = vim.keymap.set

-- Clear search highlight.
map('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })

-- Diagnostic quickfix list.
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostic quickfix list' })

-- Disable arrow keys.
map('n', '<left>', '', { desc = '' })
map('n', '<right>', '', { desc = '' })
map('n', '<up>', '', { desc = '' })
map('n', '<down>', '', { desc = '' })

-- File explorer (oil.nvim).
map('n', '<leader>e', '<cmd>Oil<CR>', { desc = 'File explorer' })

-- Splits.
map('n', '<leader>wv', '<cmd>vsplit<CR>', { desc = 'Vertical split' })
map('n', '<leader>wh', '<cmd>split<CR>', { desc = 'Horizontal split' })
map('n', '<leader>wc', '<cmd>close<CR>', { desc = 'Close window' })
map('n', '<leader>wo', '<cmd>only<CR>', { desc = 'Close other windows' })

-- Window navigation.
map('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
map('n', '<C-j>', '<C-w>j', { desc = 'Move to window below' })
map('n', '<C-k>', '<C-w>k', { desc = 'Move to window above' })
map('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

-- Buffer management.
map('n', '<leader>bd', '<cmd>bdelete<CR>', { desc = 'Delete buffer' })
map('n', '<leader>bD', '<cmd>bdelete!<CR>', { desc = 'Delete buffer (force)' })
map('n', '<leader>bn', '<cmd>bnext<CR>', { desc = 'Next buffer' })
map('n', '<leader>bp', '<cmd>bprevious<CR>', { desc = 'Previous buffer' })
map('n', '<leader>bq', '<cmd>%bdelete<bar>edit #<bar>bdelete #<CR>', { desc = 'Close all buffers but this' })

-- Help for word under cursor.
map('n', '<leader>sh', '<cmd>help <C-r><C-w><CR>', { desc = 'Help for word under cursor' })

-- Resize windows.
map('n', '<C-Up>', '<cmd>resize +2<CR>', { desc = 'Increase window height' })
map('n', '<C-Down>', '<cmd>resize -2<CR>', { desc = 'Decrease window height' })
map('n', '<C-Left>', '<cmd>vertical resize -2<CR>', { desc = 'Decrease window width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<CR>', { desc = 'Increase window width' })

-- Quick shell command. Prompts for a command, runs it, shows output in a split.
map('n', '<leader>1', function()
	vim.ui.input({ prompt = 'Shell command: ' }, function(cmd)
		if not cmd or cmd == '' then
			return
		end
		local output = vim.fn.systemlist(cmd)
		local exit_code = vim.v.shell_error
		vim.cmd('new')
		local buf = vim.api.nvim_get_current_buf()
		vim.bo[buf].buftype = 'nofile'
		vim.bo[buf].bufhidden = 'wipe'
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
		vim.api.nvim_buf_set_lines(buf, -1, -1, false, { '', 'Exit code: ' .. exit_code })
		vim.bo[buf].modifiable = false
		vim.cmd('file Shell: ' .. cmd)
	end)
end, { desc = 'Run shell command' })

-- Working directory.
map('n', '<leader>cd', '<cmd>cd %:p:h<CR><cmd>pwd<CR>', { desc = 'Cd to current file dir' })
map('n', '<leader>cD', function()
	local git_root = vim.fn.systemlist('git -C ' .. vim.fn.expand('%:p:h') .. ' rev-parse --show-toplevel 2>/dev/null')[1]
	if git_root and vim.v.shell_error == 0 then
		vim.cmd.cd(git_root)
	else
		vim.cmd.cd('%:p:h')
	end
	vim.cmd.pwd()
end, { desc = 'Cd to project root' })