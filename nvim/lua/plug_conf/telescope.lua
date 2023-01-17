require('telescope').setup()

local M = {}

M.project_files = function()
  local opts = {} -- define here if you want to define something
  vim.fn.system('git rev-parse --is-inside-work-tree')
  if vim.v.shell_error == 0 then
    require "telescope.builtin".git_files(opts)
  else
    require "telescope.builtin".find_files(opts)
  end
end

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', M.project_files, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fs', builtin.lsp_dynamic_workspace_symbols, {})

return M
