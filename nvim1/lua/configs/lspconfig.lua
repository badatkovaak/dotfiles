-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

local servers = {
    "html",
    "cssls",
    "ts_ls",
    "clangd",
    "pyright",
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
    "tailwindcss",
    -- "texlab",
    -- "dartls",
    -- "idris2_lsp",
}

local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = nvlsp.on_attach,
        on_init = nvlsp.on_init,
        capabilities = nvlsp.capabilities,
    }
end

lspconfig["texlab"].setup {
    on_attach = nvlsp.on_attach,
    capabilities = nvlsp.capabilities,
    settings = { texlab = { build = { onSave = true } } },
}

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
