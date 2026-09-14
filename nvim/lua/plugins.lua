local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require('kanagawa').setup()

      vim.cmd('colorscheme kanagawa')
    end,
  },

  -- Smart splits management with integration for zellij
  {
    'mrjones2014/smart-splits.nvim',
    config = function()
      require('plug_conf.smartsplits')
    end
  },

  -- Autocompletion
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets' },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = {
        preset = 'super-tab',

        ['<Tab>'] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_next()
            end
          end,
          'snippet_forward',
          'fallback'
        },

        ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = {
        documentation = { auto_show = true },
        list = {
          selection = {
            preselect = false,
            auto_insert = true,
          }
        }
      },
    },
    opts_extend = { "sources.default" }
  },

  -- Autocompletion icons
  'onsails/lspkind.nvim',

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
      require('plug_conf.telescope')
    end,
  },

  -- Language server management
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason-lspconfig").setup()
      require('plug_conf.lsp')
    end,
  },

  -- Tree sitter for improved highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require('plug_conf.treesitter')
    end,
  },

  -- Neovim native inlay hint configuration
  {
    "MysticalDevil/inlay-hints.nvim",
    event = "LspAttach",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("inlay-hints").setup()
    end
  },

  -- Auto pair closer
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true,
  },

  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        python = { "ruff_format" },
        rust = { "rustfmt", lsp_format = "fallback" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        markdown = { "prettier" },
        yaml = { "prettier" },
        snakemake = { "snakefmt" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    },
  },

  -- Additional Rust tools
  {
    'mrcjkb/rustaceanvim',
    version = '^7', -- Recommended
    ft = { 'rust' },
    init = function()
      vim.g.rustaceanvim = {
        tools = {
          use_clippy = true,
        },
        server = {
          default_settings = {
            ['rust-analyzer'] = {
              inlayHints = {
                bindingModeHints = {
                  enable = false,
                },
                chainingHints = {
                  enable = true,
                },
                closingBraceHints = {
                  enable = true,
                  minLines = 25,
                },
                closureReturnTypeHints = {
                  enable = "never",
                },
                lifetimeElisionHints = {
                  enable = "never",
                  useParameterNames = false,
                },
                maxLength = 25,
                parameterHints = {
                  enable = true,
                },
                reborrowHints = {
                  enable = "never",
                },
                renderColons = true,
                typeHints = {
                  enable = true,
                  hideClosureInitialization = false,
                  hideNamedConstructor = false,
                },
              },
            }
          }
        },
      }
    end,
  },

  -- Other languages
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  {
    "cespare/vim-toml",
    ft = { "toml" },
    branch = "main"
  },

  -- Status line
  'nvim-tree/nvim-web-devicons',

  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'kyazdani42/nvim-web-devicons'
    },
    opts = {
      theme = "auto",
    }
  },

  -- File tree
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    opts = {},
  },

  -- Session management
  {
    'Shatur/neovim-session-manager',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('session_manager').setup({
        autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir,
      })
    end,
  },

  -- Git management
  { "lewis6991/gitsigns.nvim", config = function() require('plug_conf.gitsigns') end },

  -- Tmux config file highlighting
  { "tmux-plugins/vim-tmux",   ft = { "tmux" } },

  -- Autosave
  {
    'okuuva/auto-save.nvim',
    event = { "InsertLeave", "TextChanged", "BufLeave", "FocusLost" },
    opts = {
      trigger_events = {
        defer_save = { "InsertLeave", "TextChanged", "CursorHold" },
        cancel_deferred_save = { "InsertEnter", "CursorMoved" }
      },
      debounce_delay = 1500,
      message = nil,
      condition = require('plug_conf.autosave').autosave_condition,
    }
  },

  -- Decisive CSV/TSV viewing improvements
  {
    "emmanueltouzery/decisive.nvim",
    config = function()
      require('decisive').setup{}
    end,
    lazy=true,
    ft = {'csv', 'tsv'},
    keys = {
      { '<leader>cca', ":lua require('decisive').align_csv({})<cr>",       { silent = true }, desc = "Align CSV",          mode = 'n' },
      { '<leader>ccA', ":lua require('decisive').align_csv_clear({})<cr>", { silent = true }, desc = "Align CSV clear",    mode = 'n' },
      { '[c', ":lua require('decisive').align_csv_prev_col()<cr>",         { silent = true }, desc = "Align CSV prev col", mode = 'n' },
      { ']c', ":lua require('decisive').align_csv_next_col()<cr>",         { silent = true }, desc = "Align CSV next col", mode = 'n' },
    }
  },
  {
    "snakemake/snakemake",
    ft = "snakemake",
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. "/misc/vim")
    end,
    init = function(plugin)
      require("lazy.core.loader").ftdetect(plugin.dir .. "/misc/vim")
    end,
  },
})
