-- Luasnips shorthands
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

-- Utility functions

return {
  s(
    {
      trig = "generate-preamble",
      dscr = "Basics to start writing a document.",
      regTrig = false,
      priority = 1000,
      snippetType = "autosnippet",
    },
    fmt(
      [[
\documentclass{report}


\input{\string ~/mi-preamble-latex/preamble.tex}
\input{\string ~/mi-preamble-latex/macros.tex}
\input{\string ~/mi-preamble-latex/letterfonts.tex}


\title{\Huge{<>}\\<>}
\author{\Huge{<>}}
\date{<>}

\begin{document}

\maketitle
\newpage
\pdfbookmark[section]{\contentsname}{toc}
\tableofcontents
\pagebreak

\chapter{<>}
\section{<>}

<>

\end{document}
  ]],
      -- The insert node is placed in the <> angle brackets
      { -- Nodes in each delimitier, in this case "<>"
        i(1, "Título:"),
        i(2, "Subtítulo:"),
        i(3, "Autor:"),
        f(function()
          return os.date("%d-%m-%Y")
        end),
        i(5, "Capítulo:"),
        i(6, "Sección: "),
        i(0),
      },
      -- This is where I specify that angle brackets are used as node positions.
      { delimiters = "<>" }
    )
  ),
}
