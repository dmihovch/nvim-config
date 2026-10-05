-- =============================================================================
-- UI: Keybinding Hints (which-key) and Statusline (lualine)
-- =============================================================================
-- No Nerd Font icons — everything uses plain text labels that work
-- in any terminal.

return {
	-- ---- which-key: Popup showing available keybindings ----
	{
		'folke/which-key.nvim',
		event = 'VimEnter',
		opts = {
			delay = 0,
			icons = {
				-- Text labels instead of Nerd Font glyphs.
				mappings = false,
				keys = {
					Up = '<Up> ',
					Down = '<Down> ',
					Left = '<Left> ',
					Right = '<Right> ',
					C = '<C-…> ',
					M = '<M-…> ',
					D = '<D-…> ',
					S = '<S-…> ',
					CR = '<CR> ',
					Esc = '<Esc> ',
					ScrollWheelDown = '<ScrollWheelDown> ',
					ScrollWheelUp = '<ScrollWheelUp> ',
					NL = '<NL> ',
					BS = '<BS> ',
					Space = '<Space> ',
					Tab = '<Tab> ',
					F1 = '<F1>',
					F2 = '<F2>',
					F3 = '<F3>',
					F4 = '<F4>',
					F5 = '<F5>',
					F6 = '<F6>',
					F7 = '<F7>',
					F8 = '<F8>',
					F9 = '<F9>',
					F10 = '<F10>',
					F11 = '<F11>',
					F12 = '<F12>',
				},
			},
			-- Document keybinding groups so they show up in the which-key popup.
			spec = {
				{ '<leader>b', group = '[B]uffer' },
				{ '<leader>f', group = '[F]ind / [F]iles' },
				{ '<leader>g', group = '[G]it' },
				{ '<leader>s', group = '[S]earch / [S]ession' },
				{ '<leader>t', group = '[T]oggle / [T]erminal' },
				{ '<leader>w', group = '[W]indow' },
				{ '<leader>x', group = 'Diagnostics / Trouble' },
				{ '<leader>c', group = '[C]d / [C]ompile' },
				{ 'gr', group = 'LSP: [G]oto / [R]eferences' },
			},
		},
	},

	-- ---- lualine: Statusline ----
	-- Clean, minimal statusline with no separators.
	{
		'nvim-lualine/lualine.nvim',
		config = function()
			require('lualine').setup({
				options = {
					section_separators = '',
					component_separators = '',
				},
			})
		end,
	},
}