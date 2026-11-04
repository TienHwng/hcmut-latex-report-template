# Tools: build, linting, CI

[Tiếng Việt](../vi/09-cong-cu.md) | **English**

## Building

### LaTeX Workshop (VS Code)

Open the template **folder** in VS Code. Every time you save a `.tex` file, LaTeX Workshop rebuilds.

| Action | Shortcut or command |
| --- | --- |
| Build | Save (`Ctrl+S`), or `Ctrl+Alt+B` |
| View the PDF in VS Code | `Ctrl+Alt+V` |
| See errors and warnings | *Problems* tab (`Ctrl+Shift+M`) |
| See the full build log | *TeX* button in the left sidebar → *View log messages* |
| Delete auxiliary files | `Ctrl+Shift+P` → *LaTeX Workshop: Clean up auxiliary files* |

Don't want a build on every save? Open *Settings* (`Ctrl+,`), search for `latex-workshop.latex.autoBuild.run` and choose `never`. Then press `Ctrl+Alt+B` to build.

### latexmk (terminal)

```sh
latexmk            # build main.pdf
latexmk -pvc       # rebuild on every save, until you press Ctrl+C
latexmk -c         # delete auxiliary files, keep main.pdf
latexmk -C         # delete auxiliary files and main.pdf
latexmk -g         # force a full rebuild even if nothing changed
```

`latexmk` runs pdfLaTeX and BibTeX as many times as needed for references and citations to come out right.

### Generated files

```text
template-latex/
├── main.pdf            # the output to submit
├── main.synctex.gz     # data for jumping between code and PDF
└── build/              # every auxiliary file: .aux, .log, .bbl, .toc...
    ├── main.log        # full log, read it when something fails
    └── main.blg        # BibTeX's log, read it when citations go wrong
```

> [!IMPORTANT]
> This layout is set in both `.latexmkrc` and `.vscode/settings.json`. If you change it, change **both** to match. On Overleaf `.latexmkrc` has no effect, because Overleaf manages its own build folder.

A good build has **no warnings at all**. After a build, the *Problems* tab should be empty.

### Other configuration files

| File | Purpose |
| --- | --- |
| `.latexmkrc` | `latexmk` settings: PDF in the root folder, auxiliary files in `build/` |
| `.chktexrc` | ChkTeX's rules |
| `.editorconfig` | UTF-8 and indentation settings shared by every editor |
| `.gitignore` | Keeps `build/` and the PDF out of Git |
| `.markdownlint.jsonc` | Rules for checking the Markdown files (README, docs) |
| `.vscode/settings.json` | Settings for LaTeX Workshop, ChkTeX, LTeX+ |
| `.vscode/extensions.json` | Extensions VS Code recommends installing |
| `.github/workflows/build.yml` | GitHub Actions: linting, building the PDF, releases |
| `AGENTS.md`, `CLAUDE.md` | Instructions for AI assistants (see [Getting started](00-getting-started.md#using-an-ai-assistant)) |
| `.github/MAINTAINING.md` | Notes for whoever maintains the template itself; not needed to write a report |

## Linting: ChkTeX

ChkTeX finds common LaTeX mistakes, such as a missing `~` before `\cite`, the wrong kind of dash, or the space after an abbreviation's period.

- **VS Code**: runs automatically on every save; problems are underlined in yellow and listed in the *Problems* tab.
- **Terminal**:

  ```sh
  chktex -q -l .chktexrc main.tex      # no output means clean
  ```

`.chktexrc` already turns off warnings that do not suit the template, for example warning 46 (asking for `\(...\)` instead of `$...$`, see [Math](05-math-and-code.md#inline-and-displayed)). You will rarely need to silence a warning on a single line, but if you do, add the comment `% chktex 8` (the number is the warning code) at the end of that line.

## English spell checking: LTeX+

The **LTeX+** extension checks English spelling and grammar right inside `.tex` files and underlines doubtful passages in blue. Hover over an underline to see suggestions.

- A technical term flagged as wrong: choose *Add to dictionary*. It is stored in `ltex.dictionary` in `.vscode/settings.json`, so the whole group shares it.
- To skip a Vietnamese passage inside an English report, wrap it between the lines `% LTeX: enabled=false` and `% LTeX: enabled=true`, as in `frontmatter/declaration.tex`.

LTeX+ **does not support Vietnamese**. For a Vietnamese report, turn it off to reduce noise: change `"ltex.enabled": ["latex"]` to `"ltex.enabled": false` in `.vscode/settings.json`.

## Word count

- **VS Code**: `Ctrl+Shift+P` → *LaTeX Workshop: Count words in LaTeX project*.
- **Terminal**:

  ```sh
  texcount -inc -brief -q main.tex     # words per chapter and in total
  ```

- **Overleaf**: *Menu → Word Count*.

Only the content is counted, not LaTeX commands or comments.

## Automatic builds on GitHub

If the group puts the repository on GitHub, `.github/workflows/build.yml` runs on every push to the `main` branch and on every pull request. It has three jobs that run in parallel:

| Job | What it does | When it fails |
| --- | --- | --- |
| `lint` | Runs ChkTeX as above | There are formatting warnings. Fix them from the job's log; the PDF is still built |
| `docs` | Checks README and `docs/` with markdownlint | A Markdown file is badly formatted. If your group does not need the docs, delete this job from `build.yml` |
| `build` | Builds `main.pdf` with a full TeX Live | There is a LaTeX error. The log shows which line |

**Downloading the PDF**: open the repository's *Actions* tab, pick the latest run, and download the file under *Artifacts* (`report-pdf`, as a ZIP).

**Tagging a release**: push a tag starting with `v` and GitHub creates a *Release* with the PDF attached, handy for sending to the lecturer or archiving what you submitted:

```sh
git tag v1.0                 # e.g. the mid-term submission
git push origin v1.0
```

If you do not want this, delete the `.github/` folder.

## Viewing the Markdown docs

The README and the pages in `docs/` use GitHub's **alert boxes** (Obsidian uses the same syntax for its callouts):

```markdown
> [!TIP]
> The content of the box.
```

There are five kinds: `NOTE`, `TIP`, `IMPORTANT`, `WARNING` and `CAUTION`. GitHub shows them as coloured boxes with an icon. VS Code's built-in Markdown preview only shows them as plain quotations.

To see them properly in VS Code, use the **Markdown Preview Enhanced** extension (already in the template's recommended extensions):

| Action | Shortcut |
| --- | --- |
| Open the preview beside the file | `Ctrl+K` then `V` |
| Open the preview in place of the file | `Ctrl+Shift+V` |

Once Markdown Preview Enhanced is installed, these two shortcuts open its preview instead of the built-in one. The top-right corner of the editor then has two similar-looking preview buttons, one from VS Code and one from the extension, so the shortcuts are the safest choice.

Use only these five kinds. Obsidian also has `[!info]`, `[!example]`, collapsible `[!note]-` and so on, but GitHub does not understand them. Two boxes in a row need a `<!-- -->` line between them, or they merge into one.

---

[← Previous: Teamwork](08-teamwork.md) | [Contents](README.md) | [Next: Customization →](10-customization.md)
