local present, null_ls = pcall(require, "null-ls")

if not present then
	return
end

local b = null_ls.builtins

local sources = {

	b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
	b.formatting.prettier.with({ filetypes = { "html", "markdown", "css" } }), -- so prettier works only on these filetypes

	b.formatting.stylua,
	b.formatting.rustfmt,
	b.formatting.haxe_formatter,
	b.formatting.stylish_haskell,

	b.formatting.clang_format,
	b.formatting.autopep8,
	b.diagnostics.pylint,
	b.formatting.gofmt,
}

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			local lsp_formatting_denylist = {
				eslint = true,
				lemminx = true,
				lua_ls = true,
				pylsp = true,
			}
			if lsp_formatting_denylist[client.name] then
				return false
			end
			return true
		end,
		bufnr = bufnr,
		async = false,
	})
end
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
require("null-ls").setup({
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr)
					-- vim.lsp.buf.format { async = false }
				end,
			})
		end
	end,
	debug = true,
	sources = sources,
})
