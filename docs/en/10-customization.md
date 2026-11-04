# Customization

[Tiếng Việt](../vi/10-tuy-bien.md) | **English**

This page is for those who want to change how the template looks. All formatting lives in `config/report.sty`, split into numbered sections:

| Section | Contents |
| :---: | --- |
| 0 | Options (`vietnamese`, `draft`…) |
| 1 | Fonts and languages |
| 2 | Page margins |
| 3 | Graphics and colours |
| 4 | Tables and captions |
| 5 | Lists, numbering, appendices |
| 6 | Code, highlight boxes, `\term`, draft notes |
| 7 | Links, cross-references, abbreviations |
| 8 | Data commands and the template's fixed text |
| 9 | Header and footer |
| 10 | Cover page and member tables |
| 11 | Lists after the table of contents |

> [!WARNING]
> Make a backup copy of `report.sty` before editing it. Afterwards, rebuild and check that the *Problems* tab shows no new errors.

## Logo and cover background

No need to edit `report.sty`. Replace the files in `config/assets/`, or point to other files in `config/metadata.tex`:

```latex
\logo{config/assets/faculty-logo}     % logo on the cover and in the header
\coverbackground{}                     % no background image
```

The logo should be a PNG with a transparent background, or a PDF. The background is scaled to fit A4 and keeps its aspect ratio.

## Theme colours

The template has two colours, defined in section 3 of `report.sty`:

```latex
\definecolor{primary}{HTML}{032B91}     % dark blue: report title, links, highlight boxes
\definecolor{secondary}{HTML}{1488DB}   % light blue: cover rules, \note notes
```

By default, both colours are taken from the HCMUT logo. Change a colour code and everything using that colour follows.

In your text, use the **colour name** rather than a colour code, for example `\textcolor{primary}{...}`, or `primary!10` for a 10% tint. Then those places follow when the theme colour changes.

## Font size

Edit the first line of `main.tex`:

```latex
\documentclass[a4paper,12pt]{article}    % 10pt (default), 11pt or 12pt
```

## Line spacing

Add to `main.tex`, right after the `\usepackage{...}{config/report}` line:

```latex
\linespread{1.3}         % like 1.5 line spacing in Word; 1.6 is like double spacing
```

LaTeX's factor differs from Word's: `\linespread{1.3}` is what gives the same spacing as Word's "1.5 lines".

## Page margins

Section 2 of `report.sty`:

```latex
left=2.5cm, right=2.5cm,
top=3.5cm, bottom=2.5cm,
% bindingoffset=1cm,       % remove the % to leave extra room for binding
```

The top margin is larger than the bottom one because the header holds the logo.

## Header and footer

Section 9 of `report.sty`. By default:

| | Left | Right |
| --- | --- | --- |
| **Header** | Logo + `\headertext` | Number and name of the current chapter |
| **Footer** | Course name, semester | Page x/total pages |

To change only the header text, edit `\headertext{...}` in `metadata.tex`. To change what a slot shows, edit `\fancyhead[L]`, `\fancyhead[R]`, `\fancyfoot[L]` or `\fancyfoot[R]` in section 9. For example, to add the group to the left footer:

```latex
\fancyfoot[L]{\scriptsize\ttfamily
  \rpt@course, \rpt@txt@semester\ \rpt@semester\ -- Group 5}
```

## The template's fixed text

Words such as "Instructor", "Student ID" and "Semester" live in section 8 of `report.sty`. Each has two versions, Vietnamese (the `\ifrpt@vietnamese` block) and English (the `\else` block):

```latex
\newcommand*{\rpt@txt@instructor}{Giảng viên hướng dẫn}   % Vietnamese version
...
\newcommand*{\rpt@txt@instructor}{Instructor}             % English version
```

To change one, for example to "Supervisor", edit **both** blocks if the group may use either language.

The headings of the front pages (`\memberlistname`, `\assessmentname`, `\declarationname`, `\abbreviationsname`) can be changed for a single report without touching the template. Add to the end of `config/metadata.tex`:

```latex
\renewcommand*{\memberlistname}{Division of Work}
```

## Cover page

Section 10 of `report.sty`, the `\makecover` command. Each line on the cover matches a line in this command, from top to bottom. The `\vspace{...}` gaps decide the layout; increase or decrease them to rearrange the cover.

## Adding packages

A package needed by one report only goes into `main.tex`, right after the `\usepackage{...}{config/report}` line. A package every report built from the template should have goes into `report.sty`, in the right section and **before** section 7 (`hyperref` must be loaded near the end).

Already loaded by the template: `amsmath`, `amssymb`, `graphicx`, `xcolor`, `tikz`, `float`, `subcaption`, `tabularx`, `booktabs`, `multirow`, `enumitem`, `listings`, `tcolorbox`, `hyperref`, `cleveref`, `acro`. There is no need to load them again.

---

[← Previous: Tools: build, linting, CI](09-tools.md) | [Contents](README.md) | [Next: Troubleshooting →](11-troubleshooting.md)
