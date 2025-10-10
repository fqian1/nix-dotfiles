return {
	"williamboman/mason-lspconfig.nvim",
	main = "williamboman/mason-lspconfig.nvim",
	dependencies = {
		{ "williamboman/mason.nvim", opts = {} },
		{ "neovim/nvim-lspconfig" },
		{ "github/copilot.vim" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "https://git.sr.ht/~whynothugo/lsp_lines.nvim", opts = {} },
	},

	opts = {
		ensure_installed = { "rust_analyzer", "lua_ls", "clangd", "jdtls" },
	},

	-- lspconfig setup
	config = function()
		local lsp = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- lsp.rust_analyzer.setup({
		-- 	on_attach = require("mason-lspconfig").on_attach,
		-- 	capabilities = capabilities,
		-- 	cmd = {
		-- 		"rustup",
		-- 		"run",
		-- 		"stable",
		-- 		"rust-analyzer",
		-- 	},
		-- 	settings = {
		-- 		["rust-analyzer"] = {
		-- 			checkOnSave = {
		-- 				command = "clippy",
		-- 			},
		-- 		},
		-- 	},
		-- })

		lsp.rust_analyzer.setup({
			on_attach = require("mason-lspconfig").on_attach,
			capabilities = capabilities,
			settings = {
				["rust-analyzer"] = {
					checkOnSave = true,
					check = {
						command = "clippy",
					},
				},
			},
		})

		lsp.lua_ls.setup({
			on_attach = require("mason-lspconfig").on_attach,
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})

		lsp.jdtls.setup({
			on_attach = require("mason-lspconfig").on_attach,
			capabilities = capabilities,
		})

		lsp.clangd.setup({
			on_attach = require("mason-lspconfig").on_attach,
			capabilities = capabilities,
			cmd = { "clangd" },
		})

		lsp.pyright.setup({
			on_attach = require("mason-lspconfig").on_attach,
			capabilities = capabilities,
		})

		vim.diagnostic.config({
			virtual_text = false,
		})

		-- TODO: keymap
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Enable completion triggered by <c-x><c-o>
				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf }
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				--vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
				--vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
				--vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
				--vim.keymap.set('n', '<space>wl', function()
				--  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				--end, opts)
				vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
				vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "<Leader>l", require("lsp_lines").toggle, opts)
				-- vim.keymap.set('n', '<space>f', function()
				--   vim.lsp.buf.format { async = true }
				-- end, opts)
			end,
		})
	end,
}
