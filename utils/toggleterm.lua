local M = {}

local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new {
  cmd = "lazygit",
  direction = "float",
  float_opts = {
    -- The border key is *almost* the same as 'nvim_open_win'
    -- see :h nvim_open_win for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    border = "double",
    height = 100,
  },
}

local nnn = Terminal:new {
  cmd = "nnn",
  direction = "float",
  float_opts = {
    -- The border key is *almost* the same as 'nvim_open_win'
    -- see :h nvim_open_win for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    border = "double",
    height = 100,
  },
}

local btm = Terminal:new {
  cmd = "btm",
  direction = "float",
  float_opts = {
    -- The border key is *almost* the same as 'nvim_open_win'
    -- see :h nvim_open_win for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    border = "double",
    height = 100,
  },
}

M.toggle_lazy_git = function()
  lazygit:toggle()
end

M.toggle_btm = function()
  btm:toggle()
end

M.toggle_nnn = function()
  nnn:toggle()
end

return M
