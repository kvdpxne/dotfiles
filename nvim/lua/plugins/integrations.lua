-- lua/plugins/integrations.lua
return {
	-- PHP i Laravel
	{
		"adalessa/laravel.nvim",
		dependencies = {
			"tpope/vim-dotenv",
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-neotest/nvim-nio",
			"ravitemer/mcphub.nvim", -- optional
		},
    event = {
      'VeryLazy'
    },
		opts = {
			artisan = {
				sync = {
					events = {
						"BufWritePost",
					},
				},
			},
			route = {
				telescope = {
					annotate = true,
				},
			},
		},
	},
	{ "noahfrederick/vim-laravel" },
	{ "jwalton512/vim-blade" },

	-- JavaScript/TypeScript
	{ "pangloss/vim-javascript" },
	{ "leafgarland/typescript-vim" },
	{ "maxmellon/vim-jsx-pretty" },

	-- CSS/SCSS
	{ "ap/vim-css-color" },
	{ "hail2u/vim-css3-syntax" },

	-- HTML i Emmet
	{ "mattn/emmet-vim" },
}