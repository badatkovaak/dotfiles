local options = {
    formatters_by_ft = {
        css = { "deno_fmt" },
        html = { "deno_fmt" },
        javascript = { "deno_fmt" },
        typescript = { "deno_fmt" },
        lua = { "stylua" },
        python = { "ruff_format" },
        cs = { "csharpier", lsp_format = "fallback" },
        rust = { "rustfmt", lsp_format = "fallback" },
        c = { "clang-format", lsp_format = "never" },
        h = { "clang-format", lsp_format = "never" },
        cpp = { "clang-format", lsp_format = "never" },
        xml = { "xmlformatter" },
        asm = { "asmfmt" },
        kotlin = { "ktlint" },
        php = { "pretty-php" },
        twig = { "djlint" },
        ["_"] = { "trim_whitespace" },
    },

    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 5000,
        lsp_fallback = false,
    },

    formatters = {
        clang_format = {
            append_args = { "--style={BasedOnStyle : Google, IndentWidth : 4}" },
        },
        xmlformatter = {
            prepend_args = { "--indent", "4", "--selfclose" },
        },
        deno_fmt = {
            append_args = { "--indent-width", "4" },
        },
        ktfmt = {
            prepend_args = { "--kotlinlang-style" },
        },
        djlint = {
            command = "djlint",
            prepend_args = { "--extension=html.twig", "--reformat", "$FILENAME" },
        },

        -- ktlint = {
        --     append_args = { "-- },
        -- },
    },
}

return options
