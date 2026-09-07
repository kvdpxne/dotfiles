-- lua/utils/error-utils.lua (opcjonalnie)
local M = {}

-- Funkcja do bezpiecznego wykonywania kodu
function M.safe_execute(func, fallback, error_message)
  local success, result = pcall(func)
  if not success then
    if error_message then
      vim.notify(string.format("%s: %s", error_message, result), vim.log.levels.ERROR)
    end
    return fallback
  end
  return result
end

-- Funkcja do bezpiecznego ładowania modułu
function M.safe_require(module_name, fallback)
  local success, module = pcall(require, module_name)
  if not success then
    vim.notify(string.format("Failed to load module '%s': %s", module_name, module), vim.log.levels.ERROR)
    return fallback
  end
  return module
end

return M
