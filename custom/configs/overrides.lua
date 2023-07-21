local M = {}

M.treesitter = {
	ensure_installed = {
		"vim",
		"lua",
		"html",
		"css",
		"javascript",
		"typescript",
		"tsx",
		"c",
		"markdown",
		"markdown_inline",
		"haskell",
		-- "haxe",
	},
	indent = {
		enable = true,
		-- disable = {
		--   "python"
		-- },
	},
}

M.mason = {
	ensure_installed = {
		"lua-language-server",
		"stylua",
		"css-lsp",
		"html-lsp",
		"typescript-language-server",
		"deno",
		"prettier",
		-- "python-lsp-server",
		"rustfmt",
		"haxe-language-server",
		"clangd",
		"clang-format",
		"purescript-language-server",
	},
}

-- git support in nvimtree
M.nvimtree = {
	git = {
		enable = true,
	},

	renderer = {
		highlight_git = true,
		icons = {
			show = {
				git = true,
			},
		},
	},
}

return M
