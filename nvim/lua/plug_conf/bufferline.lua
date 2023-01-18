require("bufferline").setup {
    options = {
        numbers = "buffer_id",
        indicator = {
            style = "none"
        },
        diagnostics = "nvim_lsp",
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "left",
                separator = true
            }
        },
        separator_style = "slant"
    },
}

vim.keymap.set("n", "<C-n>", ":BufferLineCyclePrev<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<C-m>", ":BufferLineCycleNext<CR>", { silent = true, noremap = true })
