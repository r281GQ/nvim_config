local null_ls = require "null-ls"

local b = null_ls.builtins

local sources = {
  -- Use "prettierd".
  b.formatting.prettierd.with {
    filetypes = {
      "html",
      "markdown",
      "css",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "graphql",
    },
  },

  b.diagnostics.eslint_d,

  -- Lua.
  b.formatting.stylua,

  -- Cpp.
  b.formatting.clang_format,
  b.formatting.goimports,
  b.diagnostics.actionlint,

  -- Rust formatter.
  b.formatting.rustfmt.with {
    extra_args = { "--edition=2021" },
  },
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local opts = { noremap = true, silent = true }

null_ls.setup {
  debug = true,
  sources = sources,
  on_attach = function(client, bufnr)
    -- Explicitly attach "code_action" on null-ls.
    -- Some files (like markdown) does not have LSP attached, so otherwise we would not get code_action.
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

    -- This sets up formatting on save.
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format {
            bufnr = bufnr,
            filter = function(c)
              return c.name == "null-ls"
            end,
          }
        end,
      })
    end
  end,
}
