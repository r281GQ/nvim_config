local M = {}

-- TODO: Make dotfile path configurable.
M.find_in_dotfiles = function()
  require("telescope.builtin").find_files {
    shorten_path = true,
    cwd = "~/.config/",
    hidden = true,
    prompt_title = "~ dotfiles ~",
  }
end

return M
