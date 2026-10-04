-- Global keymaps. Plugin-local maps live with their plugin specs.

local map = vim.keymap.set

-- Clear search highlight.
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostics -> location list.
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Disable arrow keys.
map('n', '<left>', '')
map('n', '<right>', '')
map('n', '<up>', '')
map('n', '<down>', '')

-- File explorer.
map('n', '<leader>e', '<cmd>Oil<CR>', { desc = 'Open file explorer' })

-- Splits.
map('n', '<leader>wv', '<cmd>vsplit<CR>')
map('n', '<leader>wh', '<cmd>split<CR>')

-- Window navigation.
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')
