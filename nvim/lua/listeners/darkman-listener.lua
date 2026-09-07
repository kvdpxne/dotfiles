-- lua/listeners/darkman-listener.lua
local M = {}
local theme_utils = require("utils.theme-utils")

-- Stan listenera
M.is_listening = false
M.job_id = nil

-- Funkcja do czyszczenia listenera
function M.cleanup()
  if M.job_id then
    local success, _ = pcall(function()
      vim.fn.jobstop(M.job_id)
    end)
    M.job_id = nil
  end
  M.is_listening = false
end

-- Główna funkcja nasłuchująca
function M.listen()
  -- Jeśli już nasłuchuje, zatrzymaj i uruchom od nowa
  if M.is_listening then
    M.cleanup()
  end

  -- Sprawdź czy darkman jest dostępny
  local darkman_path = vim.fn.executable("darkman")
  if darkman_path ~= 1 then
    vim.notify("darkman not found, theme changes won't be detected", vim.log.levels.WARN)
    return false
  end

  -- Sprawdź czy darkman działa
  local status_check = io.popen("darkman status 2>/dev/null")
  if not status_check then
    vim.notify("darkman is not running, theme changes won't be detected", vim.log.levels.WARN)
    return false
  end
  status_check:close()

  -- Uruchom nasłuchiwanie z zabezpieczeniami
  local success, job = pcall(function()
    return vim.fn.jobstart({
      "bash", "-c",
      "darkman watch 2>/dev/null | while read -r line; do echo \"$line\"; done"
    }, {
      on_stdout = function(_, data)
        if not data or #data == 0 then return end

        for _, line in ipairs(data) do
          if line and line ~= "" then
            -- Bezpieczne parsowanie
            local trimmed = line:gsub("%s+", ""):lower()
            if trimmed == "dark" then
              pcall(theme_utils.set_theme, "dark")
            elseif trimmed == "light" then
              pcall(theme_utils.set_theme, "light")
            end
          end
        end
      end,
      on_stderr = function(_, data)
        -- Ignoruj błędy, ale loguj jeśli to ważne
        if data and #data > 0 then
          for _, line in ipairs(data) do
            if line and line ~= "" and not line:match("broken pipe") then
              vim.notify(string.format("darkman error: %s", line), vim.log.levels.DEBUG)
            end
          end
        end
      end,
      on_exit = function(_, code, _)
        if code ~= 0 then
          vim.notify(string.format("darkman listener exited with code %d", code), vim.log.levels.WARN)
          M.is_listening = false
          M.job_id = nil
          -- Spróbuj ponownie po chwili
          vim.defer_fn(function()
            if not M.is_listening then
              M.listen()
            end
          end, 5000)
        end
      end,
      stdout_buffered = false,
      stderr_buffered = false,
    })
  end)

  if not success or job <= 0 then
    vim.notify("Failed to start darkman listener", vim.log.levels.ERROR)
    return false
  end

  M.job_id = job
  M.is_listening = true
  vim.notify("Darkman listener started successfully", vim.log.levels.INFO)
  return true
end

-- Inicjalizacja z nasłuchiwaniem
function M.init()
  -- Najpierw zainicjalizuj motyw
  theme_utils.init()

  -- Potem uruchom nasłuchiwanie
  local success = M.listen()
  if not success then
    vim.notify("Failed to start darkman listener, theme won't update automatically", vim.log.levels.WARN)
  end
end

-- Zatrzymaj nasłuchiwanie
function M.stop()
  M.cleanup()
  vim.notify("Darkman listener stopped", vim.log.levels.INFO)
end

return M
