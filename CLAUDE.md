# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A pdfLaTeX + BibTeX group-report template for HCMUT (Vietnam), currently filled with a sample report ("A.I. in Digital Content"). The user writes to Claude in Vietnamese; README.md is in Vietnamese and is the user-facing guide. Keep it in sync when the template's behaviour changes, and keep it markdownlint-clean.

## Commands

```sh
latexmk                      # build -> main.pdf + main.synctex.gz in root, aux files in build/
latexmk -pvc                 # rebuild on every save
latexmk -c / latexmk -C      # clean aux / also remove PDF
chktex -q -l .chktexrc main.tex          # lint (follows \include); expect no output
texcount -inc -brief -q main.tex         # word count per chapter
```

A good build has zero warnings: check `grep -c Warning build/main.log` and `build/main.blg`.

To compile only one chapter while drafting, uncomment `\includeonly{...}` in main.tex.

To test a template option without editing main.tex, write a temporary copy whose `\usepackage{config/report}` line carries the options, for example `[vietnamese,draft]`. Build it with `latexmk zz-test.tex`, then delete the copy along with `zz-test.*` and `build/zz-test.*`.

## Architecture

Content, data and formatting are deliberately kept apart:

- **`config/report.sty`** is the whole template, as a single package with no report text. It has numbered sections (0 options … 10 cover/tables). Internal macros use the `\rpt@` prefix.
- **`config/metadata.tex`** holds the data only: setters such as `\course{}` and `\instructor{}` (each one just does `\def\rpt@course{...}`) and `\addmember{name}{id}{contribution}{workload}`.
- **`chapters/`, `appendices/`, `frontmatter/`** hold the prose. Chapters and appendices are pulled in with `\include`; frontmatter uses `\input`.

### Template options

Usage is `\usepackage[english|vietnamese, final|draft, print, lists]{config/report}`.

- Each option sets a `\newif` switch: `\ifrpt@vietnamese`, `\ifrpt@draft`, `\ifrpt@print` and `\ifrpt@lists`.
- `\ifreportvietnamese` is a public alias of the language switch, for language-dependent text in content files (see `frontmatter/declaration.tex`).
- `print` applies `hidelinks`.
- `lists` makes `\printfrontlists` add a list of figures and a list of tables. `\printfrontlists` always adds the abbreviations page when any `\abbreviation` is declared.

The language switch controls three separate sources of words:

1. babel's main language, which is the last one in the option list. Both languages are always loaded.
2. Template-owned strings `\rpt@txt@...`, plus the public `\memberlistname` and `\assessmentname`.
3. cleveref names. These are defined capitalised for both `\crefname` and `\Crefname`, because the `[capitalise]` option would otherwise print lowercase Vietnamese.

The switch does not translate the chapter prose.

`draft` loads todonotes and adds a DRAFT watermark through eso-pic. `final` loads `todonotes[disable]`, so `\todo` / `\note` / `\listoftodos` silently vanish. Any new user-visible fixed word in the sty should get both language variants.

### Single-source member list

`\addmember` appends `\rpt@member{..}{..}{..}{..}` to `\rpt@members` and builds `\rpt@authors`, which feeds `pdfauthor`. Each table (`\printstudenttable`, `\printcontributiontable`, `\printassessmenttable`) locally redefines `\rpt@member` to render one row, then expands `\rpt@members`.

The same pattern drives `\printsignaturetable`, which the declaration page uses.

### Other data interfaces

- **Optional cover fields.** `\reporttype`, `\classcode` and `\group` are hidden when left empty.
- **Default date.** `\date` defaults to the build month in the report language. A `\date{}` in metadata.tex overrides it.
- **Abbreviations.** `\abbreviation{key}{SHORT}{Long}` in `config/abbreviations.tex` wraps acro's `\DeclareAcronym` and sets `\ifrpt@abbreviations`.
- **Where to use which acro command:**
  - running text: `\ac` (`\Ac` at the start of a sentence);
  - bold item labels: `\acs`;
  - headings and captions: plain text, because their copies in the TOC/LoT would otherwise consume the first use.

