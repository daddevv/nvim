-- setup mason before configuring lsp
require("mason").setup({
	ensure_installed = {
		"lua_ls",
		"gopls",
		"rust_analyzer",
		"pyright",
		"ts_ls",
		"bashls",
		"jsonls",
	},
	icons = {
		package_installed = "✓",
		package_pending = "➜",
		package_uninstalled = "✗",
	},
})
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"gopls",
		"rust_analyzer",
		"pyright",
		"ts_ls",
		"bashls",
		"jsonls",
	},
	automatic_installation = true,
})

local lspconfig_defaults = {
	capabilities = vim.tbl_deep_extend(
		"force",
		vim.lsp.protocol.make_client_capabilities(),
		require("cmp_nvim_lsp").default_capabilities()
	),
}

local servers = {
	pyright = {
		cmd = { "pyright-langserver", "--stdio" },
		filetypes = { "python" },
		settings = {
			python = {
				analysis = {
					autoSearchPaths = true,
					diagnosticMode = "openFilesOnly",
					useLibraryCodeForTypes = true,
				},
			},
		},
	},
	bashls = {},
	jsonls = {},
	ts_ls = {},
	rust_analyzer = {},
	gopls = {
		cmd = { "gopls" },
		filetypes = { "go", "gomod", "gowork", "gotmpl" },
		single_file_support = true,
		settings = {
			gopls = {
				hints = {
					assignVariableTypes = false,
					compositeLiteralFields = true,
					compositeLiteralTypes = true,
					constantValues = true,
					functionTypeParameters = true,
					parameterNames = true,
					rangeVariableTypes = true,
				},
			},
		},
	},
	lua_ls = {
		cmd = { "lua-language-server" },
		filetypes = { "lua" },
		single_file_support = true,
		settings = {
			Lua = {
				completion = {
					callSnippet = "Replace",
				},
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false,
				},
				runtime = {
					version = "LuaJIT",
				},
			},
		},
	},
}

for server_name, server_config in pairs(servers) do
	vim.lsp.config(server_name, vim.tbl_deep_extend("force", {}, lspconfig_defaults, server_config))
	vim.lsp.enable(server_name)
end
