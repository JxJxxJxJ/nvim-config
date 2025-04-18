-- Luasnips shorthands
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

-- Utility functions
local utils = require("plugins.snippets.tex.utils")
local in_text = utils.in_text
local in_math = utils.in_math

return {
  -- cases in text
  s(
    { trig = "cases", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta(
      [[
$<> = \begin{cases}
      <> &\text{si } <> \\
      <> &\text{si } <> \\
     \end{cases}$ 
      ]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
        i(5),
      }
    ),
    { condition = in_text }
  ),

  -- cases in math
  s(
    { trig = "cases", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta(
      [[
<> = \begin{cases}
      <> &\text{si } <> \\
      <> &\text{si } <> \\
     \end{cases} 
      ]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
        i(5),
      }
    ),
    { condition = in_math }
  ),
}
