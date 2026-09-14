-- Remove trailing whitespace
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  callback = function()
    -- Restore cursor after removing whitespace
    local r, c = unpack(vim.api.nvim_win_get_cursor(0))
    vim.cmd [[%s/\s\+$//e]]
    vim.api.nvim_win_set_cursor(0, {r, c})
  end,
})

-- Check for external file changes
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

-- Show diagnostics for the symbol under the cursor
vim.api.nvim_create_autocmd("CursorHold", {
  pattern = { "*" },
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false })
  end,
})
