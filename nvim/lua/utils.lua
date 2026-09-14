local M = {}

--- check whether a feature exists in Nvim
--- @feat: string
---   the feature name, like `nvim-0.7` or `unix`.
--- return: bool
function M.has(feat)
  return vim.fn.has(feat) == 1
end

return M
