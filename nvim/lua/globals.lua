-- lua/globals.lua
local M = {}

-- Motywy Catppuccin (wspólne dla colorscheme i lualine)
M.THEMES = {
  dark = "catppuccin-mocha",
  light = "catppuccin-latte"
}

M.DEFAULT_THEME = "dark"

-- Flavour Catppuccin
M.CATPPUCCIN_FLAVOURS = {
  dark = "mocha",
  light = "latte"
}

return M
