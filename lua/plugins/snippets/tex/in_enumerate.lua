-- Luasnips shorthands
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node

-- Utility functions
local utils = require("plugins.snippets.tex.utils")
local in_text = utils.in_text
local begins_line = utils.begins_line
local in_enumerate = utils.in_enumerate

return {
  -- LaTeX: Enumerate environment
  s({ trig = "enumerate", snippetType = "autosnippet" }, {
    t("\\begin{enumerate}[label=(\\"),
    c(1, {
      t("arabic"),
      t("alph"),
      t("roman"),
    }),
    t({ "*)]" }),
    t({ "", "\t\t\\item " }),
    i(2),
    t({ "", "\t\t\\item " }),
    i(3),
    t({ "", "\t\t\\item " }),
    i(4),
    -- i(0),
    t({ "", "\\end{enumerate}" }),
  }, { condition = in_text and begins_line }),

  s({ trig = "ii", snippetType = "autosnippet" }, {
    t("\\item "),
    i(1),
  }, { condition = in_enumerate }),
}
