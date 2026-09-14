local function map(mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, { silent = true })
end

-- More natural movement in normal/visual mode
map({ 'n', 'v' }, 'j', 'gj')
map({ 'n', 'v' }, 'k', 'gk')

-- keep search matches in the middle of the window
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

-- Reselect visual block after indent/outdent
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Easy window split; C-w v -> vv, C-w - s -> ss
map('n', 'vv', '<C-w>v')
map('n', 'ss', '<C-w>s')

map('n', '<leader>t', ':NvimTreeToggle<CR>')
