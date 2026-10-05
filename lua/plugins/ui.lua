-- UI: which-key (keybinding hints) and lualine (statusline).
-- No Nerd Font required. All labels are plain ASCII.

return {
	{
		'folke/which-key.nvim',
		event = 'VimEnter',
		opts = {
			delay = 0,
			icons = {
				mappings = false,
				keys = {
					Up = '<Up> ',
					Down = '<Down> ',
					Left = '<Left> ',
					Right = '<Right> ',
					C = '<C-> ',
					M = '<M-> ',
					D = '<D-> ',
					S = '<S-> ',
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
			spec = {
				{ '<leader>b', group = 'Buffer' },
				{ '<leader>f', group = 'Find / Files' },
				{ '<leader>g', group = 'Git' },
				{ '<leader>s', group = 'Search / Session' },
				{ '<leader>t', group = 'Toggle / Terminal', icon = '' },
				{ '<leader>w', group = 'Window' },
				{ '<leader>x', group = 'Diagnostics / Trouble' },

				{ '<leader>c', group = 'Cd / Compile' },
				{ 'gr', group = 'LSP: Go to / References' },
			},
		},
	},

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