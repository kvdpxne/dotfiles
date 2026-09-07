-- lua/plugins/treesitter.lua
return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		lazy = false,
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"vim",
        "vimdoc",
        "lua",
        "luadoc",
        "lua_patterns",
        "luau",
        "javascript",
        "json",
        -- Independant
        "html",
        "css",
        "php",
        "blade"
			},
      sync_install = false,
			auto_install = true,
			hightlight = {
        enable = true
      },
		},
	},
	{ "nvim-treesitter/nvim-treesitter-textobjects" },
}
