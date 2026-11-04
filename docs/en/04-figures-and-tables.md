# Figures and tables

[Tiếng Việt](../vi/04-hinh-va-bang.md) | **English**

Figures and tables are numbered per chapter: Figure 2.1, Figure 2.2, Table 3.1… Always give them a `\label` so you can refer to them with `\cref` (see [Cross-references](06-cross-references-and-citations.md)).

## Figures

### Inserting an image

Put the image file in `images/`, optionally in one subfolder per chapter:

```text
images/
├── 01-introduction/
│   └── timeline.png
└── 02-method/
    ├── architecture.pdf
    └── survey-form.jpg
```

```latex
\begin{figure}[H]
  \centering
  \includegraphics[width=0.8\textwidth]{02-method/architecture}
  \caption{System architecture}\label{fig:architecture}
\end{figure}
```

- The path is relative to `images/` and **needs no file extension**. LaTeX looks for `.pdf`, `.png` and `.jpg` by itself.
- `width=0.8\textwidth` is 80% of the text width. You can also use `height=6cm`, or `width=\textwidth, height=8cm, keepaspectratio` to fit the image in a box without distorting it.
- The caption goes **below** a figure, and `\label` right after `\caption`.

> [!WARNING]
> File and folder names must have no accents and no spaces, and upper/lower case must match. On Windows `Chart.png` and `chart.png` are the same file, but Overleaf and GitHub tell them apart, so the build there reports a missing file.

**Which format?** Export diagrams and charts (from draw.io, Excel, matplotlib…) as **PDF** so they stay sharp when zoomed. Use **PNG** for screenshots and **JPG** for photos.

### Figure placement

| Write | Meaning |
| --- | --- |
| `[H]` | Place it **exactly here** in the source. Predictable, but may leave white space at the bottom of a page when the figure does not fit |
| `[htbp]` | Let LaTeX choose: here, top of page, bottom of page or a page of its own. Gives a better layout in reports with many figures |

With `[htbp]` a figure may float to the next page, so write "as shown in \cref{fig:...}" rather than "the figure below".

### Side-by-side images

```latex
\begin{figure}[H]
  \centering
  \begin{subfigure}{0.45\textwidth}
    \centering
    \includegraphics[width=\linewidth]{03-results/before}
    \caption{Before optimisation}\label{fig:before}
  \end{subfigure}\hfill
  \begin{subfigure}{0.45\textwidth}
    \centering
    \includegraphics[width=\linewidth]{03-results/after}
    \caption{After optimisation}\label{fig:after}
  \end{subfigure}
  \caption{Response time comparison}\label{fig:comparison}
\end{figure}
```

This gives Figure 3.1a, Figure 3.1b and Figure 3.1. `\cref{fig:before}` prints "Figure 3.1a", `\cref{fig:comparison}` prints "Figure 3.1".

The widths of the `subfigure`s (here 0.45 + 0.45) must add up to less than 1. For three images in a row, use 0.3 each.

### Drawing diagrams with TikZ

Simple diagrams can be drawn directly in LaTeX, with no image file, and their text uses the same font as the report. See the full example in `chapters/02-method.tex`:

```latex
\begin{figure}[H]
  \centering
  \begin{tikzpicture}[
      node distance=1.2cm,
      box/.style={draw=primary, fill=primary!8, rounded corners,
                  minimum width=2.6cm, minimum height=1cm, align=center},
      arrow/.style={-Stealth, thick, primary}]
    \node[box] (a) {Collect};
    \node[box, right=of a] (b) {Process};
    \node[box, right=of b] (c) {Evaluate};
    \draw[arrow] (a) -- (b);
    \draw[arrow] (b) -- (c);
  \end{tikzpicture}
  \caption{Workflow}\label{fig:pipeline}
\end{figure}
```

For complex diagrams, drawing them in [draw.io](https://app.diagrams.net) and exporting to PDF is quicker.

## Tables

The template uses **booktabs**-style tables: no vertical rules, just three horizontal ones (top, below the header, bottom). They are easier to read than fully ruled grids.

A table's caption goes **above** the table, the opposite of figures (caption below).

### A basic table

```latex
\begin{table}[H]
  \centering
  \caption{Experimental results}\label{tab:results}
  \begin{tabular}{@{}lcr@{}}
    \toprule
    \textbf{Model} & \textbf{Accuracy} & \textbf{Time (s)} \\
    \midrule
    Baseline  & 0.72 & 12.4 \\
    Proposed  & 0.85 & 15.1 \\
    \bottomrule
  \end{tabular}
\end{table}
```

- `&` separates columns, `\\` ends a row.
- `{@{}lcr@{}}`: three columns aligned left (`l`), centre (`c`) and right (`r`). The `@{}` at each end removes the extra space at the table's edges.
- `\toprule`, `\midrule` and `\bottomrule` are the three rules. To separate groups of rows, use `\addlinespace` (white space) or `\midrule`.
- Right-align numbers (`r`) so the digits line up.

### Tables with long text

In `l`/`c`/`r` columns text does not wrap, so the table easily runs into the margin. Use `tabularx` with the template's column types instead:

```latex
\begin{table}[H]
  \centering
  \caption{Comparison of options}\label{tab:comparison}
  \begin{tabularx}{\textwidth}{@{}P{3cm}LC@{}}
    \toprule
    \textbf{Option} & \textbf{Remarks} & \textbf{Score} \\
    \midrule
    Option A & Low cost but narrow scope, hard to scale as the number of users grows. & 0.55 \\
    \addlinespace
    Option B & Balances cost and benefit. & 0.80 \\
    \bottomrule
  \end{tabularx}
\end{table}
```

| Column type | Meaning |
| :---: | --- |
| `l`, `c`, `r` | As wide as the content, aligned left/centre/right, no wrapping |
| `L` | Stretches so the table is exactly `\textwidth` wide, left-aligned, wraps |
| `C` | Like `L` but centred |
| `P{3cm}` | Fixed width of 3 cm, left-aligned, wraps |

The table needs at least one `L` or `C` column so that `tabularx` knows which column to stretch.

### Merged cells and row colours

```latex
\begin{tabular}{@{}llr@{}}
  \toprule
  \textbf{Group} & \textbf{Item} & \textbf{Value} \\
  \midrule
  \multirow{2}{*}{A} & Design      & 1 \\
                     & Programming & 2 \\
  \cmidrule(l){2-3}
  \rowcolor{primary!10} B & Testing & 3 \\
  \bottomrule
\end{tabular}
```

- `\multirow{2}{*}{A}` merges 2 rows of the first column; leave that cell empty in the following rows.
- `\multicolumn{2}{c}{Shared heading}` merges 2 columns.
- `\cmidrule(l){2-3}` draws a short rule under columns 2 to 3 only.
- `\rowcolor{primary!10}` shades the row with the theme colour at 10%.

### Tables that are too long or too wide

- Wide table: shrink the text with `\small` or `\footnotesize` right after `\centering`, or turn the text columns into `L`.
- Table longer than a page: split it into several smaller tables, or move the full table to an appendix and keep a summary in the text.

### Building tables quickly

For a large table that already exists in Excel or Google Sheets, use [Tables Generator](https://www.tablesgenerator.com/latex_tables): paste the data, choose *Booktabs table style*, copy the code back, then fix the caption and label.

---

[← Previous: Writing text](03-writing.md) | [Contents](README.md) | [Next: Math and code →](05-math-and-code.md)
