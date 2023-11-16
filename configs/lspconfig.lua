local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- This is for UFO Folding (LSP based folding).
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

local servers = { "html", "cssls", "tsserver", "clangd", "gopls", "grammarly" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      imports = { granularity = { group = "module" }, prefix = "self" },
      procMacro = { enable = true },
    },
  },
  cmd = {
    "rustup",
    "run",
    "stable",
    "rust-analyzer",
  },
}
