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
        "odin",
        "ocaml",
        "zig",
        "svelte",
        "dart",
        "zig",
        "xml",
        -- "idris",
        -- "haxe",
    },
    -- autotag = {
    --     enable = true,
    -- },
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = "<c-s>",
            node_decremental = "<c-backspace>",
        },
    },
    -- textobjects = {
    -- 	select = {
    -- 		enable = true,
    -- 		lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
    -- 		keymaps = {
    -- 			-- You can use the capture groups defined in textobjects.scm
    -- 			["aa"] = "@parameter.outer",
    -- 			["ia"] = "@parameter.inner",
    -- 			["af"] = "@function.outer",
    -- 			["if"] = "@function.inner",
    -- 			["ac"] = "@class.outer",
    -- 			["ic"] = "@class.inner",
    -- 		},
    -- 	},
    -- 	move = {
    -- 		enable = true,
    -- 		set_jumps = true, -- whether to set jumps in the jumplist
    -- 		goto_next_start = {
    -- 			["]m"] = "@function.outer",
    -- 			["]]"] = "@class.outer",
    -- 		},
    -- 		goto_next_end = {
    -- 			["]M"] = "@function.outer",
    -- 			["]["] = "@class.outer",
    -- 		},
    -- 		goto_previous_start = {
    -- 			["[m"] = "@function.outer",
    -- 			["[["] = "@class.outer",
    -- 		},
    -- 		goto_previous_end = {
    -- 			["[M"] = "@function.outer",
    -- 			["[]"] = "@class.outer",
    -- 		},
    -- 	},
    -- 	swap = {
    -- 		enable = true,
    -- 		swap_next = {
    -- 			["<leader>a"] = "@parameter.inner",
    -- 		},
    -- 		swap_previous = {
    -- 			["<leader>A"] = "@parameter.inner",
    -- 		},
    -- 	},
    -- },
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

M.telescope = {
    defaults = {
        sorting_strategy = "descending",
        layout_config = {
            horizontal = {
                prompt_position = "bottom",
            },
        },
    },
}

return M
