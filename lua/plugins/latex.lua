return {

  -- Compilar latex e integrarlo con vim
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_view_method = "zathura"
      vim.g.tex_flavor = "latex"
      vim.g.vimtex_quickfix_mode = 0
      vim.opt.conceallevel = 1
      vim.opt.wrap = true
      vim.g.tex_conceal = "abdmg"
    end,
  },

  -- Snipperinos
  {
    "L3MON4D3/LuaSnip",
    version = "v2.3",
    build = "make install_jsregexp",
    config = function()
      local ls = require("luasnip")

      ls.config.set_config({
        enable_autosnippets = true,
        store_selection_keys = "<Tab>",
        history = true,
        update_events = "TextChanged,TextChangedI",
        region_check_events = "InsertEnter",
        delete_check_events = "InsertLeave",
      })

      require("luasnip.loaders.from_lua").lazy_load({
        paths = "~/.config/nvim/lua/plugins/snippets/",
      })

      vim.cmd([[
        imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
        smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'

        imap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
        smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
      ]])
    end,
  },
}
