# Teamwork

[Tiếng Việt](../vi/08-lam-viec-nhom.md) | **English**

## Splitting the work by file

Each chapter is its own file in `chapters/`. Assign **one or a few files to each person**:

- Two people never edit the same file at the same time, so Git conflicts are rare.
- On Overleaf, everyone opens their own file, and the history shows who changed what.
- Shared data (`config/metadata.tex`, `config/abbreviations.tex`, `bib/references.bib`) is best owned by one person. If everyone needs to add to them, add new lines at the **end of the file** to avoid overwriting each other.

To avoid clashing labels when several people write, include the chapter name in the label: `fig:method-pipeline`, `tab:results-cost`.

## Notes for each other

Notes are written straight into the source and only show up when building with the `draft` option (see [Options](02-options.md#draft-draft)):

```latex
\todo{Needs a source for this figure}          % orange margin note
\todo[inline]{Rewrite this paragraph}          % note across the full text width
\note{Should this table go to the appendix?}   % blue note
\note[Binh]{Checked the numbers again, OK}     % blue note with the author's name
```

- Every note is collected on the **List of Todos** page right after the table of contents; click a line to jump to the note.
- In the final version (without `draft`), all notes disappear. You do not have to delete them, but resolve them all before submitting.
- Long margin notes may get pushed down the page. Use `[inline]` for long notes.

Don't put `\todo` inside `\caption`, `\section` or a table cell. Put it right after them.

To find leftover notes in VS Code: `Ctrl+Shift+F` and search for `\todo` or `\note`.

## Building only the chapter you are writing

A long report takes a while to build. While writing, you can build just your chapter by removing the `%` in front of the `\includeonly` line in `main.tex`:

```latex
\includeonly{chapters/02-method}
\includeonly{chapters/02-method,chapters/03-results}    % several chapters
```

- The cover, the table of contents and the front pages are still built; only the chapters missing from the list are skipped.
- Page numbers, figure numbers and references to other chapters stay correct, because LaTeX reuses what it learned in the last full build.
- This only works for parts pulled in with `\include`, that is, chapters and appendices.

> [!IMPORTANT]
> **Comment the `\includeonly` line out again** before building the final version, or the PDF will be missing chapters.

## Jumping between code and PDF (SyncTeX)

In VS Code with LaTeX Workshop:

| Action | Result |
| --- | --- |
| `Ctrl` + click on text in the PDF | Opens the source at that line |
| `Ctrl+Alt+J` in the source | Scrolls the PDF to the passage you are editing |

Overleaf has the same feature: double-click the PDF, or use the arrow buttons between the two panes.

It needs `main.synctex.gz` next to `main.pdf`; building with `latexmk` or LaTeX Workshop creates it.

## Using Git

The folder already has a `.gitignore`, so the auxiliary files in `build/` and the PDF stay out of the repository.

A suggested routine for the group:

```sh
git pull                              # get the latest version before writing
# ... write your chapter ...
git add chapters/02-method.tex
git commit -m "Write section 2.1 Data collection"
git pull                              # merge your teammates' changes
git push
```

- Commit often, with clear messages.
- Write one sentence per line in the `.tex` files. LaTeX still prints normal paragraphs, while Git shows exactly which sentence changed, and conflicts (if any) stay small.
- If the group puts the repository on GitHub, every push builds the PDF (see [CI on GitHub](09-tools.md#automatic-builds-on-github)).

## Overleaf and Git together

Paid Overleaf plans can sync with GitHub (*Menu → Sync → GitHub*). On the free plan, download a ZIP from Overleaf and commit it, or the other way round, upload a ZIP from GitHub to Overleaf as in the [Quick start](README.md#quick-start).

Agree on **one place** (Overleaf or Git) as the master copy, so the two never drift apart.

---

[← Previous: Abbreviations](07-abbreviations.md) | [Contents](README.md) | [Next: Tools: build, linting, CI →](09-tools.md)
