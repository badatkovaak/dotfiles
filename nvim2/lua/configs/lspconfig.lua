require("nvchad.configs.lspconfig").defaults()

local servers = {
    "html",
    -- "cssls",
    -- "ts_ls",
    "clangd",
    -- "basedpyright",
    -- "pylsp",
    "haxe_language_server",
    "hls",
    "purescriptls",
    "gopls",
    "ols",
    "zls",
    "ocamllsp",
    "svelte",
    "clojure_lsp",
    "rust_analyzer",
    "metals",
    -- "tailwindcss",
    "csharp_ls",
    "asm_lsp",
    "phpactor",
    -- "phpantom",
    "twiggy-language-server",
    -- "omnisharp",

    -- "texlab",
    -- "kotlin_language_server",
    -- "kotlin_lsp",
    -- "dartls",
    -- "idris2_lsp",
}

vim.lsp.config["phpactor"] = {
    cmd = { "phpactor", "language-server" },
    filetypes = { "php" },
    root_markers = { ".git", "composer.json", ".phpactor.json", ".phpactor.yml" },
    workspace_required = true,
    init_options = {
        ["language_server_phpstan.enabled"] = false,
        ["language_server_psalm.enabled"] = false,
    },
}

vim.lsp.config["phpantom"] = {
    cmd = { "phpantom_lsp" },
    filetypes = { "php" },
    root_markers = { "composer.json", ".git" },
}

vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
