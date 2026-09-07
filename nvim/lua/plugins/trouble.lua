-- lua/plugins/trouble.lua
return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
  config = function()
    local trouble = require("trouble")
    trouble.setup()
  end
}
