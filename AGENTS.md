# AGENTS.md

Instructions for AI assistants (Claude, Copilot, Cursor, Codex, ChatGPT…) helping someone write a report with this template. If you are reading this, the person you are helping is most likely a student writing a report, not the author of the template.

## What this is

A pdfLaTeX + BibTeX template for group reports at Ho Chi Minh City University of Technology (HCMUT, Vietnam). The report can be in English or Vietnamese. Users often talk to you in Vietnamese; answer in the language they use.

Your job is usually to fill in the report: details, chapters, figures, tables, references. It is rarely to change the template itself.

## Which file to edit

| To change | Edit | Notes |
| --- | --- | --- |
| Course, title, instructor, semester, date, members | `config/metadata.tex` | Data only. Start here. |
| Abbreviations | `config/abbreviations.tex` | One `\abbreviation` per line. |
| Chapter text | `chapters/*.tex` | One file per chapter. |
| Appendices | `appendices/*.tex` | One file per appendix. |
| References | `bib/references.bib` | BibTeX, IEEEtran style. |
| Images | `images/` | Optional subfolders per chapter. |
| Language, draft mode, chapter list and order | `main.tex` | The `\usepackage[...]{config/report}` line and the `\include` list. |
| Member page, declaration | `frontmatter/*.tex` | Rarely needs changes. |
| Layout, fonts, colours, cover | `config/report.sty` | **Only when the user explicitly asks to change the look.** See `docs/en/10-customization.md`. |

Do not edit `config/report.sty` to put report text in it, and do not copy its packages into chapter files: everything is already loaded. Do not add `\usepackage` lines to chapters. If a package is truly missing, add it to `main.tex` after `\usepackage{config/report}`.

## Sample content

This copy is the `report/ai-digital-content` branch: a complete sample report ("A.I. in Digital Content") written by a real team, not placeholders. If the user is only reading it as an example, do not change it. If they start their own report from it, everything is theirs to replace:

- the five chapters in `chapters/` and the appendix;
- the members in `config/metadata.tex`;
- the abbreviations;
- the entries in `bib/references.bib`.

The `\todo` in chapter 5 marks a real open question of that team (roles vs. the Contribution column). Do not resolve it by guessing.

Replace what the user asks for. For placeholders they did not mention (for example chapters 2 and 3 when they only asked for chapter 1), tell them those parts are still sample text and ask before rewriting them.

When you delete or rewrite text, search all `.tex` files for `\cref{...}` and `\ref{...}` to labels that disappeared. Other chapters often point to labels in the text you removed.

## Template options

In `main.tex`: `\usepackage[<options>]{config/report}`, any combination of:

- `english` (default) or `vietnamese`: language of the text the template generates (cover, headings such as "Contents", captions "Figure/Hình", `\cref` names). It does **not** translate what the user writes.
- `final` (default) or `draft`: `draft` prints `\todo` / `\note` margin notes and a DRAFT watermark. In `final` those notes vanish without being deleted.
- `print`: black links without frames, for paper.
- `lists`: adds a list of figures and a list of tables.

For text that depends on the language, use `\ifreportvietnamese Văn bản \else Text \fi`.

## Template commands

Report details, in `config/metadata.tex`:

```latex
\course{Course Name}  \semester{251}  \instructor{Dr.\ Nguyễn Văn A}
\title{Report Title}  \city{Ho Chi Minh City}
% \date{April 2026}               % default: month of the build
% \reporttype{ASSIGNMENT REPORT}  \classcode{L01}  \group{5}   % optional, hidden when empty
\addmember{Full name}{Student ID}{Contribution}{100\%}   % one line per member, in table order
```

Members are declared once with `\addmember`. The cover, the member table, the assessment table, the declaration signatures and the PDF author field are all generated from that list. Never write those tables by hand.

In the text:

| Purpose | Command |
| --- | --- |
| Key term | `\term{...}` (not `\textbf{\textit{...}}`) |
| Abbreviation | Declare `\abbreviation{key}{SHORT}{Long form}` in `config/abbreviations.tex`, then write `\ac{key}` alone. The first `\ac` prints "Long form (SHORT)" by itself, so never write `Long form (\ac{key})`. Write the long form in the report's language: `{Trí tuệ nhân tạo}` in a Vietnamese report |
| Highlight box | `\begin{keybox}{Title} ... \end{keybox}` |
| Note for the team | `\todo{...}`, `\todo[inline]{...}`, `\note[Name]{...}` (visible only in `draft`) |
| Cross-reference | `\cref{fig:x}` gives "Figure 2.1" / "Hình 2.1"; `\Cref` at the start of a sentence |
| Citation | `text~\cite{key}` |
| Code | `\begin{lstlisting}[language=Python, caption={...}, label={lst:x}]` |
| Ragged table columns | `L`, `C` (tabularx `X` variants), `P{3cm}` |
| Colours | `primary`, `secondary` (from the logo), e.g. `\color{primary}` |

