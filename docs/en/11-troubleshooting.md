# Troubleshooting

[Tiếng Việt](../vi/11-xu-ly-loi.md) | **English**

**Reading errors**: in VS Code, open the *Problems* tab (`Ctrl+Shift+M`); each error shows a file and line number, and clicking it jumps there. On Overleaf, click the log icon next to *Recompile*.

> [!IMPORTANT]
> Fix the **first error** first: one error often drags many others along behind it.

## Build errors

### `Undefined control sequence`

A misspelled command (for example `\cfer` instead of `\cref`), or a command from a package that is not loaded. Check the line the error points to.

### `Misplaced alignment tab character &` or `Missing $ inserted`

The text contains `&` or `_` that should be written `\&`, `\_`. This often happens with variable names, file names and URLs outside `\url{...}`. See the table of [special characters](03-writing.md#special-characters).

### `Runaway argument` or `File ended while scanning`

A closing `}` is missing. The mistake is usually **before** the reported line. In VS Code, put the cursor next to a `{` to see its matching brace highlighted.

### `Invalid UTF-8 byte sequence`

- In the `.bbl` file: a Vietnamese author whose given name starts with an accented letter has been cut by BibTeX. Put the whole name in double braces, for example `{{Nguyễn Đức Anh}}` (see [Citations](06-cross-references-and-citations.md#common-mistakes-in-the-bib-file)).
- Inside `lstlisting`: the code contains Vietnamese diacritics. Remove them, or write the comments in English.
- Otherwise: the file is not saved as UTF-8 (see below).

### Vietnamese text is garbled or loses its accents

Files must be saved as **UTF-8**. In VS Code, look at the bottom-right corner: if it does not say `UTF-8`, click it and choose *Save with Encoding → UTF-8*. Files copied from Word or from another computer often have this problem.

### `File '...png' not found`

- The path in `\includegraphics{...}` is relative to `images/` and needs no file extension.
- Check upper/lower case: `Chart.png` is not `chart.png` on Overleaf and GitHub, even though it works on Windows.
- File names must have no accents and no spaces.

### `I can't write on file 'chapters/....aux'`

You are running `pdflatex` directly. Build with `latexmk` or LaTeX Workshop instead: they are set up to create the subfolders needed in `build/`.

### `latexmk` does not run on Windows

Usually MiKTeX without Perl. Install [Strawberry Perl](https://strawberryperl.com) and restart VS Code, or switch to TeX Live.

### `Package amsmath Error: Multiple \label's`

Two `\label`s on the same equation line, usually a forgotten `\\` between the lines of an `align`.

## The PDF does not look right

### `??` or `[?]` in the PDF

Build once more. If they are still there:

- `??`: the name in `\cref{...}` matches no `\label{...}`.
- `[?]`: the key in `\cite{...}` matches no entry in `references.bib`, or the `.bib` file has a syntax error. See `build/main.blg`.

### A source is missing from the bibliography

Only `\cite`d sources are listed. Use `\nocite{key}` to list a source that is not cited in the text.

### A figure is in the wrong place

Use `[H]` to place the figure exactly where it is in the source. See [Figure placement](04-figures-and-tables.md#figure-placement).

### A table or figure runs into the right margin

- Table: use `tabularx` with an `L` column so the text wraps (see [Tables with long text](04-figures-and-tables.md#tables-with-long-text)).
- Figure: set `width=\textwidth` or less.
- Long URL: put it in `\url{...}` so it can break across lines.

### A wide space after a period mid-sentence

LaTeX took the abbreviation's period for the end of a sentence. Put `\` before the space: `e.g.\ ChatGPT`, `AI vs.\ humans`, `Dr.\ Nguyen`.

### `\todo` notes do not show

Notes only appear in the draft. Add `draft` to the `\usepackage` line in `main.tex`.

### The final version still says DRAFT

Remove `draft` from the `\usepackage` line in `main.tex` and rebuild.

### Chapters are missing from the PDF

The `\includeonly{...}` line in `main.tex` has not been commented out.

### The list of abbreviations is missing, or lacks some entries

Only abbreviations used through `\ac`, `\acs`… are listed. An abbreviation typed by hand does not count.

## Tool problems

### The PDF does not update, or odd errors after many changes

Delete the auxiliary files and rebuild: run `latexmk -C`, then `latexmk`. In VS Code, use *LaTeX Workshop: Clean up auxiliary files*.

### `Ctrl` + click in the PDF does not jump to the code

`main.synctex.gz` must sit next to `main.pdf`. Build with LaTeX Workshop or `latexmk`, and do not delete or move that file.

### Two builds in a row fail with strange errors

VS Code builds on every save. If you also run `latexmk` in a terminal, the two builds overwrite each other in `build/`. Wait for one build to finish and run it again, or turn off automatic builds (see [Tools](09-tools.md#latex-workshop-vs-code)).

### `> [!NOTE]` boxes in the README show up as plain quotations

VS Code's built-in Markdown preview does not support these boxes. Open the file with Markdown Preview Enhanced (`Ctrl+K` `V`); see [Viewing the Markdown docs](09-tools.md#viewing-the-markdown-docs).

## Still stuck?

1. Read the first error in `build/main.log` (look for a line starting with `!` or containing `Error`).
2. Comment out the passage you just changed with `%` to narrow it down: if the error goes away, it is in that passage.
3. Search for the exact error message on [TeX Stack Exchange](https://tex.stackexchange.com).

---

[← Previous: Customization](10-customization.md) | [Contents](README.md) | [Next: Cheat sheet →](12-cheat-sheet.md)
