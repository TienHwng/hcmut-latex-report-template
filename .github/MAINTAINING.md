# Maintaining the template

Notes for the maintainer of the template and for AI assistants working on the template itself, not on a report. People writing a report need [AGENTS.md](../AGENTS.md) and the docs instead.

## AI instruction files

| File | In Git | Read by | Contents |
| --- | --- | --- | --- |
| `AGENTS.md` | yes | every AI tool that reads it, and Claude Code via `CLAUDE.md` | How to use the template: which file to edit, commands, conventions, pitfalls |
| `CLAUDE.md` | yes | Claude Code | Only `@AGENTS.md` |
| `.github/MAINTAINING.md` | yes | the maintainer, and Claude Code via `CLAUDE.local.md` | This file |
| `CLAUDE.local.md` | no (gitignored) | Claude Code, on the maintainer's machine only | One line: `@.github/MAINTAINING.md` |

Users who clone the template therefore get only `AGENTS.md`. If `CLAUDE.local.md` is lost (new clone, new machine), recreate it with that single line.

Keep `AGENTS.md` in step with the template: when a macro, option, file or pitfall changes, update it together with README, `docs/vi` and `docs/en`. It addresses an AI helping a student, so keep maintainer details out of it.

## Branches and repository

- The repo is `TienHwng/hcmut-latex-report-template` on GitHub (`origin`). The CI badge and the `git clone` URLs in `docs/*/00-*` use that address; update all of them if the name changes.
- On `main`, the chapters are short placeholders that demonstrate each template feature: TikZ figure, equation, listing, booktabs table, `\cite`, `\cref`, `\ac` and `\todo`.
- Branch `report/ai-digital-content` holds a complete sample report ("A.I. in Digital Content") built with the template. It does not receive template changes automatically: merge `main` into it after each template change. The "Sample content" section of `AGENTS.md` deliberately differs on that branch (it describes the finished report instead of placeholders); keep the branch's version when merging.
- Commit only when asked. Do not add `Co-Authored-By` or other AI attribution to commits.

## Documentation

The maintainer writes to Claude in Vietnamese. The user-facing documentation is in Vietnamese first:

- README.md is short, in the style of large open-source repos: a centred logo, title and four badges (license, CI, two static), then features, a quick start, a `tree`-style folder map (important parts only), a list of the docs, the sample branch and a license section.
- `docs/vi/00-bat-dau.md` to `docs/vi/12-tra-cuu-nhanh.md` hold the guides, indexed by `docs/vi/README.md`. Page 00 has installation, the new-report steps and the pre-submission checklist; page 12 is the cheat sheet.
- `docs/en/` is a full English translation with English file names and anchors (`00-getting-started.md` …). `docs/en/README.md` mirrors the main README in English. `docs/README.md` is just a language chooser.
- Every LaTeX snippet in both versions was compiled against the template, so re-test any snippet you change.

Keep README, `docs/vi`, `docs/en` and `AGENTS.md` in sync when the template's behaviour changes. Keep them markdownlint-clean with `.markdownlint.jsonc` (MD013 off; HTML only for the README header), including valid `#anchor` links (GitHub slugs keep Vietnamese letters).

The docs follow a deliberately sober style; an icon-heavy version was rejected:

- No emoji anywhere, and no `<kbd>`: write keys as `Ctrl+S`.
- The language bar under each H1 is plain text: `**Tiếng Việt** | [English](...)`.
- Every numbered page ends with `---` and a "previous | contents | next" footer.
- GitHub alerts only for real pitfalls, at most 1–2 per page, mostly `> [!WARNING]`; everything else is a plain paragraph. Two alerts in a row need a `<!-- -->` line between them, or MD028 fires.
- VS Code's built-in preview cannot render alerts; Markdown Preview Enhanced (recommended in `.vscode/extensions.json`, `Ctrl+K V`) can.
- The README badges are: the GitHub Actions badge for `build.yml` on `main`, then two static shields (compiler, report language).
- Both READMEs show the two English PDF screenshots side by side (`docs/assets/preview-{cover,content}-en.png`, width 49%), with a caption line linking the Vietnamese ones (`-vi.png`), and a Mermaid `flowchart LR` of the inputs feeding `main.tex`. Mermaid ignores `direction` inside a subgraph that is linked as a whole, so the diagram uses plain nodes.
- To validate a diagram, run `npx -p @mermaid-js/mermaid-cli mmdc -i x.mmd -o x.png` in a scratch folder.

