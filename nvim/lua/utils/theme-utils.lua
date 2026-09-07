-- lua/utils/theme-utils.lua
local M = {}
local globals = require("globals")

-- Stan
M.current_theme = globals.DEFAULT_THEME
M.is_initialized = false
M.on_theme_change = nil

-- Funkcja do pobierania systemowego motywu z zabezpieczeniami
function M.get_system_theme()
  local success, result = pcall(function()
    local handle = io.popen("darkman get 2>/dev/null")
    if not handle then
      return nil
    end

    local output = handle:read("*a")
    handle:close()

    if output then
      local theme = output:gsub("\n", ""):gsub("%s+", "")
      if theme == "dark" or theme == "light" then
        return theme
      end
    end
    return nil
  end)

  if not success or not result then
    vim.notify("Could not detect system theme, using default", vim.log.levels.WARN)
    return globals.DEFAULT_THEME
  end

  return result
end

-- Funkcja do pobierania motywu dla lualine (używa tego samego co colorscheme)
function M.get_lualine_theme()
  return globals.THEMES[M.current_theme] or globals.THEMES[globals.DEFAULT_THEME]
end

-- Funkcja do ustawiania motywu z zabezpieczeniami
function M.set_theme(theme)
  -- Walidacja
  if theme ~= "dark" and theme ~= "light" then
    vim.notify(string.format("Invalid theme '%s', using default", tostring(theme)), vim.log.levels.ERROR)
    theme = globals.DEFAULT_THEME
  end

  -- Zabezpieczenie przed rekurencją
  if M.current_theme == theme and M.is_initialized then
    return
  end

  M.current_theme = theme

  -- Ustaw flavour dla Catppuccin
  local flavour = globals.CATPPUCCIN_FLAVOURS[theme]
  if flavour then
    vim.g.catppuccin_flavour = flavour
  end

  -- Ustaw colorscheme z obsługą błędów
  local colorscheme = globals.THEMES[theme]
  if not colorscheme then
    vim.notify(string.format("No colorscheme defined for theme '%s', using default", theme), vim.log.levels.ERROR)
    colorscheme = globals.THEMES[globals.DEFAULT_THEME]
  end

  local success, err = pcall(function()
    vim.cmd(string.format("colorscheme %s", colorscheme))
  end)

  if not success then
    vim.notify(string.format("Failed to load colorscheme '%s': %s", colorscheme, err), vim.log.levels.ERROR)
    -- Próbuj załadować domyślny motyw
    pcall(function()
      vim.cmd(string.format("colorscheme %s", globals.THEMES[globals.DEFAULT_THEME]))
    end)
  end

  -- Odśwież lualine jeśli jest załadowany
  vim.schedule(function()
    if package.loaded["lualine"] then
      local success, _ = pcall(vim.cmd, "LualineRefresh")
      if not success then
        -- Lualine może nie mieć komendy refresh, spróbuj alternatywnie
        pcall(function()
          local lualine = require("lualine")
          if lualine and lualine.refresh then
            lualine.refresh()
          end
        end)
      end
    end
  end)

  -- Wywołaj callback dla innych pluginów
  if M.on_theme_change then
    local ok, err = pcall(M.on_theme_change, theme)
    if not ok then
      vim.notify(string.format("Error in theme change callback: %s", err), vim.log.levels.ERROR)
    end
  end

  M.is_initialized = true
end

-- Inicjalizacja
function M.init()
  if M.is_initialized then
    return
  end

  local initial_theme = M.get_system_theme()
  M.set_theme(initial_theme)
end

-- Reset (przydatne do testowania)
function M.reset()
  M.current_theme = globals.DEFAULT_THEME
  M.is_initialized = false
  M.on_theme_change = nil
end

return M