## Conventions

- Put the label right after the command that creates the number, on the same line: `\section{Method}\label{sec:method}`, `\caption{...}\label{fig:pipeline}`.
- Label prefixes: `sec:` `fig:` `tab:` `eq:` `lst:` `app:`.
- Always use `\cref` for numbered references, never "Figure~\ref{...}" typed by hand.
- Tables in the text use booktabs: `\toprule`, `\midrule`, `\bottomrule`, column spec `@{}...@{}`, no vertical rules.
- Figures and tables are floats with `\centering`, `\caption` and `\label`.
- Write `~\cite{}` (non-breaking space), and a control space after abbreviations with a period: `e.g.\ ChatGPT`, `vs.\ X`.
- Each chapter file starts with `\section{...}`. The template's "chapters" are `\section`s of an `article`, so do not use `\chapter`.
- To add a chapter: create a file in `chapters/` and add `\include{chapters/<file>}` to `main.tex`. The order of the `\include` lines sets the section numbers; the file names do not. To insert a chapter in the middle, just put its `\include` in the right place. Renaming the other files is optional, and if you do it, update `main.tex` too.
- To add an image: put it in `images/` and use `\includegraphics[width=0.8\textwidth]{name}` without the folder or extension.

## Pitfalls that break the build

- **`%` in text must be `\%`**, including the workload column of `\addmember` (`100\%`). Same for `& _ #`: `\& \_ \#`.
- **Vietnamese author names in `bib/references.bib`** must be wrapped in double braces: `author = {{Nguyễn Đức Anh}}`. IEEEtran abbreviates first names byte by byte, and `Nguyễn, Đức Anh` produces an "Invalid UTF-8" error. Organisations also need double braces: `{{World Health Organization}}`.
- **No Vietnamese diacritics inside `lstlisting` code.** `listings` cannot handle them. Write code comments and strings without accents, or in English. The caption may be in Vietnamese. If the user asked for Vietnamese inside the code, tell them about this limit instead of silently dropping the accents.
- **Do not use `\ac` in headings or captions.** Their copies in the table of contents or the list of figures would use up the first, expanded use. Write the abbreviation as plain text there.
- **Do not resolve a `\todo` by inventing facts.** A `\todo` marks something the team must decide or check, such as roles, numbers or sources. Ask the user instead.
- **Do not invent references.** Every `.bib` entry must be a real source the user supplied or confirmed. Remove sample entries that are not cited.

## Building and checking

```sh
latexmk                            # build: main.pdf in the root, auxiliary files in build/
latexmk -pvc                       # rebuild on every save
latexmk -C                         # clean everything
chktex -q -l .chktexrc main.tex    # lint; no output means no problems
texcount -inc -brief -q main.tex   # word count per chapter
```

A good build has no warnings: `grep -c Warning build/main.log` prints `0`, and `build/main.blg` contains no `Warning--` or `error message` lines. `??` in the PDF means a broken `\cref`, and `[?]` means a broken `\cite`.

If `latexmk` keeps failing, or says "Nothing to do", after you have fixed the error, the auxiliary files are stale. Run `latexmk -C` and then `latexmk`.

Edit `.tex` files with your file-editing tool, not with shell heredocs, `echo`, `sed` or Python string literals. Shells and string escapes silently eat backslashes (`\\` becomes `\`, `\a` becomes a bell character), and the result is confusing LaTeX errors.

The template only works with **pdfLaTeX**. XeLaTeX and LuaLaTeX do not work with its Vietnamese font setup (T5 encoding), so do not suggest `fontspec` or switching engines. On Overleaf, set **Compiler** to pdfLaTeX and **Main document** to `main.tex`.

If the user has VS Code with LaTeX Workshop open, it rebuilds on save. A build you start at the same time can race with it and fail strangely (for example BibTeX reporting "no \citation commands"). Rerun before you start debugging.

## More detail

- `docs/en/12-cheat-sheet.md`: the common commands on one page.
- `docs/en/` (English) and `docs/vi/` (Vietnamese): full guides, with every example compiled against this template. `docs/en/11-troubleshooting.md` explains common error messages.
- `chapters/` on the `main` branch: short examples of every feature.
- The `report/ai-digital-content` branch: a complete sample report.
