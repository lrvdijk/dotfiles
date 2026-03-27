local excluded_filetypes = {
  "gitcommit",
  -- most of these are usually set to non-modifiable, which prevents autosaving
  -- by default, but it doesn't hurt to be extra safe.
  "NvimTree",
  "Outline",
  "TelescopePrompt",
  "alpha",
  "dashboard",
  "lazygit",
  "neo-tree",
  "oil",
  "prompt",
  "toggleterm",
}

return {
  autosave_condition = function(buf)
    local mode = vim.fn.mode()
    if mode == "i" then
      return false
    end


    if vim.tbl_contains(excluded_filetypes, vim.fn.getbufvar(buf, "&filetype"))
    then
      return false
    end

    -- don't save for special-buffers
    if vim.fn.getbufvar(buf, "&buftype") ~= '' then
      return false
    end

    return true
  end
}
