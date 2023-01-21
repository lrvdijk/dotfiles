local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use { 'lewis6991/impatient.nvim', config = [[ require('impatient') ]] }
  use 'wbthomason/packer.nvim'

  -- My plugins here
  -- Color schemes
  use {'RRethy/nvim-base16', config = [[ require('plug_conf.base16') ]] }
  -- Indentation guides
  use { "lukas-reineke/indent-blankline.nvim", config = [[ require('plug_conf.indent_blankline') ]] }

  -- Autocompletion and snippets
  use {
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp',
                 'hrsh7th/cmp-path',
                 'hrsh7th/cmp-buffer',
                 'hrsh7th/cmp-omni',
                 'dcampos/nvim-snippy',
                 'dcampos/cmp-snippy'
               },

    config = [[ require('plug_conf.cmp') ]]
  }

  -- Language server management
  use {
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',

      -- Additional Rust tools
      'simrat39/rust-tools.nvim'
    },
    config = [[ require('plug_conf.lsp') ]]
  }

  use { 'j-hui/fidget.nvim', config = [[ require('fidget').setup() ]] }

  -- Tree sitter for improved highlighting
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = [[ require('plug_conf.treesitter') ]],
  }

  -- Python helpers
  use { "Vimjas/vim-python-pep8-indent", ft = { "python" } }
  use { "jeetsukumaran/vim-pythonsense", ft = { "python" } }

  -- Other languages
  use { "cespare/vim-toml", ft = { "toml" }, branch = "main" }
  use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically

  -- Telescope
  use "nvim-lua/plenary.nvim"
  use {
    "nvim-telescope/telescope.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = [[ require('plug_conf.telescope') ]],
  }

  use { "nvim-telescope/telescope-fzy-native.nvim", requires="nvim-telescope/telescope.nvim",
        after="telescope.nvim", config=[[ require('telescope').load_extension('fzy_native') ]] }

  -- search emoji and other symbols
  use { "nvim-telescope/telescope-symbols.nvim", after = "telescope.nvim" }

  -- Tabs and status line
  use { 'nvim-tree/nvim-web-devicons' }
  use { 'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons',
        after={"nvim-web-devicons", "nvim-base16"}, config = [[require('plug_conf.bufferline') ]]}
  use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true},
        config = [[ require('plug_conf.lualine') ]] }

  -- File tree
  use { 'nvim-tree/nvim-tree.lua', requires = { 'nvim-tree/nvim-web-devicons'},
        config = [[ require('plug_conf.nvimtree') ]]}

  -- Session management
  use { 'Shatur/neovim-session-manager', requires = {'nvim-lua/plenary.nvim'}, after = {'plenary.nvim'},
        config = [[ require('plug_conf.sessionmanager') ]] }

  -- Git management
  use "tpope/vim-fugitive"
  use { "lewis6991/gitsigns.nvim", config = [[ require('plug_conf.gitsigns') ]] }

  -- Tmux
  use { "tmux-plugins/vim-tmux", ft = { "tmux" } }
  use 'christoomey/vim-tmux-navigator'

  -- Notifications
  use { 'rcarriga/nvim-notify', config = [[ require('plug_conf.notify') ]] }

  -- Auto save
  use { 'Pocco81/auto-save.nvim', config = [[ require('plug_conf.autosave') ]] }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
