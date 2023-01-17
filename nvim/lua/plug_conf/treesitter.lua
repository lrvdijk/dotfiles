require("nvim-treesitter.configs").setup {
  ensure_installed = { "python", "cpp", "cmake", "lua", "vim", "rust", "typescript", "javascript", "astro",
                       "toml", "tsx", "yaml", "scss", "html", "make", "gitcommit", "dot", "bash",
                       "markdown", "markdown_inline" },
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { 'help' }, -- list of language that will be disabled
  },
}
