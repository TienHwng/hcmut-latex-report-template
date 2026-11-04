# Writing text

[Tiếng Việt](../vi/03-soan-thao.md) | **English**

## Chapters, sections and subsections

The template uses the `article` class, so **each chapter is a `\section`**:

```latex
\section{Method}\label{sec:method}                  % 2      (chapter)
\subsection{Data collection}\label{sec:data}       % 2.1
\subsubsection{Survey}                             % 2.1.1
\paragraph{Open questions}                         % 2.1.1.1 (bold, not in the table of contents)
```

- The table of contents goes down to `\subsubsection`.
- Starred headings, such as `\section*{Acknowledgements}`, are unnumbered and left out of the table of contents.
- The right-hand header of each page shows the number and name of the current chapter.
- For a long heading, give a short version for the table of contents and the header: `\section[Short version]{A very long heading ...}`.

### Adding, removing and reordering chapters

Each chapter is a file in `chapters/`, pulled into `main.tex` in order:

```latex
\include{chapters/01-introduction}
\include{chapters/02-method}
\include{chapters/03-results}
\include{chapters/05-discussion}     % new file: chapters/05-discussion.tex
\include{chapters/04-conclusion}
```

- Chapters are numbered in `\include` order, not by file name. The `01-`, `02-` prefixes only keep the files sorted in the folder.
- Each `\include` starts on a new page. To run two chapters together on the same page, use `\input` instead of `\include`.

> [!WARNING]
> File names must have no accents and no spaces. `chapter 1.tex` causes confusing errors; name it `01-introduction.tex`.

### Appendices

Create a file in `appendices/` that starts with `\section{...}`, then add it to the `appendices` block in `main.tex`:

```latex
\begin{appendices}
\include{appendices/example}
\include{appendices/survey}          % new file: appendices/survey.tex
\end{appendices}
```

Appendices are lettered (Appendix A, B, C… or Phụ lục A, B, C…), and their subsections are numbered A.1, A.2… Use the `app:` label prefix, for example `\section{Survey form}\label{app:survey}`.

## Paragraphs

- Start a new paragraph with **one blank line**. The template adds space between paragraphs and does not indent them.
- A single line break in the source does not start a new line in the PDF. You can write one sentence per line, which makes changes easier to see in Git.
- New page: `\clearpage`.

**Don't** end a paragraph with `\\`: it causes an `Underfull \hbox` warning and uneven spacing between paragraphs. Several blank lines in a row do not add space either, since LaTeX treats them as one.

### Text formatting

| Write | Result |
| --- | --- |
| `\textbf{text}` | **bold** |
| `\textit{text}` or `\emph{text}` | *italic* |
| `\term{text}` | ***bold italic***, for introducing an important term the first time |
| `\underline{text}` | underlined |
| `\texttt{text}` | `monospace`, for file and command names |
| `\textcolor{primary}{text}` | text in the theme colour (see [Customization](10-customization.md#theme-colours)) |
| `{\small text}`, `{\large text}` | smaller or larger text |

Use `\term` rather than typing `\textbf{\textit{...}}`: to change how terms look across the whole report, you only edit one place in `report.sty`.

### Punctuation

- Quotation marks: open with two backticks (the `` ` `` key left of 1), close with two single quotes. The `"` key gives the wrong marks.

  ```latex
  ``quotation''
  ```

- Hyphen `-` (*well-known*), en dash `--` (*2020--2025*), em dash `---`.
- After an abbreviation ending in a period (vs., e.g., i.e., Dr.) that is followed by more text, put `\` before the space: `e.g.\ ChatGPT`. Otherwise LaTeX assumes the sentence has ended and adds a wide space.
- `~` is a non-breaking space that keeps two words on the same line: `Stage~3`, `Figure~1`.

### Special characters

Some characters mean something to LaTeX and must be written differently:

| To print | Write | To print | Write |
| :---: | --- | :---: | --- |
| % | `\%` | # | `\#` |
| & | `\&` | $ | `\$` |
| _ | `\_` | { } | `\{ \}` |
| ~ | `\textasciitilde{}` | \ | `\textbackslash{}` |

A line (or the end of a line) starting with `%` is a comment and is not printed.

## Lists

```latex
\begin{itemize}                 % bullet points
  \item \textbf{Main point:} explanation...
  \item Second point
  \begin{itemize}               % nested list
    \item Sub-point
  \end{itemize}
\end{itemize}

\begin{enumerate}               % numbered 1. 2. 3.
  \item Step one
  \item Step two
\end{enumerate}

\begin{enumerate}[label=(\alph*)]   % (a) (b) (c); use \roman* for i, ii, iii
  \item Option one
  \item Option two
\end{enumerate}
```

To continue the numbering of the previous list, use `\begin{enumerate}[resume]`.

## Footnotes and links

```latex
According to the survey\footnote{Conducted with 120 students in 2026.} ...

See \url{https://www.hcmut.edu.vn}.
See the \href{https://www.hcmut.edu.vn}{university's home page}.
```

Long addresses in `\url{...}` break across lines by themselves, and you do not need `\_` or `\%` inside `\url`.

## Highlight box

For a research question, a key conclusion or a definition that should stand out:

```latex
\begin{keybox}{Core question}
  How can we ...?
\end{keybox}
```

The box has a frame and a title in the theme colour, and can hold lists, equations or several paragraphs.

## Block quotations

```latex
\begin{quote}
  A long quotation, indented on both sides.
\end{quote}
```

Remember to add `~\cite{...}` to the quotation (see [Citations](06-cross-references-and-citations.md#citations)).

---

[← Previous: Template options](02-options.md) | [Contents](README.md) | [Next: Figures and tables →](04-figures-and-tables.md)