### Theme colours

`primary` (#032B91) and `secondary` (#1488DB) were sampled from the logo. Use them instead of hard-coded colours.

### Build layout

- `.latexmkrc` sets `$out_dir='.'`, `$aux_dir='build'` and `$emulate_aux=1`, so pdflatex compiles into build/ and latexmk moves the PDF and SyncTeX file to the root.
- pdflatex cannot create `build/chapters/` for `\include`'d `.aux` files, so a `File::Find` block mirrors every source folder that contains `.tex` files into build/.
- `.vscode/settings.json` (`latex-workshop.latex.outDir` / `auxDir`) must stay in sync with `.latexmkrc`.
- Overleaf runs `latexmk -cd -jobname=output -auxdir=$COMPILE_DIR -outdir=$COMPILE_DIR ...`. Those command-line flags override the rc file, so `.latexmkrc` is harmless there. This was verified by simulating that command locally.
- CI (`.github/workflows/build.yml`) has two parallel jobs: `lint` runs chktex through `xu-cheng/texlive-action` (chktex exits 2 on any warning), and `build` runs `xu-cheng/latex-action`. A tag push releases the PDF. The workflow has never actually run, because the repo has no remote yet.

## Conventions

- Put the label right after the counter on the same line: `\section{...}\label{sec:...}`, `\caption{...}\label{tab:...}`.
- Label prefixes: `sec: fig: tab: eq: lst: app:`.
- Use `\cref` for numbered references. For course-defined names like "Stage 3", use `\hyperref[sec:...]{Stage~3}` so the wording is kept.
- Write `~\cite{}`, and `vs.\ ` / `e.g.\ ` after abbreviations.
- Use `\term{}` for key terms, never a raw `\textbf{\textit{}}`.
- Content tables use booktabs (`@{}...@{}`, `\toprule/\midrule/\addlinespace/\bottomrule`, no vertical rules). The member and assessment tables keep grid lines on purpose, because they are forms.
- Column types `L`, `C`, `P{w}` are ragged-right wrappers for tabularx/array.
- Images live in `images/` (`\graphicspath`), optionally in per-chapter subfolders. Template-owned images live in `config/assets/`.
- Bibliography: IEEEtran, numbered by order of first citation. Corporate authors need double braces, `{{...}}`. Protect commands in titles from lowercasing, for example `{\S}`.

## Known pitfalls

- **Fonts.** Vietnamese needs `fontenc[T5]` with `inputenc[utf8]` (babel-vietnamese checks for it), `hyperref[vietnamese]` (PU encoding for bookmarks), and microtype protrusion limited to the rm/sf families (T5 lmtt has no protrusion data).
- **The cover.** It disables `pageanchor` to avoid a duplicate `page.1` destination.
- **Concurrent builds.** The user's VS Code has LaTeX Workshop open with auto-save and build-on-save. When Claude edits files while also running `latexmk`, two builds can race in `build/`. That gives spurious failures, such as BibTeX reporting "no \citation commands", and leaves stray `build/pdflatex*.fls` files. If a failure looks impossible, rerun before debugging.
- **Bash escaping.** In the Git Bash tool, backslashes inside heredocs and `sed`/`perl` one-liners get mangled, and `sed` fails on UTF-8 patterns. For scripted edits of `.tex` files, write a Python script to a file and run it.
- **PDF text checks.** On Windows, `pdftotext` defaults to Latin-1 output and drops Vietnamese diacritics. Use `pdftotext -enc UTF-8`, and set `PYTHONIOENCODING=utf-8` when printing from Python.
- **Open content issue.** The role pairs described in chapter 5 do not match the Contribution column in `config/metadata.tex`. A `\todo` marks the spot. Leave it for the team to resolve rather than inventing roles.
- **Commits.** Commit only when the user asks.
