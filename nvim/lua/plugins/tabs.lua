-- lua/plugins/tabs.lua
return {
  {
    "akinsho/bufferline.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    opts = {},
    config = function()
      local bufferline = require("bufferline")
      bufferline.setup({
        options = {
          style_preset = bufferline.style_preset.no_italic,
          buffer_close_icon = '',
          offsets = {
            {
              filetype = 'neo-tree',
              text = 'File Explorer',
              separator = true
            }
          }
        }
      })

      -- Skróty klawiszowe
      local map = vim.keymap.set

      -- Przejście między buforami
      map('n', '[b', '<Cmd>BufferLineCycleNext<CR>', { desc = 'Next buffer' })
      map('n', 'b]', '<Cmd>BufferLineCyclePrev<CR>', { desc = 'Previous buffer' })

      -- Zamknięcie buforów
      map('n', '<leader>bd', '<Cmd>bd<CR>', { desc = 'Delete buffer' })
      map('n', '<leader>bD', '<Cmd>BufferLinePickClose<CR>', { desc = 'Pick buffer to close' })
      map('n', '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', { desc = 'Close left buffers' })
      map('n', '<leader>br', '<Cmd>BufferLineCloseRight<CR>', { desc = 'Close right buffers' })
      map('n', '<leader>bo', '<Cmd>BufferLineCloseOthers<CR>', { desc = 'Close other buffers' })

      -- Szybkie przejście do bufora (leader + numer)
      for i = 1, 9 do
        map('n', '<leader>' .. i, '<Cmd>BufferLineGoToBuffer ' .. i .. '<CR>',
          { desc = 'Go to buffer ' .. i })
      end

      -- Wybór bufora
      map('n', '<leader>bp', '<Cmd>BufferLinePick<CR>', { desc = 'Pick buffer' })

      -- Przesuwanie buforów
      map('n', '<leader>bmn', '<Cmd>BufferLineMoveNext<CR>', { desc = 'Move buffer next' })
      map('n', '<leader>bmp', '<Cmd>BufferLineMovePrev<CR>', { desc = 'Move buffer previous' })
    end
  },
}