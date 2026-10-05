-- =============================================================================
-- Global Keymaps
-- =============================================================================
-- Plugin-local keymaps live in their respective plugin spec files.
-- These are global maps that don't belong to any single plugin.
--
-- Conventions:
--   <leader>f…  →  [F]ind / [F]iles
--   <leader>s…  →  [S]earch
--   <leader>b…  →  [B]uffer
--   <leader>w…  →  [W]indow
--   <leader>t…  →  [T]oggle
--   <leader>x…  →  Diagnostics / Trouble
--   <leader>g…  →  [G]it
-- =============================================================================

local map = vim.keymap.set

-- ---- Search ----
-- Clear search highlight with Escape.
map('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })

-- ---- Diagnostics ----
-- Open the built-in diagnostic quickfix list.
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostic quickfix list' })

-- ---- Arrow Keys: Disabled ----
-- Force yourself to use hjkl.
map('n', '<left>', '', { desc = '' })
map('n', '<right>', '', { desc = '' })
map('n', '<up>', '', { desc = '' })
map('n', '<down>', '', { desc = '' })

-- ---- File Explorer ----
-- oil.nvim: open the directory of the current file as an editable buffer.
map('n', '<leader>e', '<cmd>Oil<CR>', { desc = 'File explorer (oil.nvim)' })

-- ---- Splits ----
map('n', '<leader>wv', '<cmd>vsplit<CR>', { desc = 'Vertical split' })
map('n', '<leader>wh', '<cmd>split<CR>', { desc = 'Horizontal split' })
map('n', '<leader>wc', '<cmd>close<CR>', { desc = 'Close window' })
map('n', '<leader>wo', '<cmd>only<CR>', { desc = 'Close other windows' })

-- ---- Window Navigation ----
-- Ctrl+hjkl to move between windows (like Emacs windmove).
map('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
map('n', '<C-j>', '<C-w>j', { desc = 'Move to window below' })
map('n', '<C-k>', '<C-w>k', { desc = 'Move to window above' })
map('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

-- ---- Buffer Management ----
-- Emacs-style buffer operations.
map('n', '<leader>bd', '<cmd>bdelete<CR>', { desc = 'Delete buffer' })
map('n', '<leader>bD', '<cmd>bdelete!<CR>', { desc = 'Delete buffer (force)' })
map('n', '<leader>bn', '<cmd>bnext<CR>', { desc = 'Next buffer' })
map('n', '<leader>bp', '<cmd>bprevious<CR>', { desc = 'Previous buffer' })
map('n', '<leader>bq', '<cmd>%bdelete<bar>edit #<bar>bdelete #<CR>', { desc = 'Close all buffers but this' })

-- ---- Help ----
-- Open help for the word under cursor.
map('n', '<leader>sh', '<cmd>help <C-r><C-w><CR>', { desc = 'Help for word under cursor' })

-- ---- Resize Windows ----
map('n', '<C-Up>', '<cmd>resize +2<CR>', { desc = 'Increase window height' })
map('n', '<C-Down>', '<cmd>resize -2<CR>', { desc = 'Decrease window height' })
map('n', '<C-Left>', '<cmd>vertical resize -2<CR>', { desc = 'Decrease window width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<CR>', { desc = 'Increase window width' })

-- ---- Working Directory ----
-- cd to the directory of the current file.
map('n', '<leader>cd', '<cmd>cd %:p:h<CR><cmd>pwd<CR>', { desc = 'Cd to current file dir' })
-- cd to the project root (git root, or fallback to current file dir).
map('n', '<leader>cD', function()
	local git_root = vim.fn.systemlist('git -C ' .. vim.fn.expand('%:p:h') .. ' rev-parse --show-toplevel 2>/dev/null')[1]
	if git_root and vim.v.shell_error == 0 then
		vim.cmd.cd(git_root)
	else
		vim.cmd.cd('%:p:h')
	end
	vim.cmd.pwd()
end, { desc = 'Cd to project root' })