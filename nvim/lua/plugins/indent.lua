-- lua/plugins/indent.lua
return {
  "lukas-reineke/indent-blankline.nvim",
  opts = {
    indent = {
      char = "│",
      tab_char = "│",
    },
    scope = {
      enabled = true,
      show_start = true,
      show_end = true,
    },
    exclude = {
      filetypes = {
        "help",
        "startify",
        "dashboard",
        "neo-tree",
        "Trouble",
        "trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lspinfo",
        "packer",
        "checkhealth",
        "man",
        "gitcommit",
      },
    },
  },
  config = function(_, opts)
    require("ibl").setup(opts)
  end
}
