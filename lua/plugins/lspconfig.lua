return {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      { 'j-hui/fidget.nvim', opts = {} },
      'folke/neodev.nvim',
    },
    config = function()
		local protocol = require("vim.lsp.protocol")
		local status, lsp_config = pcall(require, "lspconfig")
		if (not status) then return end

		local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })
		
		local enable_format_on_save = function(_, bufnr)
			vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup_format,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end

		local navic = require("nvim-navic")
		-- [ KEY MAPPING ]
		local on_attach = function(client, bufnr)
			-- set local mapping func
			if client.server_capabilities.documentSymbolProvider then
				navic.attach(client, bufnr)
			end
			local nmap = function(keys, func, desc)
				if desc then
				desc = 'LSP: ' .. desc
				end

				vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
			end
			-- keymaps
			nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
			nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

			nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
			nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
			nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
			nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
			nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
			nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

			-- See `:help K` for why this keymap
			nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
			nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

			-- Lesser used LSP functionality
			nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
			nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
			nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
			nmap('<leader>wl', function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, '[W]orkspace [L]ist Folders')

			-- Create a command `:Format` local to the LSP buffer
			vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(client)
				vim.lsp.buf.format()
			end, { desc = 'Format current buffer with LSP' })
		end

		-- [ LSP CONFIG SERVERS SETUP ]
		
		protocol.CompletionItemKind = {
			'', -- Text
			'', -- Method
			'', -- Function
			'', -- Constructor
			'', -- Field
			'', -- Variable
			'', -- Class
			'ﰮ', -- Interface
			'', -- Module
			'', -- Property
			'', -- Unit
			'', -- Value
			'', -- Enum
			'', -- Keyword
			'﬌', -- Snippet
			'', -- Color
			'', -- File
			'', -- Reference
			'', -- Folder
			'', -- EnumMember
			'', -- Constant
			'', -- Struct
			'', -- Event
			'ﬦ', -- Operator
			'', -- TypeParameter
		}

		-- Setup neovim lua configuration
		require('neodev').setup()
		
		-- Setup mason so it can manage external tooling
		require('mason').setup()
		

		-- Ensure the servers above are installed
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

		local servers = {
			tsserver = {},
			lua_ls = {
				Lua = {
					diagnostics = { globals = { 'vim' }, },
					workspace = { checkThirdParty = false },
				},
			},
			bashls = {},
			cssls = {},
			clangd = {},
			gopls = {},
			html = {},
			pyright = {},
			rust_analyzer = {},
			jdtls = {},
			sqlls = {},
			vimls = {},
			intelephense = {},

		}

		local mason_lspconfig = require 'mason-lspconfig'

		mason_lspconfig.setup {
			ensure_installed = vim.tbl_keys(servers),
		}

		mason_lspconfig.setup_handlers {
			function(server_name)
				lsp_config[server_name].setup {
					capabilities = capabilities,
					on_attach = on_attach,
					settings = servers[server_name],
				}
			end,
		}

		-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
		-- 	vim.lsp.diagnostic.on_publish_diagnostics, {
		-- 		underline = false,
		-- 		update_in_insert = false,
		-- 		virtual_text = {
		-- 			severity = { min = vim.diagnostic.severity.WARN},
		-- 		},
		-- 		severity_sort = true,
		-- 		signs = true,
		-- 	}
		-- )
		-- Diagnostic symbols in the sign column (gutter)
		local signs = { Error = " ", Warn = "", Hint = "", Info = "" }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		vim.diagnostic.config({
			underline = {
				severity = { min = vim.diagnostic.severity.WARN},
			},
			signs = true,
			virtual_text = {
				prefix = '·',
				severity = { min = vim.diagnostic.severity.WARN}
			},
			severity_sort = true,
		})

	end,
}
