-- lua/plugins/lsp.lua
return {
  {
    "mason-org/mason.nvim",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "vimls",
        "lua_ls",
        "html",
        "emmet_ls",
        "ts_ls",
        -- CSS
        "cssls",
        "tailwindcss",
        -- Configuration files
        "jsonls",
        "yamlls",
        "taplo",
        -- PHP
        "intelephense",
        "astro",
        "svelte",
        "vuels",
      },
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lsp = vim.lsp
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Lua
      lsp.config('lua_ls', {
        capabilities = capabilities,
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
                path ~= vim.fn.stdpath('config')
                and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
            then
              return
            end
          end
          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              -- Tell the language server which version of Lua you're using (most
              -- likely LuaJIT in the case of Neovim)
              version = 'LuaJIT',
              -- Tell the language server how to find Lua modules same way as Neovim
              -- (see `:h lua-module-load`)
              path = {
                'lua/?.lua',
                'lua/?/init.lua',
              },
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME
                -- Depending on the usage, you might want to add additional paths
                -- here.
                -- '${3rd}/luv/library'
                -- '${3rd}/busted/library'
              }
              -- Or pull in all of 'runtimepath'.
              -- NOTE: this is a lot slower and will cause issues when working on
              -- your own configuration.
              -- See https://github.com/neovim/nvim-lspconfig/issues/3189
              -- library = {
              --   vim.api.nvim_get_runtime_file('', true),
              -- }
            }
          })
        end,
        settings = {
          Lua = {}
        }
      })

      -- HTML
      lsp.config('html', {
        capabilities = capabilities,
      })

      -- Emmet
      lsp.config('emmet_ls', {
        capabilities = capabilities,
        filetypes = {
          "html",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "php",
          "blade",
        },
      })

      -- TypeScript/JavaScript
      lsp.config('ts_ls', {
        capabilities = capabilities,
      })

      -- CSS
      lsp.config('cssls', {
        capabilities = capabilities,
      })

      -- PHP
      lsp.config('intelephense', {
        capabilities = capabilities,
        settings = {
          intelphense = {
            files = {
              maxSize = 5000000,
            },
            environment = {
              includePaths = {
                "vendor",
                "node_modules",
              },
            },
            stubs = {
              "apache",
              "bcmath",
              "bz2",
              "calendar",
              "com_dotnet",
              "Core",
              "ctype",
              "curl",
              "date",
              "dba",
              "dom",
              "enchant",
              "exif",
              "FFI",
              "fileinfo",
              "filter",
              "fpm",
              "ftp",
              "gd",
              "gettext",
              "gmp",
              "hash",
              "iconv",
              "imap",
              "intl",
              "json",
              "ldap",
              "libxml",
              "mbstring",
              "meta",
              "mysqli",
              "oci8",
              "odbc",
              "openssl",
              "pcntl",
              "pcre",
              "PDO",
              "pdo_mysql",
              "pdo_pgsql",
              "pdo_sqlite",
              "pgsql",
              "Phar",
              "posix",
              "pspell",
              "readline",
              "Reflection",
              "session",
              "shmop",
              "SimpleXML",
              "snmp",
              "soap",
              "sockets",
              "sodium",
              "SPL",
              "sqlite3",
              "standard",
              "superglobals",
              "sysvmsg",
              "sysvsem",
              "sysvshm",
              "tidy",
              "tokenizer",
              "xml",
              "xmlreader",
              "xmlrpc",
              "xmlwriter",
              "xsl",
              "Zend OPcache",
              "zip",
              "zlib",
              -- Frameworki
              "wordpress",
              "laravel",
              "symfony",
              "phpunit",
              -- Rozszerzenia Composer
              "mongodb",
              "redis",
              "memcached",
              "xdebug",
            },
          },
        },
      })
    end,
  },
}
