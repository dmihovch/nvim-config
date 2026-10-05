-- LSP setup. Mason installs servers, lspconfig configures them.
--
-- To add a server:
--   1. Add it to the `servers` table.
--   2. Restart Neovim. Mason installs it.
--
-- To remove a server:
--   1. Delete its entry from `servers`.
--   2. Run :MasonUninstall <name> to remove the binary.

return {
	-- Lua LSP for Neovim config and plugin development.
	{
		'folke/lazydev.nvim',
		ft = 'lua',
		opts = {
			library = {
				{ path = '${3rd}/luv/library', words = { 'vim%.uv' } },
			},
		},
	},

	{
		'neovim/nvim-lspconfig',
		dependencies = {
			{ 'mason-org/mason.nvim', opts = {} },
			'mason-org/mason-lspconfig.nvim',
			'WhoIsSethDaniel/mason-tool-installer.nvim',
			{ 'j-hui/fidget.nvim', opts = {} },
			'saghen/blink.cmp',
		},
		config = function()
			-- LSP keymaps. Set when a server attaches to a buffer.
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or 'n'
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
					end

					map('grd', require('telescope.builtin').lsp_definitions, 'Go to definition')
					map('grD', vim.lsp.buf.declaration, 'Go to declaration')
					map('grt', require('telescope.builtin').lsp_type_definitions, 'Go to type definition')
					map('gri', require('telescope.builtin').lsp_implementations, 'Go to implementation')
					map('grr', require('telescope.builtin').lsp_references, 'Find references')
					map('gO', require('telescope.builtin').lsp_document_symbols, 'Document symbols')
					map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace symbols')
					map('grn', vim.lsp.buf.rename, 'Rename')
					map('gra', vim.lsp.buf.code_action, 'Code action', { 'n', 'x' })
					map('K', vim.lsp.buf.hover, 'Hover')
					map('<leader>ca', vim.lsp.buf.code_action, 'Code action')

					-- Document highlight (references under cursor).
					local function client_supports_method(client, method, bufnr)
						if vim.fn.has('nvim-0.11') == 1 then
							return client:supports_method(method, bufnr)
						else
							return client.supports_method(method, { bufnr = bufnr })
						end
					end

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if
						client
						and client_supports_method(
							client,
							vim.lsp.protocol.Methods.textDocument_documentHighlight,
							event.buf
						)
					then
						local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
						vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})
						vim.api.nvim_create_autocmd('LspDetach', {
							group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = 'lsp-highlight', buffer = event2.buf })
							end,
						})
					end

					-- Inlay hints toggle.
					if
						client
						and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
					then
						map('<leader>th', function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, 'Toggle inlay hints')
					end
				end,
			})

			-- Diagnostics.
			vim.diagnostic.config({
				severity_sort = true,
				float = { border = 'rounded', source = 'if_many', max_width = 60 },
				underline = { severity = vim.diagnostic.severity.ERROR },
				virtual_text = {
					source = 'if_many',
					spacing = 2,
					format = function(diagnostic)
						return diagnostic.message
					end,
				},
			})

			-- Toggle diagnostics on/off. State persists to disk.
			local state_file = vim.fn.stdpath('state') .. '/diagnostics_disabled'
			local function save_diag_state(disabled)
				local f = io.open(state_file, 'w')
				if f then
					f:write(disabled and '1' or '0')
					f:close()
				end
			end
			local function load_diag_state()
				local f = io.open(state_file, 'r')
				if f then
					local val = f:read('*a')
					f:close()
					return val == '1'
				end
				return false
			end
			if load_diag_state() then
				vim.diagnostic.enable(false)
			end
			vim.keymap.set('n', '<leader>td', function()
				local enabled = not vim.diagnostic.is_enabled()
				vim.diagnostic.enable(enabled)
				save_diag_state(not enabled)
				local msg = enabled and 'Diagnostics on' or 'Diagnostics off'
				vim.notify(msg, vim.log.levels.INFO, { title = 'LSP' })
			end, { desc = 'Toggle diagnostics' })

			local capabilities = require('blink.cmp').get_lsp_capabilities()

			-- Server definitions. Add or remove entries here.
			local servers = {
				clangd = {},
				gopls = {},
				pyright = {},
				ts_ls = {},
				html = {},
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = 'Replace',
							},
						},
					},
				},
			}

			-- Tools Mason installs automatically.
			local ensure_installed = vim.tbl_keys(servers)
			vim.list_extend(ensure_installed, {
				'stylua',
				'clang-format',
			})
			require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

			-- Wire Mason to lspconfig.
			require('mason-lspconfig').setup({
				ensure_installed = {},
				automatic_installation = false,
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities =
							vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
						require('lspconfig')[server_name].setup(server)
					end,
				},
			})
		end,
	},
}