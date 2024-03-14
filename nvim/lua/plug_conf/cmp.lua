vim.opt.completeopt = "menu,menuone,preview,noselect"

local snippy = require("snippy")
local cmp = require('cmp')

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local tab_intellij_like = function(fallback)
  -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
  if cmp.visible() then
    cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
  elseif snippy.can_expand_or_advance() then
    snippy.expand_or_advance()
  else
    fallback()
  end
end

local cr_intellij_like = function(fallback)
  -- This little snippet will confirm with cr, and if no entry is selected, will confirm the first item
  if cmp.visible() and has_words_before() then
    local entry = cmp.get_selected_entry()
    if entry then
      cmp.confirm()
    end
  else
    fallback()
  end
end



local tab_confirm_if_one_completion = function(fallback)
  if cmp.visible() then
    if #cmp.get_entries() == 1 then
      cmp.confirm({ select = true })
    else
      cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
    end
  elseif has_words_before() then
    cmp.complete()
    if #cmp.get_entries() == 1 then
      cmp.confirm({ select = true })
    end
  else
    fallback()
  end
end

cmp.setup {
  completion = {
    completeopt = "menu,menuone,preview,noselect" -- or vim.opt.completeopt:get()
  },
  preselect = cmp.PreselectMode.None,
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      snippy.expand_snippet(args.body) -- For `snippy` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping({
      i = cr_intellij_like,
      s = cmp.mapping.confirm({ select = true }),
    }),
    ["<Tab>"] = cmp.mapping({
      i = tab_intellij_like,
      s = tab_confirm_if_one_completion,
      c = tab_confirm_if_one_completion,
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
      if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
      elseif snippy.can_jump(-1) then
        snippy.previous()
      else
        fallback()
      end
    end, {"i","s"}),
  }),
  sources = cmp.config.sources(
    { { name = 'nvim_lsp' } },
    { { name = 'nvim_lsp_signature_help' } },
    { { name = 'path' } },
    { { name = 'snippy' } }, -- For snippy users.
    { { name = 'treesitter' } }
  )
}

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
})

 -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'treesitter' },
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})


-- Integration with autopair
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local handlers = require('nvim-autopairs.completion.handlers')

cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done({
    filetypes = {
      -- "*" is a alias to all filetypes
      ["*"] = {
        ["("] = {
          kind = {
            cmp.lsp.CompletionItemKind.Function,
            cmp.lsp.CompletionItemKind.Method,
          },
          handler = handlers["*"]
        }
      },
    }
  })
)
