-- Session persistence via auto-session. Saves and restores buffers, splits,
-- and working directory per git branch.
--
--   <leader>ss  save session
--   <leader>sl  restore session
--   <leader>sd  delete session
--   <leader>s.  search sessions

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
		dependencies = {
			{
				'rmagatti/session-lens',
				cmd = 'Telescope',
			},
		},
	},
}