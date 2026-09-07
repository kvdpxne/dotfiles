-- lua/keymap.lua


--
vim.keymap.set('n', '<C-n>', ':Neotree filesystem toggle left<CR>', { silent = true, noremap = true })

--
vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})

vim.keymap.set('n', '<leader>gf', vim.lsp.buf.format, {})

-- Telescope
local telescope = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", telescope.find_files, {})

-- Harpoon
local harpoon = require('harpoon')
vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Add to harpoon" })
vim.keymap.set("n", "<leader>hh", function() require("harpoon.ui").toggle_quick_menu() end, { desc = "Harpoon menu" })

-- Trouble
local trouble = require("trouble")
vim.keymap.set("n", "<leader>xx", function() trouble.toggle() end, { desc = "Toggle trouble" })

-- TODO comments
local comments = require('todo-comments')
vim.keymap.set("n", "]t", function() comments.jump_next() end, { desc = "Next TODO" })
vim.keymap.set("n", "[t", function() comments.jump_prev() end, { desc = "Previous TODO" })
