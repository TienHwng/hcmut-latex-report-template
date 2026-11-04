# Getting started

[Tiếng Việt](../vi/00-bat-dau.md) | **English**

This page goes from installation to submission. To just try the template on Overleaf, see the [Quick start](README.md#quick-start).

## Installation

| Operating system | TeX distribution | Notes |
| --- | --- | --- |
| Windows | [TeX Live](https://tug.org/texlive/windows.html), `install-tl-windows.exe` | Comes with Perl and `latexmk` |
| macOS | [MacTeX](https://tug.org/mactex/) | |
| Ubuntu/Debian | `sudo apt install texlive-full` | |

Choose the **full** scheme (about 5–9 GB) so no package is missing. Then open a new terminal and check:

```sh
pdflatex --version
latexmk -v
```

Install [VS Code](https://code.visualstudio.com) and open the template **folder** (*File → Open Folder*). VS Code suggests the extensions listed in `.vscode/extensions.json`; the essential one is **LaTeX Workshop**.

If you use **MiKTeX** on Windows, also install [Strawberry Perl](https://strawberryperl.com), otherwise `latexmk` cannot run.

## Starting a new report

### Step 1: Get the template

Copy the whole template folder into a new folder for your report. With Git:

```sh
git clone https://github.com/tienhwng/hcmut-latex-report-template.git my-report
```

### Step 2: Fill in the group's details

Open `config/metadata.tex` and edit:

```latex
\course{Professional Skill for Engineers}   % course name
\semester{252}                               % semester, printed in the footer
\instructor{Dr.\ Nguyen Van A}               % instructor
\title{Report title}

% One line per member: name, student ID, tasks, contribution
\addmember{Nguyen Van An}{2310001}{Chapter 1, editing}{100\%}
\addmember{Tran Thi Binh}{2310002}{Chapter 2}{100\%}
```

> [!WARNING]
> The `%` in the contribution column must be written `\%`. A bare `100%` turns the rest of the line into a comment and the build fails.

See [Report details and cover page](01-report-info.md) for the other fields (class, group, report type, date…).

### Step 3: Choose the language

English is the default. For a Vietnamese report, change this line in `main.tex`:

```latex
\usepackage[vietnamese]{config/report}
```

The option only changes the text the template generates (cover, captions, header…); what you write stays as it is. See [Template options](02-options.md) for the other options.

### Step 4: Write the chapters

Each chapter is a file in `chapters/`. The four sample chapters (`01-introduction` … `04-conclusion`) show figures, tables, equations, code and citations. Read them, then replace them with your own. To add, remove or rename chapters, edit the `\include` list in `main.tex` (see [Writing text](03-writing.md)).

### Step 5: Add references

Add your sources to `bib/references.bib` and delete the sample entries you do not use (see [Citations](06-cross-references-and-citations.md#citations)).

### Step 6: Build and submit

Build, proofread the PDF, and go through the checklist below. The file to submit is `main.pdf` in the root folder.

## Before you submit

- [ ] The `\usepackage` line in `main.tex` **no longer** contains `draft` (no DRAFT watermark, no notes).
- [ ] The `\includeonly` line is commented out (the final version has every chapter).
- [ ] The PDF has no `??` (broken reference) or `[?]` (broken citation).
- [ ] The details in `config/metadata.tex` are correct: course, title, instructor, student IDs, date.
- [ ] Every entry in the bibliography is cited in the text.
- [ ] VS Code's *Problems* tab is empty, or `chktex -q -l .chktexrc main.tex` prints nothing.
- [ ] The report is within the page or word limit (see [Word count](09-tools.md#word-count)).
- [ ] For a printed copy: add the `print` option.

For build errors, see [Troubleshooting](11-troubleshooting.md).

---

[Contents](README.md) | [Next: Report details and cover page →](01-report-info.md)
