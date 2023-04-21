-- Neovim Lua based configuration

utils = require('utils')

vim.g.is_win = (utils.has("win32") or utils.has("win64")) and true or false
vim.g.is_linux = (utils.has("unix") and (not utils.has("macunix"))) and true or false
vim.g.is_mac  = utils.has("macunix") and true or false

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Find python3
if vim.env["CONDA_PREFIX"] and vim.env["CONDA_PREFIX"] ~= "" then
  vim.g.python3_host_prog = vim.env["CONDA_PREFIX"] .. "/bin/python3"
end

require('plugins')
require('basic_conf')
require('mappings')
require('diagnostics')
require('autocommands')
