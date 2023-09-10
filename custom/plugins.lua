local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

	-- Override plugin definition options

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- format & linting
			{
				"jose-elias-alvarez/null-ls.nvim",
				config = function()
					require("custom.configs.null-ls")
				end,
			},
		},
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end, -- Override to setup mason-lspconfig
	},

	-- override plugin configs
	{
		"williamboman/mason.nvim",
		opts = overrides.mason,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = overrides.treesitter,
	},

	{
		"nvim-tree/nvim-tree.lua",
		opts = overrides.nvimtree,
	},
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
		end,
	},
	{
		"windwp/nvim-ts-autotag",
        event = "InsertEnter",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		opts = overrides.telescope,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		config = function()
			require("telescope").load_extension("fzf")
		end,
	},
	{
		"ThePrimeagen/harpoon",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("harpoon").setup({
				menu = {
					width = vim.api.nvim_win_get_width(0) - 4,
					height = vim.api.nvim_win_get_height(0) - 4,
				},
			})
			require("telescope").load_extension("harpoon")
		end,
	},
	{
		"ggandor/leap.nvim",
		dependencies = {
			"tpope/vim-repeat",
		},
		lazy = false,
		config = function()
			require("leap").add_default_mappings(true)
		end,
	},
	{
		"ShinKage/idris2-nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		ft = "idris2",
		config = function()
			require("idris2").setup({
				server = {
					on_attach = require("plugins.configs.lspconfig").on_attach,
					-- capabilities = require("plugins.configs.lspconfig").capabilities,
				},
			})
		end,
	},
	{
		"akinsho/flutter-tools.nvim",
		-- lazy = true,
		ft = "dart",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim", -- optional for vim.ui.select
		},
		config = function()
			require("flutter-tools").setup({})
		end,
	},
	-- {
	--   "kevinhwang91/nvim-ufo",
	--   lazy = false,
	--   dependencies = { "kevinhwang91/promise-async" },
	--   config = function()
	--     -- use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
	--     require("ufo").setup {
	--       provider_selector = function(bufnr, filetype, buftype)
	--         return { "treesitter", "indent" }
	--       end,
	--     }
	--   end,
	-- },

	-- To make a plugin not be loaded
	-- {
	--   "NvChad/nvim-colorizer.lua",
	--   enabled = false
	-- },

	-- All NvChad plugins are lazy-loaded by default
	-- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
	-- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
	-- {
	--   "mg979/vim-visual-multi",
	--   lazy = false,
	-- }
}

return plugins
