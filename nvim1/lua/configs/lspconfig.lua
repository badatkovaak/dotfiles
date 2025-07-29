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
    "csharp_ls",
    "asm_lsp",
    -- "omnisharp",

    "texlab",
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

-- lspconfig["omnisharp"].setup {
--     on_attach = nvlsp.on_attach,
--     capabilities = nvlsp.capabilities,
--     cmd = { "/usr/bin/omnisharp" },
--     settings = { RoslynExtensionsOptions = { EnableAnalyzersSupport = false, EnableImportCompletion = true } },
--     -- handlers = {
--     --     ["textDocument/definition"] = require("omnisharp_extended").definition_handler,
--     --     ["textDocument/typeDefinition"] = require("omnisharp_extended").type_definition_handler,
--     --     ["textDocument/references"] = require("omnisharp_extended").references_handler,
--     --     ["textDocument/implementation"] = require("omnisharp_extended").implementation_handler,
--     -- },
-- }

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
