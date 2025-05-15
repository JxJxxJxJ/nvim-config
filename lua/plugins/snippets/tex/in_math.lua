-- Luasnips shorthands
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local i = ls.insert_node
local d = ls.dynamic_node
local t = ls.text_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta

-- Utility functions
local utils = require("plugins.snippets.tex.utils")
local in_mathzone = utils.in_mathzone

return {
  -- easy leftright anything
  s(
    { trig = "lr()", snippetType = "autosnippet" },
    { fmta([[\left( <> \right) <> ]], {
      i(1),
      i(0),
    }) },
    { condition = in_mathzone }
  ),
  s(
    { trig = "lr[]", snippetType = "autosnippet" },
    { fmta([[\left[ <> \right] <> ]], {
      i(1),
      i(0),
    }) },
    { condition = in_mathzone }
  ),
  s(
    { trig = "lr{}", snippetType = "autosnippet" },
    { fmta([[\left{ <> \right} <> ]], {
      i(1),
      i(0),
    }) },
    { condition = in_mathzone }
  ),

  -- easy differentials in mathzone
  s({ trig = "df", snippetType = "autosnippet" }, { t("\\diff") }, { condition = in_mathzone }),

  -- langles rangles
  s(
    { trig = "lrangle", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta([[\quant{ <> } <> ]], {
      i(1),
      i(0),
    }),
    { condition = in_mathzone }
  ),

  -- <>/<>%s -> \frac{<>}{<>} :)
  s(
    { trig = "([%w]+)/([%w]+)%s", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta([[ \frac{<>}{<>} <> ]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
      i(0),
    }),
    { condition = in_mathzone }
  ),

  -- Kff -> \frac{K}{i(2)} I believe..
  s(
    { trig = "([%w]+)ff", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta([[ \frac{<>}{<>} <> ]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(0),
    }),
    { condition = in_mathzone, priority = 1 }
  ),

  s(
    { trig = "ff", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta([[ \frac{<>}{<>} ]], {
      i(1),
      i(2),
    }),
    { condition = in_mathzone, priority = 2 }
  ),

  -- Snippet for the case without specifier
  s({ trig = "mat_(%d)(%d)", regTrig = true, snippetType = "autosnippet" }, {
    d(1, function(_, snip)
      local type = "matrix"
      local rows, cols = snip.captures[1], snip.captures[2]
      local nodes = {}
      local ts = 1
      local col_spec = string.rep("c", cols)
      table.insert(nodes, t("\\begin{" .. type .. "}[" .. col_spec .. "]"))
      for _ = 1, rows, 1 do
        table.insert(nodes, t({ "", "\t" }))
        for _ = 1, cols, 1 do
          table.insert(nodes, i(ts))
          table.insert(nodes, t(" & "))
          ts = ts + 1
        end
        table.remove(nodes, #nodes)
        table.insert(nodes, t(" \\\\"))
      end
      table.remove(nodes, #nodes)
      table.insert(nodes, t({ "", "\\end{" .. type .. "}" }))
      return sn(1, nodes)
    end),
  }, { condition = in_mathzone }),

  -- Modified existing snippet to handle the case with specifier
  s({ trig = "([bpv])mat_(%d)(%d)", regTrig = true, snippetType = "autosnippet" }, {
    d(1, function(_, snip)
      local type = snip.captures[1] .. "matrix"
      local rows, cols = snip.captures[2], snip.captures[3]
      local nodes = {}
      local ts = 1
      local col_spec = string.rep("r", cols)
      table.insert(nodes, t("\\begin{" .. type .. "}[" .. col_spec .. "]"))
      for _ = 1, rows, 1 do
        table.insert(nodes, t({ "", "\t" }))
        for _ = 1, cols, 1 do
          table.insert(nodes, i(ts))
          table.insert(nodes, t(" & "))
          ts = ts + 1
        end
        table.remove(nodes, #nodes)
        table.insert(nodes, t(" \\\\"))
      end
      table.remove(nodes, #nodes)
      table.insert(nodes, t({ "", "\\end{" .. type .. "}" }))
      return sn(1, nodes)
    end),
  }, { condition = in_mathzone, priority = 1 }),

  -- LaTeX: Lims and stuff
  s(
    { trig = "Lim", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta([[\lim_{ <> }^{ <> }{ <> } <>]], {
      i(1),
      i(2),
      i(3),
      i(0),
    }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "Sum", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta([[\sum_{ <> }^{ <> }{ <> } <>]], {
      i(1),
      i(2),
      i(3),
      i(0),
    }),
    { condition = in_mathzone }
  ),

  s(
    { trig = "Prod", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta([[\prod_{ <> }^{ <> }{ <> } <>]], {
      i(1),
      i(2),
      i(3),
      i(0),
    }),
    { condition = in_mathzone }
  ),

  s(
    { trig = "Int", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta([[\int{ <> }^{ <> }{ <> } <>]], {
      i(1),
      i(2),
      i(3),
      i(0),
    }),
    { condition = in_mathzone }
  ),

  -- LaTeX: Cuantifiers
  s(
    { trig = "ssum", regTrig = false, wordTrig = true, snippetType = "autosnippet" },
    { t("\\sum ") },
    { condition = in_mathzone }
  ),
  s(
    { trig = "sprod", regTrig = false, wordTrig = true, snippetType = "autosnippet" },
    { t("\\prod ") },
    { condition = in_mathzone }
  ),

  -- LaTeX: easy () {}
  s(
    { trig = "()", regTrig = false, wordTrig = true, snippetType = "autosnippet" },
    fmta([[\paren{ <> } <>]], {
      i(1),
      i(0),
    })
  ),
  s(
    { trig = "paren", regTrig = false, wordTrig = true, snippetType = "autosnippet" },
    fmta([[\paren{ <> } <>]], {
      i(1),
      i(0),
    })
  ),

  s(
    { trig = "{}", regTrig = false, wordTrig = true, snippetType = "snippet" },
    fmta([[\cbrack{ <> } <>]], {
      i(1),
      i(0),
    })
  ),
  s(
    { trig = "cbrack", regTrig = false, wordTrig = true, snippetType = "autosnippet" },
    fmta([[\cbrack{ <> } <>]], {
      i(1),
      i(0),
    })
  ),
  s(
    { trig = "brack", regTrig = false, wordTrig = true, snippetType = "autosnippet" },
    fmta([[\brack{ <> } <>]], {
      i(1),
      i(0),
    })
  ),

  s(
    { trig = "conj", regTrig = false, wordTrig = true, snippetType = "autosnippet" },
    fmta([[\cbrack{ <> } <>]], {
      i(1),
      i(0),
    }),
    { condition = in_mathzone }
  ),

  -- LaTeX: Single-digit subscripts [Auto-expand without confirming]
  s(
    {
      trig = "([^%a]*)([wxyz])([ijkn%d])",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
    },
    f(function(_, snip)
      local prefix = snip.captures[1]
      local letter = snip.captures[2]
      local subscript = snip.captures[3]

      return prefix .. letter .. "_" .. subscript .. " "
    end),
    { condition = in_mathzone }
  ),

  -- LaTeX: Math subscripts and superscripts
  s({ trig = "([abcvwxyz])([%_%^])", regTrig = true, snippetType = "autosnippet", wordTrig = false }, {
    f(function(_, snip)
      return snip.captures[1] .. snip.captures[2] .. "{ "
    end),
    i(1),
    t(" } "),
  }, { condition = in_mathzone }),

  -- LaTeX: Math exponents
  s({ trig = "^", wordTrig = false, snippetType = "autosnippet" }, {
    t("^{ "),
    i(1),
    t(" }"),
  }, { condition = in_mathzone }),

  -- LaTeX: Math boldface
  s("bf", fmt([[\mathbf{{{}}}]], i(1)), { condition = in_mathzone }),

  -- LaTeX: Romanized math
  s("rm", fmt([[\mathrm{{{}}}]], i(1)), { condition = in_mathzone }),

  -- LaTeX: Math calligraphy
  s("mcal", fmt([[\mathcal{{{}}}]], i(1)), { condition = in_mathzone }),

  -- LaTeX: Math script
  s("mscr", fmt([[\mathscr{{{}}}]], i(1)), { condition = in_mathzone }),

  -- LaTeX: Math text
  s(
    { trig = "tt", wordTrig = true, snippetType = "autosnippet" },
    fmt([[\text{{ {} }}]], i(1)),
    { condition = in_mathzone }
  ),

  -- LaTeX: Square root
  s({ trig = "sqrt", snippetType = "autosnippet", wordTrig = false }, {
    t("\\sqrt[2]{ "),
    i(1),
    t(" }"),
  }, { condition = in_mathzone }),

  -- LaTeX: Vector
  s({ trig = "vec", snippetType = "autosnippet", wordTrig = false }, {
    t("\\vec{ "),
    i(1),
    t(" }"),
  }, { condition = in_mathzone }),

  -- LaTeX: bar
  s(
    {
      trig = "(%a)bar",
      wordTrig = false,
      regTrig = true,
      name = "bar",
      priority = 100,
      snippetType = "autosnippet",
    },
    f(function(_, snip)
      return string.format("\\overline{%s}", snip.captures[1])
    end, {}),
    { condition = in_mathzone }
  ),

  -- LaTeX: hat
  s(
    {
      trig = "(%a)hat",
      wordTrig = false,
      regTrig = true,
      name = "hat",
      priority = 100,
      snippetType = "autosnippet",
    },
    f(function(_, snip)
      return string.format("\\hat{%s}", snip.captures[1])
    end, {})
  ),
}
