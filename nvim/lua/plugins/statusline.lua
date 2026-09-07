-- lua/plugins/statusline.lua
local theme_utils = require("utils.theme-utils")

return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  opts = function()
    -- Funkcja z zabezpieczeniami
    local function get_theme()
      local ok, theme = pcall(theme_utils.get_lualine_theme)
      if not ok or not theme then
        return "catppuccin-mocha" -- domyślny motyw
      end
      return theme
    end

    return {
      options = {
        theme = get_theme,
        -- Opcjonalnie: dodaj odświeżanie co jakiś czas
        refresh = {
          statusline = 1000, -- odświeżaj co 1s jeśli motyw się zmienił
        },
      },
      sections = {
        lualine_c = { {
          'filename',
          path = 1,
        } }
      }
    }
  end,
  -- Zabezpieczenie przed błędami podczas ładowania
  config = function(_, opts)
    local ok, err = pcall(require("lualine").setup, opts)
    if not ok then
      vim.notify(string.format("Failed to setup lualine: %s", err), vim.log.levels.ERROR)
    end
  end
}
