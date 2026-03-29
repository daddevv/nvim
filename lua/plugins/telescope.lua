return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	dependencies = {
		{ "jvgrootveld/telescope-zoxide" },
		{ "crispgm/telescope-heading.nvim" },
		{ "nvim-telescope/telescope-file-browser.nvim" },
		{ "camgraff/telescope-tmux.nvim" },
		{ "cljoly/telescope-repo.nvim" },
		{ "nvim-telescope/telescope-media-files.nvim" },
		{ "tamago324/telescope-openbrowser.nvim" },
		{ "tyru/open-browser.vim" },
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local action_state = require("telescope.actions.state")
		local sorters = require("telescope.sorters")
		local themes = require("telescope.themes")
		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-q>"] = actions.send_to_qflist,
						["<C-t>"] = actions.select_tab,
						["<C-x>"] = actions.select_horizontal,
						["<C-v>"] = actions.select_vertical,
						["<C-u>"] = actions.preview_scrolling_up,
						["<C-d>"] = actions.preview_scrolling_down,
						["<C-c>"] = actions.close,
						["<CR>"] = actions.select_default + actions.center,
					},
					n = {
						["<CR>"] = actions.select_default + actions.center,
					},
				},
			},
			extensions = {
				file_browser = {
					theme = "ivy",
					hijack_netrw = true,
					cwd_to_path = true,
					hidden = {
						file_browser = false,
						folder_browser = true,
					},
				},
				zoxide = {
					prompt_title = "[ Walking on the shoulders of TJ ]",
					mappings = {
						default = {
							after_action = function(selection)
								print("Update to (" .. selection.z_score .. ") " .. selection.path)
							end,
						},
						["<C-s>"] = {
							before_action = function(selection)
								print("before C-s")
							end,
							action = function(selection)
								vim.cmd.edit(selection.path)
							end,
						},
						["<C-q>"] = { action = z_utils.create_basic_command("split") },
					},
				},
				repo = {
					list = {
						fd_opts = {
							"--no-ignore-vcs",
						},
						search_dirs = {
							"~/projects",
						},
					},
				},
			},
		})
		require("telescope").load_extension("fzf")
		-- require("telescope").load_extension("emoji") --- emoji.lua handles loading the extension
		require("telescope").load_extension("zoxide")
		require("telescope").load_extension("heading")
		require("telescope").load_extension("file_browser")
		require("telescope").load_extension("tmux")
		require("telescope").load_extension("repo")
		require("telescope").load_extension("media_files")
		require("telescope").load_extension("openbrowser")
	end,
}
