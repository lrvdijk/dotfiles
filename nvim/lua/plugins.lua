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
  use 'RRethy/nvim-base16'

  -- Auto-completion
  use {'neoclide/coc.nvim', branch = 'release', config = [[ require('plug_conf.coc') ]]}

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

  -- Fuzzy search with LeaderF
  use { "Yggdroot/LeaderF", cmd = "Leaderf", run = ":LeaderfInstallCExtension" }

  -- Telescope
  use "nvim-lua/plenary.nvim"
  use {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    requires = { { "nvim-lua/plenary.nvim" } },
  }

  -- search emoji and other symbols
  use { "nvim-telescope/telescope-symbols.nvim", after = "telescope.nvim" }

  -- Tabs and status line
  use { 'nvim-tree/nvim-web-devicons' }
  use { 'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons',
        config = [[require('plug_conf.bufferline') ]]}
  use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true},
        config = [[ require('plug_conf.lualine') ]] }

  -- File tree
  use { 'nvim-tree/nvim-tree.lua', requires = { 'nvim-tree/nvim-web-devicons'},
        config = [[ require('plug_conf.nvimtree') ]]}

  -- Git management
  use "tpope/vim-fugitive"
  use { "lewis6991/gitsigns.nvim", config = [[ require('plug_conf.gitsigns') ]] }

  -- Tmux
  use { "tmux-plugins/vim-tmux", ft = { "tmux" } }
  use 'christoomey/vim-tmux-navigator'

  -- Notifications
  use { 'rcarriga/nvim-notify', config = [[ require('plug_conf.notify') ]] }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
