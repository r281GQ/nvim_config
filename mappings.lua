---@type MappingsTable
local M = {}

M.disabled = {
  n = {
    ["<leader>dm"] = "",
    ["<leader>e"] = "",
    ["<leader>cc"] = "",
    ["<leader>fs"] = "",
    ["<leader>/"] = "",
    ["<C-a>"] = "",
    ["<C-h>"] = "",
    ["<C-l>"] = "",
  },
  v = {
    [">"] = { ">gv", "indent"},
  },
}

M.general = {
  n = {
    -- Split navigation.
    ["<leader>wh"] = {
      "<C-w>h",
      "go to left split",
    },
    ["<leader>wl"] = {
      "<C-w>l",
      "go to right split",
    },
    ["<leader>wk"] = {
      "<C-w>k",
      "go to bottom split",
    },
    ["<leader>wj"] = {
      "<C-w>j",
      "go to top split",
    },

    -- Tabs.
    ["<c-c>"] = {
      ":tabclose<CR>",
      "close tab",
    },

    ["<leader>+"] = {
      function()
        vim.cmd.UndotreeToggle()
      end,
      "toggle Undotree",
    },

    -- Diffview.
    ["<leader>dm"] = {
      "<cmd> DiffviewOpen main<CR>",
      "diff againt main",
    },
    ["<leader>dw"] = {
      "<cmd> DiffviewOpen<CR>",
      "diff againt working folder",
    },

    -- LSP.
    ["gd"] = {
      function()
        if vim.bo.filetype == "markdown" or vim.bo.filetype == "telekasten" then
          require("telekasten").follow_link()
        else
          vim.lsp.buf.definition()
        end
      end,
      "lsp go to definition",
    },

    -- Buffers.
    ["<leader>td"] = { "<cmd>bw<CR>", "close current buffer", opts = { nowait = true } },
    ["<leader>tw"] = { "<CMD>%bd|e#|bd#<CR>", "close all buffers except current one", opts = { nowait = true } },

    -- Quickfix.
    ["<leader>cc"] = {
      ":cclose <CR>",
      "close quickfix",
    },
    ["<leader>cn"] = { "<cmd>cnext<CR>", "jump to next item in quickfix", opts = { nowait = true } },
    ["<leader>cp"] = { "<cmd>cprev<CR>", "jump to prev item in quickfix", opts = { nowait = true } },
    -- LocalList.
    ["<leader>lc"] = { ":lclose<CR>", "close local list", opts = { nowait = true } },
    ["<leader>ln"] = { "<cmd>lnext<CR>", "jump to next item in locallist", opts = { nowait = true } },
    ["<leader>lp"] = { "<cmd>lprev<CR>", "jump to prev item in locallist", opts = { nowait = true } },

    -- Harpoon.
    ["<leader>.1"] = {
      "<cmd> lua require('harpoon.tmux').sendCommand('{right-of}', 1)<CR>",
      "execute harpoon command 1",
    },
    ["<leader>.2"] = {
      "<cmd> lua require('harpoon.tmux').sendCommand('{right-of}', 2)<CR>",
      "execute harpoon command 2",
    },
    ["<leader>.3"] = {
      "<cmd> lua require('harpoon.tmux').sendCommand('{right-of}', 3)<CR>",
      "execute harpoon command 3",
    },
    ["<leader>.4"] = {
      "<cmd> lua require('harpoon.tmux').sendCommand('{right-of}', 4)<CR>",
      "execute harpoon command 4",
    },
    ["<leader>.."] = {
      "<cmd> lua require('harpoon.cmd-ui').toggle_quick_menu()<CR>",
      "bring up harpoon command palette",
    },
    ["<leader>a"] = {
      "<cmd> lua require('harpoon.mark').add_file()<CR>",
      "add file to harpoon buffer list",
    },
    ["<leader>p"] = {
      "<cmd> lua require('harpoon.ui').toggle_quick_menu()<CR>",
      "show harpoon buffer list",
    },
    ["<c-o>"] = {
      "<cmd> lua require('harpoon.ui').nav_prev()<CR>",
      "harpoon next item",
    },
    ["<c-i>"] = {
      "<cmd> lua require('harpoon.ui').nav_next()<CR>",
      "harpoon prev item",
    },

    -- Telescope.
    ["<leader>vc"] = {
      function()
        require("utils.telescope").find_in_dotfiles()
      end,
      "telescope - fuzzy find current buffer",
      opts = {
        nowait = true,
      },
    },
    ["<leader>/"] = {
      function()
        require("telescope.builtin").current_buffer_fuzzy_find { sorting_strategy = "ascending" }
      end,
      "telescope - fuzzy find current buffer",
      opts = {
        nowait = true,
      },
    },
    ["<leader>fg"] = {
      function()
        require("telescope.builtin").live_grep()
      end,
      "telescope - live grep",
      opts = {
        nowait = true,
      },
    },
    ["<leader>fs"] = {
      function()
        require("telescope.builtin").lsp_document_symbols()
      end,
      "telescope - find lsp symbols",
      opts = {
        nowait = true,
      },
    },

    -- Comment.
    ["<leader>§"] = {
      function()
        require("Comment.api").toggle.linewise()
      end,
      "toggle comment",
      opts = {
        nowait = true,
      },
    },

    -- Telekasten.
    ["<leader>jj"] = {
      function()
        require("telekasten").panel()
      end,
      "telekasten panel",
      opts = { nowait = true },
    },
    ["<leader>jt"] = {
      function()
        require("telekasten").goto_today()
      end,
      "telekasten panel",
      opts = { nowait = true },
    },

    -- Todo Comment.
    ["<leader>tt"] = {
      ": TodoTelescope keywords=TODO<CR>",
      "todo telescope todo",
      opts = { nowait = true },
    },
    ["<leader>tn"] = {
      ": TodoTelescope keywords=NOTE<CR>",
      "todo telescope note",
      opts = { nowait = true },
    },

    -- MarkdownPreview.
    ["<leader>m"] = {
      ":MarkdownPreview<cr>",
      "toggle markdown preview",
      opts = { nowait = true },
    },

    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>e"] = {
      function()
        vim.diagnostic.open_float()
      end,
      "show inline diagnostic",
      opts = { nowait = true },
    },
  },
  i = {
    -- Quick escape mode.
    ["kj"] = { "<Esc>", "escape normal mode", opts = { nowait = true } },
    ["jj"] = { "<Esc>", "escape normal mode", opts = { nowait = true } },
  },
  c = {
    -- Convinience remaps around save and exit.
    ["WQ"] = { "wq", "save and quit", opts = { nowait = true } },
    ["Wq"] = { "wq", "save and quit", opts = { nowait = true } },
    ["W"] = { "w", "save", opts = { nowait = true } },
    ["Q"] = { "q", "quit", opts = { nowait = true } },
  },
  v = {
    ["<leader>§"] = {
      function()
        require("Comment.api").toggle.linewise(vim.fn.visualmode())
      end,
      "toggle comment",
    },
  },
}

M.lspconfig = {
  n = {
    ["<leader>rn"] = {
      function()
        require("nvchad_ui.renamer").open()
      end,
      "lsp rename",
    },
  },
}

M.gitsigns = {
  plugin = true,
  n = {

    -- Navigation through hunks.
    ["<c-j>"] = {
      function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          require("gitsigns").next_hunk()
        end)
        return "<Ignore>"
      end,
      "jump to next hunk",
      opts = { expr = true },
    },

    ["<c-k>"] = {
      function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          require("gitsigns").prev_hunk()
        end)
        return "<Ignore>"
      end,
      "jump to prev hunk",
      opts = { expr = true },
    },

    -- Actions.
    ["<leader>gr"] = {
      function()
        require("gitsigns").reset_hunk()
      end,
      "reset hunk",
    },

    ["<leader>gs"] = {
      function()
        require("gitsigns").stage_hunk()
      end,
      "stage hunk",
    },

    ["<leader>gp"] = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "preview hunk",
    },

    ["<leader>gb"] = {
      function()
        package.loaded.gitsigns.blame_line()
      end,
      "blame line",
    },
  },
}

return M
