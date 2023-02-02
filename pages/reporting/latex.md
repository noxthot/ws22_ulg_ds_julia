@def title = "LaTeX"
@def hascode = false

@def tags = ["reporting"]

# $\LaTeX$

\toc

## Introduction

LaTeX, also stylized as $\LaTeX$, is a software based on the typesetting system $\TeX$ which was developed by computer scientist and Stanford University professor Donald Knuth and first released in 1978. It is widely used in academia, especially in STEM fields, because it allows everyone to produce high-quality papers and books with little effort. The most useful features of LaTeX include the following.

- Typesetting special characters like $\varepsilon$ or $\int_0^1 x^2 \mathrm{d}x$ or $\sum_{j=0}^N j$ is easy.
- Figures, tables, sections, pages, etc. are enumerated automatically and updated whenever you compile your document.
- LaTeX deals with your citations and handles the bibliography.

## WYSIWYG versus WYSIWYAF

After writing a document with a word processing software like MS Word the printed version of it looks like a copy of what
you saw on the monitor. One could also say that "**W**hat **Y**ou **S**ee **I**s **W**hat **Y**ou **G**et". In contrast,
LaTeX uses plain text and macros (commands) to translate your "scripted" document into a PDF which looks nothing like
what you saw. Hence, "**W**hat **Y**ou **S**ee **I**s **W**hat **Y**ou **A**sked **F**or".

In the beginning remembering the individual LaTeX commands by heart might seem difficult. But quite soon you will notice that letting LaTeX handle all the tedious things like, e.g., formatting the document is actually worth the effort.

## Compiling a Document

Download and install a TeX distribution like [MiKTeX](https://miktex.org/) or [TeX Live](https://tug.org/texlive/) and
(optionally) an IDE, for example [TeXnicCenter](https://www.texniccenter.org/). Put the following in a `main.tex` file

```tex
\documentclass[12pt]{article}

\begin{document}
Hello World!
\end{document}
```

and compile it using

```bash
pdflatex main.tex
```

The output is a white sheet with "Hello World!" written on top of it and the number of the page at the bottom. Notice how LaTeX
inserted this number automatically?

## Basic Syntax

Comment lines start with an `%`. There are no multi-line comments. Every LaTeX command starts with a backslash
`\somecommand`. Every document starts with a definition of its type.

```tex
\documentclass[12pt]{article}
```

Other possible document types include but are not limited to `book`, `report`, `presentations`, etc. The options for the document appear in the `[]` brackets. In this case we want to use `12pt` font.

If you want to include graphics, colored text, or source code from another language into your document, you need to enhance the capabilities of LaTeX. This is done by adding packages.

```tex
\usepackage{caption}
\usepackage{float}
\usepackage{hyperref}
...
```

Providing information about the title page is as simple as setting the following variables.

```tex
\author{John Doe \& \\
Jane Doe}
\date{\today}
\title{Reporting ULG 2023}
```

Everything we have seen so far belongs to the so-called preamble. The actual document begins with the keyword

```tex
\begin{document}
```

We can let LaTeX create a title page based on the information we provided above and add a table of contents with

```tex
\maketitle

\tableofcontents
```

Adding new sections, subsections, and subsubsections is intuitive.

```tex
\section{First Section}
\section{Another section}
\subsection{First Subsection}
\subsubsection{First Subsubsection}
```

If you would like to suppress the numbering just add an asterisk after the keyword.

```tex
\section*{Unnumbered Section}
\subsection*{Unnumbered Subsection}
\subsubsection*{Unnumbered Subsubsection}
```

With LaTeX you can label pretty much anything from figures to sections to tables. Let us assume you would like to refer
to some previous section in another section of your document. Just label the command and refer to it accordingly. Try and
provide a unique informative label.

```tex
\section{Previous Section}\label{sec:previous}

\section{Some Other Section}
This is a reference the previous Section~\ref{sec:previous}.
```

Lists are one of the easiest things to create in LaTeX. Just wrap the items inside of an `enumerate` environment
if you want to have numbers

```tex
\begin{enumerate} % This creates an "enumerate" environment.
  % \item tells the enumerate to increment
  \item First item.
  \item Second item.
\end{enumerate} % All environments must have an end.
```

or an `itemize` environment if you need bullet points

```tex
\begin{itemize} % This creates an "itemize" environment.
  \item First bullet point.
  \item Second bullet point.
\end{itemize}
```

## Mathematics

Many people use LaTex for its abundance of special symbols and characters especially in mathematics. These include set and relation symbols, arrows, operators, and Greek letters just to name a few. You enter the in-line math mode with dollar signs `$x$` and the regular math mode with

```tex
\[
    a + b = c
\]
```

Here is a very incomplete list of the most commonly used mathematical symbols.

- Quantifiers in logic

  | Syntax       | Output     |
  | ------------ | ---------- |
  | `$\forall$`  | $\forall$  |
  | `$\exists$`  | $\exists$  |
  | `$\exists!$` | $\exists!$ |
  | `$\neg$`     | $\neg$     |
  | `$\nexists$` | $\nexists$ |
  | `$\neg$`     | $\neg$     |

- Sets and relations

  | Syntax          | Output        |
  | --------------- | ------------- |
  | `$\subset$`     | $\subset$     |
  | `$\not\subset$` | $\not\subset$ |
  | `$\supset$`     | $\supset$     |
  | `$\not\supset$` | $\not\supset$ |
  | `$\gg$`         | $\gg$         |
  | `$\geq$`        | $\geq$        |
  | `$\ll$`         | $\ll$         |
  | `$\leq$`        | $\leq$        |
  | `$\approx$`     | $\approx$     |
  | `$\neq$`        | $\neq$        |

- Greek alphabet

  | Syntax     | Output   |
  | ---------- | -------- |
  | `$\alpha$` | $\alpha$ |
  | `$\beta$`  | $\beta$  |
  | `$\gamma$` | $\gamma$ |
  | $\ldots$   | $\ldots$ |

- Common functions

  | Syntax   | Output |
  | -------- | ------ |
  | `$\sin$` | $\sin$ |
  | `$\cos$` | $\cos$ |
  | `$\tan$` | $\tan$ |
  | `$\log$` | $\log$ |
  | `$\exp$` | $\exp$ |

- Miscellaneous

  | Syntax              | Output            |
  | ------------------- | ----------------- |
  | `$\int_0^1$`        | $\int_0^1$        |
  | `$\sum_{j=0}^N j$`  | $\sum_{j=0}^N j$  |
  | `$\prod_{j=1}^N j$` | $\prod_{j=1}^N j$ |
  | `$\frac{a}{b}$`     | $\frac{a}{b}$     |

We can also insert equations in an "equation environment"

```tex
\begin{equation}\label{eq:pythagoras} % for referencing
    a^2 + b^2 = c^2
\end{equation}
```

and reference to it using `\ref{eq:pythagoras}`. It is best practice to use these labels for different things.

| Label   | Refering To          |
| ------- | -------------------- |
| ch:     | chapter              |
| sec:    | section              |
| subsec: | subsection           |
| fig:    | figure               |
| tab:    | table                |
| eq:     | equation             |
| lst:    | code listing         |
| itm:    | enumerated list item |
| alg:    | algorithm            |
| app:    | appendix subsection  |

## Tables

With the `booktabs` package you can create beautiful tables with LaTeX. The syntax is quite self-explanatory.

```tex
\begin{tabular}{c|cc}  % centered, vertical line, centered, centered
    \toprule
    A & B & C \\
    \midrule
    1 & ULG & 2023 \\
    2 & Foo & Bar
    \bottomrule
\end{tabular}
```
