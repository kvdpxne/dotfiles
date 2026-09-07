-- lua/plugins/theme.lua
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      -- Konfiguracja Catppuccin z zabezpieczeniami
      local ok, err = pcall(function()
        require("catppuccin").setup({
          integrations = {
            cmp = true,
            gitsigns = true,
            nvimtree = true,
            telescope = true,
            notify = false,
            mini = false,
          },
        })
      end)

      if not ok then
        vim.notify(string.format("Failed to setup catppuccin: %s", err), vim.log.levels.ERROR)
        return
      end

      -- Inicjalizacja z obsługą błędów
      local darkman_listener = require("listeners.darkman-listener")
      pcall(darkman_listener.init)
    end
  }
}
