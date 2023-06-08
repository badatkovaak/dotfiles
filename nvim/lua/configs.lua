local M = {}

M.lspconfig = function() end
M.blankline = {
	indentLine_enabled = 1,
	filetype_exclude = {
		"help",
		"terminal",
		"lazy",
		"lspinfo",
		"TelescopePrompt",
		"TelescopeResults",
		"mason",
		"alpha",
		"",
	},
	buftype_exclude = { "terminal" },
	show_trailing_blankline_indent = false,
	show_first_indent_level = false,
	show_current_context = true,
	show_current_context_start = true,
}

M.luasnip = function(opts)
	require("luasnip").config.set_config(opts)
	require("luasnip.loaders.from_vscode").lazy_load()
	require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.g.vscode_snippets_path or "" })
	require("luasnip.loaders.from_snipmate").load()
	require("luasnip.loaders.from_snipmate").lazy_load({ paths = vim.g.snipmate_snippets_path or "" })
	require("luasnip.loaders.from_lua").load()
	require("luasnip.loaders.from_lua").lazy_load({ paths = vim.g.lua_snippets_path or "" })

	vim.api.nvim_create_autocmd("InsertLeave", {
		callback = function()
			if
				require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
				and not require("luasnip").sessiion.jump_active
			then
				require("luasnip").unlink_current()
			end
		end,
	})
end

M.telescope_config = {
	defaults = {
		vimgrep_arguments = {
			"rg",
			"-L",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		prompt_prefix = "   ",
		selection_caret = "  ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
				results_width = 0.8,
			},
			vertical = {
				mirror = false,
			},
			width = 0.87,
			height = 0.80,
			preview_cutoff = 120,
		},
		--file_sorter = require("telescope.sorters").get_fuzzy_file,
		file_ignore_patterns = { "node_modules" },
		--generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		path_display = { "truncate" },
		winblend = 0,
		border = {},
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		color_devicons = true,
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		--file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		--grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		--qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		-- Developer configurations: Not meant for general override
		--buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
		--mappings = {
		--  n = { ["q"] = require("telescope.actions").close },
		--},
	},

	extensions_list = { "themes", "terms" },
}

return M