### Screenshots

Regenerate the screenshots whenever the cover or page layout changes:

1. Build final-mode copies of main.tex, without `draft`: `zz-test-en.tex` with no option and `zz-test-vi.tex` with `[vietnamese]`. The vi copy must also be Vietnamese in content, or the page comes out half English: point it at temporary translations of `config/metadata.tex` and `chapters/02-method.tex` in a `zz-vi/` folder. Keep the code inside the listing in English, because listings cannot take diacritics.
2. Run `pdftoppm -png -r 110 -f N -l N -singlefile` on page 1 and on the "2 Method" page (currently page 6).
3. Delete the `zz-test-*` copies, `zz-vi/` and their files in `build/`.

## Commands

The user-level commands are in `AGENTS.md`. In addition:

```sh
npx markdownlint-cli2 "*.md" "docs/**/*.md" ".github/*.md"   # lint the docs; expect 0 issues
```

To compile only one chapter while drafting, uncomment `\includeonly{...}` in main.tex.

To test a template option without editing main.tex, write a temporary copy whose `\usepackage{config/report}` line carries the options, for example `[vietnamese,draft]`. Build it with `latexmk zz-test.tex`, then delete the copy along with `zz-test.*` and `build/zz-test.*`.

`CONTRIBUTING.md` (Vietnamese, with English welcome) lists the checks to run before a pull request; keep it in step with these commands.

## Architecture

Content, data and formatting are deliberately kept apart:

- **`config/report.sty`** is the whole template, as a single package with no report text. It has numbered sections (0 options … 11 lists). Internal macros use the `\rpt@` prefix.
- **`config/metadata.tex`** holds the data only: setters such as `\course{}` and `\instructor{}` (each one just does `\def\rpt@course{...}`) and `\addmember{name}{id}{contribution}{workload}`.
- **`chapters/`, `appendices/`, `frontmatter/`** hold the prose. Chapters and appendices are pulled in with `\include`; frontmatter uses `\input`.

### Template options

Each option sets a `\newif` switch: `\ifrpt@vietnamese`, `\ifrpt@draft`, `\ifrpt@print` and `\ifrpt@lists`. `\ifreportvietnamese` is a public alias of the language switch, for language-dependent text in content files (see `frontmatter/declaration.tex`). `print` applies `hidelinks`. `lists` makes `\printfrontlists` add a list of figures and a list of tables; `\printfrontlists` always adds the abbreviations page when any `\abbreviation` is declared.

The language switch controls three separate sources of words:

1. babel's main language, which is the last one in the option list. Both languages are always loaded.
2. Template-owned strings `\rpt@txt@...`, plus the public `\memberlistname` and `\assessmentname`.
3. cleveref names. These are defined capitalised for both `\crefname` and `\Crefname`, because the `[capitalise]` option would otherwise print lowercase Vietnamese. The conjunctions (`\crefpairconjunction` etc.) are also redefined, to "và" / "đến".

The switch does not translate the chapter prose.

`draft` loads todonotes and adds a DRAFT watermark through eso-pic. `final` loads `todonotes[disable]`, so `\todo` / `\note` / `\listoftodos` silently vanish. Any new user-visible fixed word in the sty should get both language variants.

### Single-source member list

`\addmember` appends `\rpt@member{..}{..}{..}{..}` to `\rpt@members` and builds `\rpt@authors`, which feeds `pdfauthor`. Each table (`\printstudenttable`, `\printcontributiontable`, `\printassessmenttable`) locally redefines `\rpt@member` to render one row, then expands `\rpt@members`. The same pattern drives `\printsignaturetable`, which the declaration page uses.

### Other data interfaces

