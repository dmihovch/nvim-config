-- =============================================================================
-- LSP: Language Server Protocol Setup
-- =============================================================================
-- This file handles everything LSP-related:
--   1. Mason installs and manages LSP server binaries
--   2. mason-lspconfig bridges Mason ↔ lspconfig
--   3. nvim-lspconfig configures each server
--   4. Keymaps are set up automatically when a server attaches to a buffer
--
-- ---- How to Add a New LSP Server ----
--   1. Add it to the `servers` table below (e.g., `rust_analyzer = {}`)
--   2. If it needs special settings, add them (see lua_ls for an example)
--   3. Restart Neovim — Mason will prompt to install the server
--
-- ---- How to Remove an LSP Server ----
--   1. Delete its entry from the `servers` table
--   2. (Optional) Run `:MasonUninstall <server-name>` to remove the binary
--
-- ---- How to Add a Formatter / Linter ----
--   1. Add it to the `ensure_installed` list (around line 140)
--   2. Restart Neovim — Mason will install it
--   3. Configure it with conform.nvim or none-ls.nvim (not included by default)
-- =============================================================================

return {
	{
		-- ---- lazydev: Lua LSP for Neovim config & plugin development ----
		'folke/lazydev.nvim',
		ft = 'lua',
		opts = {
			library = {
				-- Load luvit types when `vim.uv` is used.
				{ path = '${3rd}/luv/library', words = { 'vim%.uv' } },
			},
		},
	},

	{
		-- ---- Main LSP Setup ----
		'neovim/nvim-lspconfig',
		dependencies = {
			-- Mason: LSP server package manager
			{ 'mason-org/mason.nvim', opts = {} },
			'mason-org/mason-lspconfig.nvim',
			'WhoIsSethDaniel/mason-tool-installer.nvim',

			-- LSP status updates (spinner in the corner)
			{ 'j-hui/fidget.nvim', opts = {} },

			-- Extra LSP capabilities from blink.cmp
			'saghen/blink.cmp',
		},
		config = function()
			-- ============================================================
			-- LSP Keymaps (set when a server attaches to a buffer)
			-- ============================================================
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or 'n'
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
					end

					-- Navigation
					map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
					map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
					map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')
					map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
					map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

					-- Symbols
					map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
					map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

					-- Actions
					map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
					map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

					-- Hover / Signature
					map('K', vim.lsp.buf.hover, 'Hover Documentation')
					map('<leader>ca', vim.lsp.buf.code_action, 'Code [A]ction')

					-- ====================================================
					-- Document Highlight (highlight references under cursor)
					-- ====================================================
					---@param client vim.lsp.Client
					---@param method vim.lsp.protocol.Method
					---@param bufnr? integer
					---@return boolean
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

					-- ====================================================
					-- Inlay Hints
					-- ====================================================
					if
						client
						and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
					then
						map('<leader>th', function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, '[T]oggle Inlay [H]ints')
					end
				end,
			})

			-- ============================================================
			-- Diagnostics Configuration
			-- ============================================================
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

			-- ============================================================
			-- LSP Server Definitions
			-- ============================================================
			-- Add or remove servers here. Each key is the server name as
			-- recognized by mason-lspconfig. The value is a config table
			-- passed to lspconfig[server].setup().
			--
			-- Common servers:
			--   rust_analyzer = {}            -- Rust
			--   zls = {}                      -- Zig
			--   jdtls = {}                    -- Java
			--   nil_ls = {}                   -- Nix
			--   terraformls = {}              -- Terraform
			--   dockerls = {}                 -- Docker
			--   yamlls = {}                   -- YAML
			--   jsonls = {}                   -- JSON
			--   marksman = {}                 -- Markdown
			--   bashls = {}                   -- Bash
			local capabilities = require('blink.cmp').get_lsp_capabilities()

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

			-- ============================================================
			-- Mason: Auto-install Servers & Tools
			-- ============================================================
			-- These tools are installed automatically by Mason.
			-- Add formatters/linters here (e.g., 'prettier', 'eslint_d').
			local ensure_installed = vim.tbl_keys(servers)
			vim.list_extend(ensure_installed, {
				'stylua',
				'clang-format',
			})
			require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

			-- ============================================================
			-- Wire Everything Together
			-- ============================================================
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