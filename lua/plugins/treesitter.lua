return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		opts = {
			ensure_installed = {
				"vim",
				"lua",
				"vimdoc",
				"html",
				"css",
				"go",
				"python",
				"javascript",
				"json",
				"yaml",
			},
			highlight = {
				enable = true,
			},
		},
		config = function(_, opts)
			local ok, configs = pcall(require, "nvim-treesitter.configs")
			if not ok then
				return
			end
			configs.setup(opts)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		lazy = false,
		priority = 900,
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
}
