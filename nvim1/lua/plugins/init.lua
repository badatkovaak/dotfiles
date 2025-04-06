local overrides = require "overrides"

return {
    {
        "stevearc/conform.nvim",
        event = "BufWritePre", -- uncomment for format on save
        opts = require "configs.conform",
    },

    -- These are some examples, uncomment them if you want to see them work!
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "configs.lspconfig"
        end,
    },

    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvimtools/none-ls-extras.nvim" },
        ft = { "python" },
        config = function()
            require "configs.null-ls"
        end,
    },

    -- Override plugin definition options

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
            require("nvim-ts-autotag").setup {
                opts = { enable_close_on_slash = true },
            }
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
            require("telescope").load_extension "fzf"
        end,
    },
    {
        "ThePrimeagen/harpoon",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("harpoon").setup {
                menu = {
                    width = vim.api.nvim_win_get_width(0) - 4,
                    height = vim.api.nvim_win_get_height(0) - 4,
                },
            }
            require("telescope").load_extension "harpoon"
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
            require("idris2").setup {
                server = {
                    on_attach = require("plugins.configs.lspconfig").on_attach,
                    -- capabilities = require("plugins.configs.lspconfig").capabilities,
                },
            }
        end,
    },
    {
        "akinsho/flutter-tools.nvim",
        ft = "dart",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "stevearc/dressing.nvim", -- optional for vim.ui.select
        },
        config = function()
            require("flutter-tools").setup {}
        end,
    },
    {
        "Hoffs/omnisharp-extended-lsp.nvim",
        lazy = true,
        ft = "cs",
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
