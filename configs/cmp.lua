local cmp = require "cmp"

local options = require "plugins.configs.cmp"

options.mapping = {
  ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
  ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
  ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
  ["<C-e>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
  ["<CR>"] = cmp.mapping.confirm { select = true },
}

options.sources = {
  { name = "luasnip" },
  -- Always show language server protocol based items on top.
  { name = "nvim_lsp", priority = 8 },
  { name = "buffer" },
  { name = "nvim_lua" },
  { name = "path" },
}

return options
