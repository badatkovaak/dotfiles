local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

vim.opt.rtp:prepend(lazypath)
local utils = require("utils")

local my_plugins = {

	{
		"williamboman/mason.nvim",
		lazy = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
	},
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("alpha").setup(require("alpha.themes.dashboard").config)
		end,
	},
	-- {
	-- 	"neovim-session-manager"
	-- 	config = function()
	-- 		require("session_manager").setup({}) --(require("plugins.configs.others").nsm)
	-- 	end,
	-- },
	{
		"lukas-reineke/indent-blankline.nvim",
		lazy = true,
		init = function()
			utils.lazy_load("indent-blankline.nvim")
		end,
		opts = function()
			return require("configs").blankline
		end,
		config = function(_, opts)
			require("indent_blankline").setup(opts)
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		-- config = function()
		-- 	require("null-ls").setup(require("plugins.configs.null-ls"))
		-- end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		init = function()
			utils.load_mappings("nvimtree")
		end,
		opts = function()
			return require("configs").nvimtree
		end,
		config = function(_, opts)
			require("nvim-tree").setup(opts)
		end,
	},
	{
		"neovim/nvim-lspconfig",
		init = function()
			utils.lazy_load("nvim-lspconfig")
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		-- enabled = false,
		lazy = true,
		init = function()
			utils.lazy_load("nvim-colorizer.lua")
		end,
		config = function(_, opts)
			require("colorizer").setup(opts)
			vim.defer_fn(function()
				require("colorizer").attach_to_buffer(0)
			end, 0)
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		lazy = true,
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {},
	},
	{
		"numToStr/Comment.nvim",
		lazy = true,
		keys = {
			{ "gcc", mode = "n" },
			{ "gc", mode = "v" },
			{ "gbc", mode = "n" },
			{ "gb", mode = "v" },
		},
		init = function()
			utils.load_mappings("comment")
		end,
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"simrat39/rust-tools.nvim",
		enabled = false,
		config = function()
			require("rust-tools").setup({
				server = {
					on_attach = function(_, bufnr)
						vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
						vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
					end,
				},
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				dependencies = "rafamadriz/friendly-snippets",
				opts = { history = true, updateevents = "TextChanged,TextChangedI" },
				config = function(_, opts)
					require("configs").luasnip(opts)
				end,
			},

			{
				"windwp/nvim-autopairs",
				opts = {
					fast_wrap = {},
					disable_filetype = { "TelescopePrompt", "vim" },
				},
				config = function(_, opts)
					require("nvim-autopairs").setup(opts)

					-- setup cmp for autopairs
					local cmp_autopairs = require("nvim-autopairs.completion.cmp")
					require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
				end,
			},

			{
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-nvim-lsp",
			},
		},
		event = "InsertEnter",
		lazy = true,
		opts = function()
			local cmp = require("cmp")
			local snip_status_ok, luasnip = pcall(require, "luasnip")
			-- local lspkind_status_ok, lspkind = pcall(require, "lspkind")
			if not snip_status_ok then
				return
			end
			local border_opts = {
				border = "single",
				winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
			}

			local function has_words_before()
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			return {
				preselect = cmp.PreselectMode.None,
				-- formatting = {
				-- 	fields = { "kind", "abbr", "menu" },

				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				duplicates = {
					nvim_lsp = 1,
					luasnip = 1,
					cmp_tabnine = 1,
					buffer = 1,
					path = 1,
				},
				confirm_opts = {
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				},
				window = {
					completion = cmp.config.window.bordered(border_opts),
					documentation = cmp.config.window.bordered(border_opts),
				},
				mapping = {
					["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
					["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
					["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
					["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
					["<C-y>"] = cmp.config.disable,
					["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp", priority = 1000 },
					{ name = "luasnip", priority = 750 },
					{ name = "buffer", priority = 500 },
					{ name = "path", priority = 250 },
				}),
			}
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		lazy = true,
		opts = function()
			return require("configs").telescope_config
		end,
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = true,
		init = function()
			utils.lazy_load("nvim-treesitter")
		end,
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "lua", "rust", "toml", "python", "html" },
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				ident = { enable = true },
				rainbow = {
					enable = true,
					extended_mode = true,
					max_file_lines = nil,
				},
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",

		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		cmd = { "ToggleTerm", "TermExec" },
		lazy = true,
		opts = {
			size = 10,
			on_create = function()
				vim.opt.foldcolumn = "0"
				vim.opt.signcolumn = "no"
			end,
			open_mapping = [[<F7>]],
			shading_factor = 2,
			direction = "float",
			float_opts = {
				border = "curved",
				highlights = { border = "Normal", background = "Normal" },
			},
		},
		config = function(_, opts)
			require("toggleterm").setup(opts)
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		enable = false,
		config = function()
			require("catppuccin").setup({ integrations = {} })
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			require("tokyonight").setup({})
		end,
	},
	{
		"morhetz/gruvbox",
		enabled = false,
		lazy = false,
	},
	--{
	--	"ahmedkhalf/project.nvim",
	--	config = function()
	--		require("project_nvim").setup({})
	--		require("telescope").load_extension("projects")
	--	end,
	--},
	{
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure({
				providers = {
					"lsp",
					"treesitter",
					"regex",
				},
				delay = 100,
				filetype_overrides = {},
				filetypes_denylist = {
					"dirvish",
					"fugitive",
				},
				filetypes_allowlist = {},
				modes_denylist = {},
				modes_allowlist = {},
				providers_regex_syntax_denylist = {},
				providers_regex_syntax_allowlist = {},
				under_cursor = true,
				large_file_cutoff = nil,
				large_file_overrides = nil,
				min_count_to_highlight = 1,
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup()
		end,
	},
}

local my_opts = {
	ui = {
		icons = {
			ft = "",
			lazy = "󰂠 ",
			loaded = "",
			not_loaded = "",
		},
	},
}

require("lazy").setup(my_plugins, my_opts)

vim.cmd([[colorscheme tokyonight]])
vim.cmd("set whichwrap+=h,l,<,>,[,]")
vim.cmd("set backspace=indent,eol,start")
-- vim.cmd("set foldmethod=indent")
vim.o.relativenumber = true
vim.diagnostic.config({ signs = false })

local wk = require("which-key")
local mappings = {}
local opts = {}
wk.register(mappings, opts)

Mason_lspconfig = require("mason-lspconfig")
B = require("null-ls").builtins

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local on_attach = function(_, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

	nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")

	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, { desc = "Format current buffer with LSP" })
end

local servers = {
	bashls = {},
	cssls = {},
	html = {},
	jsonls = {},
	lemminx = {},
	gopls = {},
	pylsp = {},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
}

local config = function()
	require("mason").setup({
		ui = {
			icons = {
				package_installed = "",
				package_pending = "",
				package_uninstalled = "",
			},
			keymaps = {
				toggle_server_expand = "<CR>",
				install_server = "i",
				update_server = "u",
				check_server_version = "c",
				update_all_servers = "U",
				check_outdated_servers = "C",
				uninstall_server = "X",
				cancel_installation = "<C-c>",
			},
		},
	})

	Mason_lspconfig.setup({
		ensure_installed = vim.tbl_keys(servers),
	})

	Mason_lspconfig.setup_handlers({
		function(server_name)
			require("lspconfig")[server_name].setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = servers[server_name],
			})
		end,
	})
	-- local lsp_formatting = function(bufnr)
	-- 	vim.lsp.buf.format({
	-- 		filter = function(client)
	-- 			local lsp_formatting_denylist = {
	-- 				--eslint = true,
	-- 				--lemminx = true,
	-- 				lua_ls = true,
	-- 			}
	-- 			if lsp_formatting_denylist[client.name] then
	-- 				return false
	-- 			end
	-- 			return true
	-- 		end,
	-- 		bufnr = bufnr,
	-- 		async = false,
	-- 	})
	-- end

	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
	require("null-ls").setup({
		on_attach = function(client, bufnr)
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({ async = false })
					end,
				})
			end
		end,
		sources = {
			B.formatting.deno_fmt,
			B.formatting.prettier.with({ filetypes = { "html", "markdown", "css" } }),
			B.formatting.stylua,
			B.formatting.clang_format,
			B.formatting.autopep8,
			B.diagnostics.pylint,
			B.formatting.rustfmt,
		},
		-- debug = true,
	})
end

config()
