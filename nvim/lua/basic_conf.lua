vim.opt.encoding = "utf-8"

vim.opt.backspace = "indent,eol,start"
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.autoindent = true
vim.opt.laststatus = 2

vim.opt.number = true
vim.opt.textwidth = 120
vim.opt.colorcolumn = "+1"
vim.opt.formatoptions:append("1")
vim.opt.formatoptions:append("n")
vim.opt.formatoptions:append("/")
vim.opt.formatoptions:remove("o")

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

vim.opt.updatetime = 250
vim.opt.signcolumn = "yes"

vim.opt.ttimeoutlen = 50
vim.opt.errorbells = false
vim.opt.visualbell = false
vim.opt.splitbelow = true -- when splitting horizontally, move coursor to lower pane
vim.opt.splitright = true -- when splitting vertically, mnove coursor to right pane

vim.opt.incsearch = true -- starts searching as soon as typing, without enter needed
vim.opt.ignorecase = true -- ignore letter case when searching
vim.opt.smartcase = true -- case insentive unless capitals used in search

vim.opt.background = 'dark'
vim.opt.termguicolors = true

if vim.env["BASE16_THEME"] ~= nil and "base16-" .. vim.env["BASE16_THEME"] ~= vim.g.colors_name then
  vim.g.base16colorspace = 256
  vim.cmd('colorscheme base16-' .. vim.env['BASE16_THEME'])
end

vim.opt.wildmenu = true
vim.opt.wildignore:append {"*.so,*.*swp,*.zip,*.pyc,*.a,*.d,*.DS_Store"}
vim.opt.wildignore:append {"*/.git/*,*/.svn/*,*/__pycache__/*,*/build/**"}
vim.opt.wildignore:append {"*.jpg,*.png,*.jpeg,*.bmp,*.gif,*.tiff,*.svg,*.ico"}
vim.opt.wildignore:append {"*.aux,*.bbl,*.blg,*.brf,*.fls,*.fdb_latexmk,*.synctex.gz,*.xdv"}

if vim.env["CONDA_PREFIX"] ~= nil and vim.env["CONDA_PREFIX"] ~= "" then
  vim.g.python3_host_prog = vim.env["CONDA_PREFIX"] .. "/bin/python3"
  vim.notify("Conda environment: " .. vim.env['CONDA_PREFIX'], "info")
end
