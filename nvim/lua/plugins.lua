local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
    "navarasu/onedark.nvim",
    lazy=False,
    priority=1000,
    opts = {
      style = 'warmer',
      transparent = true,
    },

    config = function(plugin, opts)
      local onedark = require('onedark')

      onedark.setup(opts)
      onedark.load()
    end
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    -- load cmp on InsertEnter
    event = {"InsertEnter", "CmdlineEnter"},

    -- these dependencies will only be loaded when cmp loads
    -- dependencies are always lazy-loaded unless specified otherwise
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-omni',
      'dcampos/nvim-snippy',
      'dcampos/cmp-snippy',
      'petertriho/cmp-git',
    },
    config = function()
      require('plug_conf.cmp')
    end,
  },

  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-nvim-lsp-signature-help',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/cmp-omni',
  'dcampos/nvim-snippy',
  'dcampos/cmp-snippy',
  'petertriho/cmp-git',

  -- Notifications
  {
    'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup()
    end,
  },

  -- Telescope
  "nvim-lua/plenary.nvim",

  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require('plug_conf.telescope')
    end,
  },

  {
    "nvim-telescope/telescope-fzy-native.nvim",
    dependencies  = {
      "nvim-telescope/telescope.nvim",
    },
    config=function()
      require('telescope').load_extension('fzy_native')
    end,
  },

  -- search emoji and other symbols
  {
    "nvim-telescope/telescope-symbols.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim"
    }
  },

  -- Language server management
  'williamboman/mason.nvim',
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim'
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',
    },
    config = function()
      require('plug_conf.lsp').setup()
    end
  },

  -- Tree sitter for improved highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require('plug_conf.treesitter')
    end,
  },

  -- Python helpers
  { "Vimjas/vim-python-pep8-indent", ft = { "python" } },
  { "jeetsukumaran/vim-pythonsense", ft = { "python" } },

  -- Additional Rust tools
  {
    'simrat39/rust-tools.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-telescope/telescope.nvim',
    },
    ft = { 'rust' },
    config = function()
      require('plug_conf.rust_tools')
    end,
  },

  -- Other languages
  { "cespare/vim-toml", ft = { "toml" }, branch = "main" },
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- Status line
  'nvim-tree/nvim-web-devicons',

  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'kyazdani42/nvim-web-devicons'
    },
    opts = {
      theme = "onedark",
    }
  },

  -- File tree
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    config = function()
      require('plug_conf.nvimtree')
    end
  },

  -- Session management
  {
    'Shatur/neovim-session-manager',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('plug_conf.sessionmanager')
    end
  },

  -- Git management
  "tpope/vim-fugitive",
  { "lewis6991/gitsigns.nvim", config = function() require('plug_conf.gitsigns') end },

  -- Tmux
  { "tmux-plugins/vim-tmux", ft = { "tmux" } },

  -- Tmux/wezterm pane navigation integration
  { 'numToStr/Navigator.nvim', config = function() require('plug_conf.navigator') end},

  -- Notifications
  { 'rcarriga/nvim-notify', config = function() require('plug_conf.notify') end},

  -- Auto save
  {
    'okuuva/auto-save.nvim',
    event = { "InsertLeave", "TextChanged", "BufLeave", "FocusLost" },
    opts = {
      debounce_delay = 500,
      message = nil,
    }
  }
})
