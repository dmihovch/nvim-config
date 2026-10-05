-- =============================================================================
-- Session Persistence (Emacs-like: desktop.el)
-- =============================================================================
-- auto-session.nvim automatically saves and restores your session
-- (open buffers, splits, tabs, cwd) when you open/close Neovim.
-- Sessions are stored per-git-branch, so switching branches gives you
-- the right set of files.

return {
	{
		'rmagatti/auto-session',
		lazy = false,
		opts = {
			log_level = 'error',
			auto_session_suppress_dirs = { '~/', '~/Downloads', '/' },
			auto_save_enabled = true,
			auto_restore_enabled = true,
		},
		keys = {
			{ '<leader>ss', '<cmd>SessionSave<CR>', desc = 'Save session' },
			{ '<leader>sl', '<cmd>SessionRestore<CR>', desc = 'Restore session' },
			{ '<leader>sd', '<cmd>SessionDelete<CR>', desc = 'Delete session' },
			{ '<leader>s.', '<cmd>Telescope session-lens<CR>', desc = 'Search sessions' },
		},
		-- Session lens for telescope (browse saved sessions)
		dependencies = {
			{
				'rmagatti/session-lens',
				cmd = 'Telescope',
			},
		},
	},
}