return {
  -- 1. Dodaj plugin
  {
    "natecraddock/workspaces.nvim",
    config = function()
      -- 2. Skonfiguruj plugin
      require("workspaces").setup({
        -- Opcjonalnie: możesz dostosować sposób zmiany katalogu
        -- "global" (domyślnie), "local" (okno) lub "tab" (zakładka)
        cd_type = "global",
      })

      -- 3. Dodaj katalog '~/projects' jako workspace o nazwie "projects"
      --    Komenda wykona się tylko raz, przy starcie Neovima.
      -- vim.cmd("WorkspacesAdd projects ~/projects")
    end,
  },
}