- **Optional cover fields.** `\reporttype`, `\classcode` and `\group` are hidden when left empty.
- **Default date.** `\date` defaults to the build month in the report language. A `\date{}` in metadata.tex overrides it.
- **Abbreviations.** `\abbreviation{key}{SHORT}{Long}` wraps acro's `\DeclareAcronym` and sets `\ifrpt@abbreviations`. Use `\ac` in running text (`\Ac` at the start of a sentence), `\acs` in bold item labels, and plain text in headings and captions.
- **Theme colours.** `primary` (#032B91) and `secondary` (#1488DB) were sampled from the logo.

### Build layout

- `.latexmkrc` sets `$out_dir='.'`, `$aux_dir='build'` and `$emulate_aux=1`, so pdflatex compiles into build/ and latexmk moves the PDF and SyncTeX file to the root.
- pdflatex cannot create `build/chapters/` for `\include`'d `.aux` files, so a `File::Find` block mirrors every source folder that contains `.tex` files into build/.
- `.vscode/settings.json` (`latex-workshop.latex.outDir` / `auxDir`) must stay in sync with `.latexmkrc`.
- Overleaf runs `latexmk -cd -jobname=output -auxdir=$COMPILE_DIR -outdir=$COMPILE_DIR ...`. Those command-line flags override the rc file, so `.latexmkrc` is harmless there. This was verified by simulating that command locally.
- CI (`.github/workflows/build.yml`) has three parallel jobs: `lint` runs chktex through `xu-cheng/texlive-action` (chktex exits 2 on any warning); `docs` runs `DavidAnson/markdownlint-cli2-action` on `*.md`, `docs/**/*.md` and `.github/*.md`; `build` runs `xu-cheng/latex-action`. A tag push releases the PDF. The workflow first ran successfully on 2026-11-04.

## Conventions for template code

- For course-defined names like "Stage 3", use `\hyperref[sec:...]{Stage~3}` so the wording is kept.
- The member and assessment tables keep grid lines on purpose, because they are forms; content tables use booktabs.
- Images live in `images/` (`\graphicspath`). Template-owned images live in `config/assets/`.
- Bibliography: IEEEtran, numbered by order of first citation. Protect commands in titles from lowercasing, for example `{\S}`.

## Known pitfalls

- **Fonts.** Vietnamese needs `fontenc[T5]` with `inputenc[utf8]` (babel-vietnamese checks for it), `hyperref[vietnamese]` (PU encoding for bookmarks), and microtype protrusion limited to the rm/sf families (T5 lmtt has no protrusion data).
- **The cover.** It disables `pageanchor` to avoid a duplicate `page.1` destination.
- **Concurrent builds.** The maintainer's VS Code has LaTeX Workshop open with auto-save and build-on-save. Running `latexmk` while editing files can race with it in `build/`, giving spurious failures and stray `build/pdflatex*.fls` files. If a failure looks impossible, rerun before debugging.
- **Bash escaping.** In Git Bash, backslashes inside heredocs and `sed`/`perl` one-liners get mangled, and `sed` fails on UTF-8 patterns. For scripted edits of `.tex` files, write a Python script to a file and run it.
- **PDF text checks.** On Windows, `pdftotext` defaults to Latin-1 output and drops Vietnamese diacritics. Use `pdftotext -enc UTF-8`, and set `PYTHONIOENCODING=utf-8` when printing from Python.
- **Open content issue (sample branch only).** On `report/ai-digital-content`, the role pairs described in chapter 5 do not match the Contribution column in `config/metadata.tex`. A `\todo` marks the spot. Leave it for the team to resolve rather than inventing roles.

## License

The license is MIT, Copyright (c) 2026 Tien Hung Nguyen. It was GPL-3.0-or-later briefly before the first push.

- `LICENSE` holds the standard MIT text. Keep it unchanged so GitHub detects it.
- `NOTICE.md` says that documents made with the template need not carry the MIT notice, and excludes the HCMUT logo and the cover background from the license.
- `config/report.sty` carries a short copyright and SPDX header.
