-- lua/plugins/visual-columns.lua
return {
  {
    'lukas-reineke/virt-column.nvim',
    opts = {
      char = '│',
      virtcolumn = '80',
      exclude = {
        filetypes = {
          'help'
        },
      }
    },
    config = function(_, opts)
      local vc = require('virt-column')

      -- Ustaw początkową konfigurację
      vc.setup(opts)

      local function update_virtcolumn()
        local tw = vim.bo.textwidth
        if tw and tw > 0 then
          local warning_column = tw + 20
          vc.update({
            virtcolumn = tw .. ',' .. warning_column,
          })
        else
          -- Przywróć domyślną wartość jeśli textwidth nie jest ustawiony
          vc.update({
            virtcolumn = '80',
          })
        end
      end

      -- Wymuś odświeżenie przy wejściu do bufora
      vim.api.nvim_create_autocmd({
        'BufEnter',
        'BufWinEnter',
        'FileType'
      }, {
        callback = function()
          -- Małe opóźnienie aby zapewnić że buffer jest w pełni załadowany
          vim.defer_fn(update_virtcolumn, 50)
        end
      })
      -- Dodatkowo odśwież po zapisaniu
      vim.api.nvim_create_autocmd('BufWritePost', {
        callback = update_virtcolumn
      })

      -- Wymuś odświeżenie gdy zmienia się textwidth
      vim.api.nvim_create_autocmd('OptionSet', {
        pattern = 'textwidth',
        callback = update_virtcolumn
      })

      -- Ręczne odświeżenie dla obecnego bufora
      vim.defer_fn(update_virtcolumn, 100)
    end
  }
}
