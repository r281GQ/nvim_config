local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --   "BufReadPre path/to/my-vault/**.md",
    --   "BufNewFile path/to/my-vault/**.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      -- ["gf"] = {
      --   action = function()
      --     return require("obsidian").util.gf_passthrough()
      --   end,
      --   opts = { noremap = false, expr = true, buffer = true },
      -- },
      -- Toggle check-boxes.
      ["<leader>u"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/obsidian/personal",
        },
        {
          name = "work",
          path = "~/vaults/work",
        },
      },

      -- see below for full list of options 👇
    },
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      return require "custom.configs.cmp"
    end,
  },
  -- Lua
  {
    lazy = false,
    "folke/zen-mode.nvim",
    opts = {

      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },
  {
    "folke/todo-comments.nvim",
    lazy = false,
    config = function()
      require("todo-comments").setup {}
    end,
  },
  {
    "mbbill/undotree",
    lazy = false,
  },
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    config = function()
      local actions = require "diffview.actions"

      require("diffview").setup {
        diff_binaries = false, -- Show diffs for binaries
        enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
        git_cmd = { "git" }, -- The git executable followed by default args.
        use_icons = true, -- Requires nvim-web-devicons
        show_help_hints = true, -- Show hints for how to open the help panel
        watch_index = true, -- Update views and index buffers when the git index changes.
        icons = { -- Only applies when use_icons is true.
          folder_closed = "",
          folder_open = "",
        },
        signs = { fold_closed = "", fold_open = "", done = "✓" },
        view = {
          -- Configure the layout and behavior of different types of views.
          -- Available layouts:
          --  'diff1_plain'
          --    |'diff2_horizontal'
          --    |'diff2_vertical'
          --    |'diff3_horizontal'
          --    |'diff3_vertical'
          --    |'diff3_mixed'
          --    |'diff4_mixed'
          -- For more info, see ':h diffview-config-view.x.layout'.
          default = {
            -- Config for changed files, and staged files in diff views.
            layout = "diff2_horizontal",
            winbar_info = false, -- See ':h diffview-config-view.x.winbar_info'
          },
          merge_tool = {
            -- Config for conflicted files in diff views during a merge or rebase.
            layout = "diff3_horizontal",
            disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
            winbar_info = true, -- See ':h diffview-config-view.x.winbar_info'
          },
          file_history = {
            -- Config for changed files in file history views.
            layout = "diff2_horizontal",
            winbar_info = false, -- See ':h diffview-config-view.x.winbar_info'
          },
        },
        file_panel = {
          listing_style = "tree", -- One of 'list' or 'tree'
          tree_options = { -- Only applies when listing_style is 'tree'
            flatten_dirs = true, -- Flatten dirs that only contain one single dir
            folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
          },
          win_config = { -- See ':h diffview-config-win_config'
            position = "left",
            width = 35,
            win_opts = {},
          },
        },
        file_history_panel = {
          log_options = { -- See ':h diffview-config-log_options'
            git = {
              single_file = { diff_merges = "combined" },
              multi_file = { diff_merges = "first-parent" },
            },
            hg = { single_file = {}, multi_file = {} },
          },
          win_config = { -- See ':h diffview-config-win_config'
            position = "bottom",
            height = 16,
            win_opts = {},
          },
        },
        commit_log_panel = {
          win_config = { -- See ':h diffview-config-win_config'
            win_opts = {},
          },
        },
        default_args = { -- Default args prepended to the arg-list for the listed commands
          DiffviewOpen = {},
          DiffviewFileHistory = {},
        },
        hooks = {}, -- See ':h diffview-config-hooks'
        keymaps = {
          disable_defaults = false, -- Disable the default keymaps
          view = {
            -- The `view` bindings are active in the diff buffers, only when the current
            -- tabpage is a Diffview.
            {
              "n",
              "<tab>",
              actions.select_next_entry,
              { desc = "Open the diff for the next file" },
            },
            {
              "n",
              "<s-tab>",
              actions.select_prev_entry,
              { desc = "Open the diff for the previous file" },
            },
            {
              "n",
              "gf",
              actions.goto_file,
              { desc = "Open the file in a new split in the previous tabpage" },
            },
            {
              "n",
              "<C-w><C-f>",
              actions.goto_file_split,
              { desc = "Open the file in a new split" },
            },
            {
              "n",
              "<C-w>gf",
              actions.goto_file_tab,
              { desc = "Open the file in a new tabpage" },
            },
            {
              "n",
              "<leader>e",
              actions.focus_files,
              { desc = "Bring focus to the file panel" },
            },
            {
              "n",
              "<leader>b",
              actions.toggle_files,
              { desc = "Toggle the file panel." },
            },
            {
              "n",
              "g<C-x>",
              actions.cycle_layout,
              { desc = "Cycle through available layouts." },
            },
            {
              "n",
              "[x",
              actions.prev_conflict,
              { desc = "In the merge-tool: jump to the previous conflict" },
            },
            {
              "n",
              "]x",
              actions.next_conflict,
              { desc = "In the merge-tool: jump to the next conflict" },
            },
            {
              "n",
              "<leader>co",
              actions.conflict_choose "ours",
              { desc = "Choose the OURS version of a conflict" },
            },
            {
              "n",
              "<leader>ct",
              actions.conflict_choose "theirs",
              { desc = "Choose the THEIRS version of a conflict" },
            },
            {
              "n",
              "<leader>cb",
              actions.conflict_choose "base",
              { desc = "Choose the BASE version of a conflict" },
            },
            {
              "n",
              "<leader>ca",
              actions.conflict_choose "all",
              { desc = "Choose all the versions of a conflict" },
            },
            {
              "n",
              "dx",
              actions.conflict_choose "none",
              { desc = "Delete the conflict region" },
            },
          },
          diff1 = {
            -- Mappings in single window diff layouts
            {
              "n",
              "g?",
              actions.help { "view", "diff1" },
              { desc = "Open the help panel" },
            },
          },
          diff2 = {
            -- Mappings in 2-way diff layouts
            {
              "n",
              "g?",
              actions.help { "view", "diff2" },
              { desc = "Open the help panel" },
            },
          },
          diff3 = {
            -- Mappings in 3-way diff layouts
            {
              { "n", "x" },
              "2do",
              actions.diffget "ours",
              {
                desc = "Obtain the diff hunk from the OURS version of the file",
              },
            },
            {
              { "n", "x" },
              "3do",
              actions.diffget "theirs",
              {
                desc = "Obtain the diff hunk from the THEIRS version of the file",
              },
            },
            {
              "n",
              "g?",
              actions.help { "view", "diff3" },
              { desc = "Open the help panel" },
            },
          },
          diff4 = {
            -- Mappings in 4-way diff layouts
            {
              { "n", "x" },
              "1do",
              actions.diffget "base",
              {
                desc = "Obtain the diff hunk from the BASE version of the file",
              },
            },
            {
              { "n", "x" },
              "2do",
              actions.diffget "ours",
              {
                desc = "Obtain the diff hunk from the OURS version of the file",
              },
            },
            {
              { "n", "x" },
              "3do",
              actions.diffget "theirs",
              {
                desc = "Obtain the diff hunk from the THEIRS version of the file",
              },
            },
            {
              "n",
              "g?",
              actions.help { "view", "diff4" },
              { desc = "Open the help panel" },
            },
          },
          file_panel = {
            {
              "n",
              "j",
              actions.next_entry,
              { desc = "Bring the cursor to the next file entry" },
            },
            {
              "n",
              "<down>",
              actions.next_entry,
              { desc = "Bring the cursor to the next file entry" },
            },
            {
              "n",
              "k",
              actions.prev_entry,
              { desc = "Bring the cursor to the previous file entry." },
            },
            {
              "n",
              "<up>",
              actions.prev_entry,
              { desc = "Bring the cursor to the previous file entry." },
            },
            {
              "n",
              "<cr>",
              actions.select_entry,
              { desc = "Open the diff for the selected entry." },
            },
            {
              "n",
              "o",
              actions.select_entry,
              { desc = "Open the diff for the selected entry." },
            },
            {
              "n",
              "<2-LeftMouse>",
              actions.select_entry,
              { desc = "Open the diff for the selected entry." },
            },
            {
              "n",
              "-",
              actions.toggle_stage_entry,
              { desc = "Stage / unstage the selected entry." },
            },
            { "n", "S", actions.stage_all, { desc = "Stage all entries." } },
            { "n", "U", actions.unstage_all, { desc = "Unstage all entries." } },
            {
              "n",
              "X",
              actions.restore_entry,
              { desc = "Restore entry to the state on the left side." },
            },
            {
              "n",
              "L",
              actions.open_commit_log,
              { desc = "Open the commit log panel." },
            },
            {
              "n",
              "<c-b>",
              actions.scroll_view(-0.25),
              { desc = "Scroll the view up" },
            },
            {
              "n",
              "<c-f>",
              actions.scroll_view(0.25),
              { desc = "Scroll the view down" },
            },
            {
              "n",
              "<tab>",
              actions.select_next_entry,
              { desc = "Open the diff for the next file" },
            },
            {
              "n",
              "<s-tab>",
              actions.select_prev_entry,
              { desc = "Open the diff for the previous file" },
            },
            {
              "n",
              "gf",
              actions.goto_file,
              { desc = "Open the file in a new split in the previous tabpage" },
            },
            {
              "n",
              "<C-w><C-f>",
              actions.goto_file_split,
              { desc = "Open the file in a new split" },
            },
            {
              "n",
              "<C-w>gf",
              actions.goto_file_tab,
              { desc = "Open the file in a new tabpage" },
            },
            {
              "n",
              "i",
              actions.listing_style,
              { desc = "Toggle between 'list' and 'tree' views" },
            },
            {
              "n",
              "f",
              actions.toggle_flatten_dirs,
              { desc = "Flatten empty subdirectories in tree listing style." },
            },
            {
              "n",
              "R",
              actions.refresh_files,
              { desc = "Update stats and entries in the file list." },
            },
            {
              "n",
              "<leader>e",
              actions.focus_files,
              { desc = "Bring focus to the file panel" },
            },
            {
              "n",
              "<leader>b",
              actions.toggle_files,
              { desc = "Toggle the file panel" },
            },
            {
              "n",
              "g<C-x>",
              actions.cycle_layout,
              { desc = "Cycle available layouts" },
            },
            {
              "n",
              "[x",
              actions.prev_conflict,
              { desc = "Go to the previous conflict" },
            },
            {
              "n",
              "]x",
              actions.next_conflict,
              { desc = "Go to the next conflict" },
            },
            {
              "n",
              "g?",
              actions.help "file_panel",
              { desc = "Open the help panel" },
            },
          },
          file_history_panel = {
            { "n", "g!", actions.options, { desc = "Open the option panel" } },
            {
              "n",
              "<C-A-d>",
              actions.open_in_diffview,
              { desc = "Open the entry under the cursor in a diffview" },
            },
            {
              "n",
              "y",
              actions.copy_hash,
              { desc = "Copy the commit hash of the entry under the cursor" },
            },
            { "n", "L", actions.open_commit_log, { desc = "Show commit details" } },
            { "n", "zR", actions.open_all_folds, { desc = "Expand all folds" } },
            { "n", "zM", actions.close_all_folds, { desc = "Collapse all folds" } },
            {
              "n",
              "j",
              actions.next_entry,
              { desc = "Bring the cursor to the next file entry" },
            },
            {
              "n",
              "<down>",
              actions.next_entry,
              { desc = "Bring the cursor to the next file entry" },
            },
            {
              "n",
              "k",
              actions.prev_entry,
              { desc = "Bring the cursor to the previous file entry." },
            },
            {
              "n",
              "<up>",
              actions.prev_entry,
              { desc = "Bring the cursor to the previous file entry." },
            },
            {
              "n",
              "<cr>",
              actions.select_entry,
              { desc = "Open the diff for the selected entry." },
            },
            {
              "n",
              "o",
              actions.select_entry,
              { desc = "Open the diff for the selected entry." },
            },
            {
              "n",
              "<2-LeftMouse>",
              actions.select_entry,
              { desc = "Open the diff for the selected entry." },
            },
            {
              "n",
              "<c-b>",
              actions.scroll_view(-0.25),
              { desc = "Scroll the view up" },
            },
            {
              "n",
              "<c-f>",
              actions.scroll_view(0.25),
              { desc = "Scroll the view down" },
            },
            {
              "n",
              "<tab>",
              actions.select_next_entry,
              { desc = "Open the diff for the next file" },
            },
            {
              "n",
              "<s-tab>",
              actions.select_prev_entry,
              { desc = "Open the diff for the previous file" },
            },
            {
              "n",
              "gf",
              actions.goto_file,
              { desc = "Open the file in a new split in the previous tabpage" },
            },
            {
              "n",
              "<C-w><C-f>",
              actions.goto_file_split,
              { desc = "Open the file in a new split" },
            },
            {
              "n",
              "<C-w>gf",
              actions.goto_file_tab,
              { desc = "Open the file in a new tabpage" },
            },
            {
              "n",
              "<leader>e",
              actions.focus_files,
              { desc = "Bring focus to the file panel" },
            },
            {
              "n",
              "<leader>b",
              actions.toggle_files,
              { desc = "Toggle the file panel" },
            },
            {
              "n",
              "g<C-x>",
              actions.cycle_layout,
              { desc = "Cycle available layouts" },
            },
            {
              "n",
              "g?",
              actions.help "file_history_panel",
              { desc = "Open the help panel" },
            },
          },
          option_panel = {
            {
              "n",
              "<tab>",
              actions.select_entry,
              { desc = "Change the current option" },
            },
            { "n", "q", actions.close, { desc = "Close the panel" } },
            {
              "n",
              "g?",
              actions.help "option_panel",
              { desc = "Open the help panel" },
            },
          },
          help_panel = {
            { "n", "q", actions.close, { desc = "Close help menu" } },
            { "n", "<esc>", actions.close, { desc = "Close help menu" } },
          },
        },
      }
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require "statuscol.builtin"

          require("statuscol").setup {
            relculright = true,
            segments = {
              { text = { "%s" }, click = "v:lua.ScSa" },
              { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
              { text = { " ", builtin.foldfunc, " " }, click = "v:lua.ScFa" },
            },
          }
        end,
      },
    },
    event = "BufRead",
    keys = {
      {
        "zR",
        function()
          require("ufo").openAllFolds()
        end,
      },
      {
        "zM",
        function()
          require("ufo").closeAllFolds()
        end,
      },
      {
        "K",
        function()
          local winid = require("ufo").peekFoldedLinesUnderCursor()
          if not winid then
            vim.lsp.buf.hover()
          end
        end,
      },
    },
    config = function()
      -- Fold options.
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      require("ufo").setup {
        provider_selector = function(_, filetype)
          -- No LSP for markdown / telekasten, use treesitter based foldings.
          if filetype == "telekasten" or filetype == "markdown" or filetype == "md" then
            return { "treesitter", "indent" }
          end

          -- Otherwiser use LSP.
          return { "lsp" }
        end,
      }
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup()
    end,
  },
  {
    "ThePrimeagen/harpoon",
    config = function()
      require("harpoon").setup {
        global_settings = {
          -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
          save_on_toggle = false,

          -- saves the harpoon file upon every change. disabling is unrecommended.
          save_on_change = true,

          -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
          enter_on_sendcmd = true,

          -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
          tmux_autoclose_windows = false,

          -- filetypes that you want to prevent from adding to the harpoon list menu.
          excluded_filetypes = { "harpoon" },

          -- set marks specific to each git branch inside git repository
          mark_branch = false,
        },
      }
    end, -- Override to setup mason-lspconfig
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      pickers = {
        buffers = {
          mappings = {
            i = { ["<c-d>"] = require("telescope.actions").delete_buffer + require("telescope.actions").move_to_top },
          },
        },
      },
      defaults = {
        mappings = {
          i = {
            ["<c-k>"] = require("telescope.actions").move_selection_previous,
            ["<c-j>"] = require("telescope.actions").move_selection_next,
            ["<leader>p"] = require("telescope.actions").send_selected_to_qflist
              + require("telescope.actions").open_qflist,
            ["<c-n>"] = require("telescope.actions").preview_scrolling_down,
            ["<c-p>"] = require("telescope.actions").preview_scrolling_up,
            ["<c-h>"] = require("telescope.actions").select_horizontal,
          },
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  -- {
  --   "renerocksai/telekasten.nvim",
  --   config = function()
  --     local home = vim.fn.expand "~/digital_garden/"
  --
  --     require("telekasten").setup {
  --
  --       home = home,
  --
  --       -- if true, telekasten will be enabled when opening a note within the configured home
  --       take_over_my_home = true,
  --
  --       -- auto-set telekasten filetype: if false, the telekasten filetype will not be used
  --       --                               and thus the telekasten syntax will not be loaded either
  --       auto_set_filetype = false,
  --
  --       -- dir names for special notes (absolute path or subdir name)
  --       dailies = home .. "/" .. "daily",
  --       weeklies = home .. "/" .. "weekly",
  --       templates = home .. "/" .. "templates",
  --
  --       -- image (sub)dir for pasting
  --       -- dir name (absolute path or subdir name)
  --       -- or nil if pasted images shouldn't go into a special subdir
  --       image_subdir = "img",
  --
  --       -- markdown file extension
  --       extension = ".md",
  --
  --       -- Generate note filenames. One of:
  --       -- "title" (default) - Use title if supplied, uuid otherwise
  --       -- "uuid" - Use uuid
  --       -- "uuid-title" - Prefix title by uuid
  --       -- "title-uuid" - Suffix title with uuid
  --       new_note_filename = "title",
  --
  --       --[[ file UUID type
  --       - "rand"
  --       - string input for os.date()
  --       - or custom lua function that returns a string
  --   --]]
  --       uuid_type = "%Y%m%d%H%M",
  --       -- UUID separator
  --       uuid_sep = "-",
  --
  --       -- following a link to a non-existing note will create it
  --       follow_creates_nonexisting = true,
  --       dailies_create_nonexisting = true,
  --       weeklies_create_nonexisting = true,
  --
  --       -- skip telescope prompt for goto_today and goto_thisweek
  --       journal_auto_open = false,
  --
  --       -- template for new notes (new_note, follow_link)
  --       -- set to `nil` or do not specify if you do not want a template
  --       template_new_note = home .. "/" .. "templates/new_note.md",
  --
  --       -- template for newly created daily notes (goto_today)
  --       -- set to `nil` or do not specify if you do not want a template
  --       template_new_daily = home .. "/" .. "templates/daily.md",
  --
  --       -- template for newly created weekly notes (goto_thisweek)
  --       -- set to `nil` or do not specify if you do not want a template
  --       template_new_weekly = home .. "/" .. "templates/weekly.md",
  --
  --       -- image link style
  --       -- wiki:     ![[image name]]
  --       -- markdown: ![](image_subdir/xxxxx.png)
  --       image_link_style = "markdown",
  --
  --       -- default sort option: 'filename', 'modified'
  --       sort = "filename",
  --
  --       -- integrate with calendar-vim
  --       plug_into_calendar = true,
  --       calendar_opts = {
  --         -- calendar week display mode: 1 .. 'WK01', 2 .. 'WK 1', 3 .. 'KW01', 4 .. 'KW 1', 5 .. '1'
  --         weeknm = 4,
  --         -- use monday as first day of week: 1 .. true, 0 .. false
  --         calendar_monday = 1,
  --         -- calendar mark: where to put mark for marked days: 'left', 'right', 'left-fit'
  --         calendar_mark = "left-fit",
  --       },
  --
  --       -- telescope actions behavior
  --       close_after_yanking = false,
  --       insert_after_inserting = true,
  --
  --       -- tag notation: '#tag', ':tag:', 'yaml-bare'
  --       tag_notation = "#tag",
  --
  --       -- command palette theme: dropdown (window) or ivy (bottom panel)
  --       command_palette_theme = "ivy",
  --
  --       -- tag list theme:
  --       -- get_cursor: small tag list at cursor; ivy and dropdown like above
  --       show_tags_theme = "ivy",
  --
  --       -- when linking to a note in subdir/, create a [[subdir/title]] link
  --       -- instead of a [[title only]] link
  --       subdirs_in_links = false,
  --
  --       -- template_handling
  --       -- What to do when creating a new note via `new_note()` or `follow_link()`
  --       -- to a non-existing note
  --       -- - prefer_new_note: use `new_note` template
  --       -- - smart: if day or week is detected in title, use daily / weekly templates (default)
  --       -- - always_ask: always ask before creating a note
  --       template_handling = "smart",
  --
  --       -- path handling:
  --       --   this applies to:
  --       --     - new_note()
  --       --     - new_templated_note()
  --       --     - follow_link() to non-existing note
  --       --
  --       --   it does NOT apply to:
  --       --     - goto_today()
  --       --     - goto_thisweek()
  --       --
  --       --   Valid options:
  --       --     - smart: put daily-looking notes in daily, weekly-looking ones in weekly,
  --       --              all other ones in home, except for notes/with/subdirs/in/title.
  --       --              (default)
  --       --
  --       --     - prefer_home: put all notes in home except for goto_today(), goto_thisweek()
  --       --                    except for notes with subdirs/in/title.
  --       --
  --       --     - same_as_current: put all new notes in the dir of the current note if
  --       --                        present or else in home
  --       --                        except for notes/with/subdirs/in/title.
  --       new_note_location = "smart",
  --
  --       -- should all links be updated when a file is renamed
  --       rename_update_links = true,
  --
  --       vaults = {
  --         vault2 = {
  --           -- alternate configuration for vault2 here. Missing values are defaulted to
  --           -- default values from telekasten.
  --           -- e.g.
  --           -- home = "/home/user/vaults/personal",
  --         },
  --       },
  --
  --       -- how to preview media files
  --       -- "telescope-media-files" if you have telescope-media-files.nvim installed
  --       -- "catimg-previewer" if you have catimg installed
  --       media_previewer = "telescope-media-files",
  --
  --       -- A customizable fallback handler for urls.
  --       follow_url_fallback = nil,
  --     }
  --   end,
  -- },
}

return plugins
