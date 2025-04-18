-- LuaSnip snippets for LaTeX custom environments.
-- Includes math, logic, and programming structures.

local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local rep = require("luasnip.extras").rep
local fmta = require("luasnip.extras.fmt").fmta

return {
  -- === Math environments === --

  s(
    { trig = ";def", dscr = "Definition environment.", snippetType = "autosnippet" },
    fmta(
      [[
      \dfn{<>}{<>}

      <>
      ]],
      {
        i(1, "Name:"),
        i(2, "Content:"),
        i(0),
      }
    )
  ),

  s(
    { trig = ";prob", dscr = "Problem environment.", snippetType = "autosnippet" },
    fmta(
      [[
      \prob{<>}{<>}

      <>
      ]],
      {
        i(1, "Title:"),
        i(2, "Content:"),
        i(0),
      }
    )
  ),

  s(
    { trig = ";qs", dscr = "Question environment.", snippetType = "autosnippet" },
    fmta(
      [[
      \qs{<>}{<>}

      <>
      ]],
      {
        i(1, "Title:"),
        i(2, "Content:"),
        i(0),
      }
    )
  ),

  s(
    { trig = ";sol", dscr = "Solution environment.", snippetType = "autosnippet" },
    fmta(
      [[
      \sol{<>}

      <>
      ]],
      {
        i(1, "Content:"),
        i(0),
      }
    )
  ),

  s(
    { trig = ";note", dscr = "Note environment.", snippetType = "autosnippet" },
    fmta(
      [[
      \nt{<>}

      <>
      ]],
      {
        i(1, "Content:"),
        i(0),
      }
    )
  ),

  s(
    { trig = ";obs", dscr = "Claim environment.", snippetType = "autosnippet" },
    fmta(
      [[
      \clm{<>}{}{<>}

      <>
      ]],
      {
        i(1, "Title:"),
        i(2, "Content:"),
        i(0),
      }
    )
  ),

  s(
    { trig = ";ex", dscr = "Example environment.", snippetType = "autosnippet" },
    fmta(
      [[
      \ex{<>}{<>}

      <>
      ]],
      {
        i(1, "Title:"),
        i(2, "Content:"),
        i(0),
      }
    )
  ),

  s(
    { trig = ";th", dscr = "Theorem environment.", snippetType = "autosnippet" },
    fmta(
      [[
      \thm{<>}{<>}

      <>
      ]],
      {
        i(1, "Title:"),
        i(2, "Content:"),
        i(0),
      }
    )
  ),

  s(
    { trig = ";cor", dscr = "Corollary environment.", snippetType = "autosnippet" },
    fmta(
      [[
      \cor{<>}{<>}

      <>
      ]],
      {
        i(1, "Title:"),
        i(2, "Content:"),
        i(0),
      }
    )
  ),

  s(
    { trig = ";lemm", dscr = "Lemma environment.", snippetType = "autosnippet" },
    fmta(
      [[
      \mlenma{<>}{<>}

      <>
      ]],
      {
        i(1, "Title:"),
        i(2, "Content:"),
        i(0),
      }
    )
  ),

  s(
    { trig = ";prop", dscr = "Proposition environment.", snippetType = "autosnippet" },
    fmta(
      [[
      \mprop{<>}{<>}

      <>
      ]],
      {
        i(1, "Title:"),
        i(2, "Content:"),
        i(0),
      }
    )
  ),

  -- === Proof and logic structures === --

  s(
    { trig = ";proof", dscr = "Proof environment.", snippetType = "autosnippet" },
    fmta(
      [[
      \begin{myproof}

      <>

      \end{myproof}

      <>
      ]],
      {
        i(1, "Proof..."),
        i(0),
      }
    )
  ),

  s(
    { trig = ";prog", dscr = "Program box (steps).", snippetType = "autosnippet" },
    fmta(
      [[
      \steps{

      <>

      }
      ]],
      {
        i(1, "Steps..."),
      }
    )
  ),

  s(
    { trig = ";steps", dscr = "Logical steps.", snippetType = "autosnippet" },
    fmta(
      [[
      \steps{

      <>

      }
      ]],
      {
        i(1, "Steps..."),
      }
    )
  ),

  s(
    { trig = ";lstep", dscr = "Single logic step.", snippetType = "autosnippet" },
    fmta(
      [[
      \lstep{<>}

      <>
      ]],
      {
        i(1, "Step..."),
        i(0),
      }
    )
  ),

  -- === Code blocks (minted) === --

  s(
    { trig = ";src", dscr = "Code environment (minted).", snippetType = "autosnippet" },
    fmta(
      [[
      \begin{<>code}

      <>

      \end{<>code}
      ]],
      {
        i(1, "lang"),
        i(2, "code"),
        rep(1),
      }
    )
  ),

  s(
    { trig = ";code", dscr = "Alias for code environment.", snippetType = "autosnippet" },
    fmta(
      [[
      \begin{<>code}

      <>

      \end{<>code}
      ]],
      {
        i(1, "lang"),
        i(2, "code"),
        rep(1),
      }
    )
  ),
}
