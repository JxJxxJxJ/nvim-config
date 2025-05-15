-- Luasnips shorthands
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

-- Utility functions
local utils = require("plugins.snippets.tex.utils")
local begins_line = utils.begins_line
local in_text = utils.in_text

return {
  -- LaTeX: Recursive/notrecursive itemize
  s({ trig = "itemize", snippetType = "autosnippet" }, {
    t({ "\\begin{itemize}", "\t\t\\item " }),
    i(1),
    -- d(2, rec_ls, {}),
    t({ "", "\\end{itemize}" }),
  }, { condition = in_text and begins_line }),

  s({ trig = "ii", snippetType = "autosnippet" }, {
    t("\\item "),
    i(1),
  }, { condition = in_text and begins_line }),
}
