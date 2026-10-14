-- Filesystem-wide file browser built on telescope.nvim.
--
--   <leader>fd  browse files from the working directory
--
-- Navigate like a shell. Type a path ending in "/" to descend into it, or type
-- a full path and press <CR> to open it (creating it if it does not exist).
--
-- Inside the picker:
--   <C-e>  go to home            <C-h>  toggle hidden files
--   <C-g>  go to parent dir      <C-f>  toggle file/folder browser
--   <C-w>  go to nvim cwd        <BS>   parent dir on an empty prompt
--   <A-c>  create  <A-r> rename  <A-m> move  <A-y> copy  <A-d> delete  <C-o> open

return {
	{
		'nvim-telescope/telescope-file-browser.nvim',
		dependencies = {
			'nvim-telescope/telescope.nvim',
			'nvim-lua/plenary.nvim',
		},
		config = function()
			require('telescope').load_extension('file_browser')
		end,
		keys = {
			{
				'<leader>fd',
				function()
					require('telescope').extensions.file_browser.file_browser()
				end,
				desc = 'Browse directory',
			},
		},
	},
}
