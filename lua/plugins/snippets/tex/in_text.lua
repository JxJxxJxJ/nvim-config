-- Luasnips shorthands
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta

-- Utility functions
local utils = require("plugins.snippets.tex.utils")
local in_text = utils.in_text

-- Snippets
return {

  -- Chapter
  s({ trig = ";chap", snippetType = "autosnippet" }, {
    c(1, {
      t("\\chapter{"),
      t("\\chapter*{"),
    }),
    i(2),
    t("}"),
    i(0),
  }, { condition = in_text }),

  -- Section
  s({ trig = ";sec", snippetType = "autosnippet" }, {
    c(1, {
      t("\\section{"),
      t("\\section*{"),
    }),
    i(2),
    t("}"),
    i(0),
  }, { condition = in_text }),

  -- Subsection
  s({ trig = ";ssec", snippetType = "autosnippet" }, {
    c(1, {
      t("\\subsection{"),
      t("\\subsection*{"),
    }),
    i(2),
    t("}"),
    i(0),
  }, { condition = in_text }),

  -- Subsubsection
  s({ trig = ";sssec", snippetType = "autosnippet" }, {
    c(1, {
      t("\\subsubsection{"),
      t("\\subsubsection*{"),
    }),
    i(2),
    t("}"),
    i(0),
  }, { condition = in_text }),

  -- Inline math
  s({ trig = "mm", snippetType = "autosnippet" }, {
    t("$ "),
    i(1),
    t(" $ "),
  }, { condition = in_text }),

  -- Display math
  s({ trig = "dm", snippetType = "autosnippet" }, {
    t({ "\\[", "\t" }),
    i(0),
    t({ "", "\\]" }),
  }, { condition = in_text }),

  -- Single-letter variables
  s(
    {
      trig = " ([^aeouAEOUY%^%A%E%O%Y%&y%s%|%$%(%=%)%[%]%{%}%.%,%!%:%?%/%\\%`%;%'%-%_])([%p%s])",
      snippetType = "autosnippet",
      regTrig = true,
      wordTrig = false,
    },
    f(function(_, snip)
      return " $" .. snip.captures[1] .. "$" .. snip.captures[2]
    end),
    { condition = in_text }
  ),

  -- Quotes
  s({ trig = '"', snippetType = "autosnippet" }, fmt([[``{}'' ]], i(1)), { condition = in_text }),

  -- Emphasis
  s("emph", fmt([[\emph{{{}}}]], i(1)), { condition = in_text }),

  -- Link
  s(
    { trig = ";link", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta([[\href{ <> }{ <> } <> ]], {
      i(1, "Link"),
      i(2, "Description"),
      i(0),
    }),
    { condition = in_text }
  ),

  -- Boldface
  s({ trig = "bf", priority = 4, snippetType = "autosnippet" }, fmt([[\textbf{{{}}}]], i(1)), { condition = in_text }),

  -- Teletype
  s("tt", fmt([[\texttt{{{}}}]], i(1)), { condition = in_text }),

  -- Ordinal th
  s({ trig = "([%d$])th", regTrig = true, wordTrig = false }, {
    f(function(_, snip)
      return snip.captures[1] .. "\\tsup{th}"
    end),
  }, { condition = in_text }),

  -- Image
  s("img", {
    t({ "\\begin{center}", "\t\\resizebox{" }),
    i(1, "5"),
    t("in}{!}{\\includegraphics{./"),
    i(2),
    t({ "}}", "\\end{center}" }),
  }, { condition = in_text }),
}
