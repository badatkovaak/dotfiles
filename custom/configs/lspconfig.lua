local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

local servers = {
	"html",
	"cssls",
	"tsserver",
	"clangd",
	"pylsp",
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
	-- "dartls",
	-- "idris2_lsp",
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

-- lspconfig.pyright.setup { blabla}
