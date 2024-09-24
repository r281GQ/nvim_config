local M = {}

M.treesitter = {
  ensure_installed = {
    "astro",
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
    "graphql",
    "terraform",
  },
  indent = {
    enable = true,
  },
}
-- require("nvim-treesitter.configs").setup {
--   ensure_installed = { "astro", "tsx", "typescript", "html" },
--   auto_install = true,
--   highlight = {
--     enable = true,
--   },
-- }

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",

    -- c/cpp stuff
    "clangd",
    "clang-format",

    -- grammaer checker
    "ltex",

    "gopls",

    "terraformls",

    "astro",
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

return M
