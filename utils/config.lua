local M = {}

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local configs = {
  {
    "nvim",
    "~/.config/nvim/lua/custom",
  },
  -- "yabai",
  -- "tmux",
  -- "tmuxinator",
  -- "alacritty",
  -- "raycast",
  -- "lazygit",
}

local function map(tbl, f)
  local t = {}

  for k, v in pairs(tbl) do
    t[k] = f(v)
  end

  return t
end

local find_in_dotfiles = function(path, name)
  require("telescope.builtin").find_files {
    shorten_path = true,
    cwd = path,
    hidden = false,
    prompt_title = "~ dotfiles: " .. name .. " ~",
  }
end

M.get_configs = function(opts)
  opts = opts or {}
  pickers
    .new(opts, {
      prompt_title = "configuration entries",
      finder = finders.new_table {
        results = configs,
        entry_maker = function(entry)
          return {
            value = entry,
            display = entry[1],
            ordinal = entry[1],
          }
        end,
      },
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)

          local selection = action_state.get_selected_entry()

          local path = selection["value"][2]

          local name = selection["value"][1]

          find_in_dotfiles(path, name)
        end)
        return true
      end,
    })
    :find()
end

return M
