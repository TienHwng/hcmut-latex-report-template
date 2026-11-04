# Report details and cover page

[Tiếng Việt](../vi/01-thong-tin-bao-cao.md) | **English**

All information about the course, the report and the group lives in **one file**, `config/metadata.tex`. The template uses it to build the cover page, the header, the footer, the member tables and the PDF's properties.

You only edit the details in `config/metadata.tex`. Everything that uses them (cover, footer, tables…) updates by itself.

## The fields

```latex
% --- University ---
\university{VIETNAM NATIONAL UNIVERSITY HO CHI MINH CITY}
\school{HO CHI MINH CITY UNIVERSITY OF TECHNOLOGY}
\headertext{University of Technology, Ho Chi Minh City}
\logo{config/assets/hcmut}
\coverbackground{config/assets/background}

% --- Course and report ---
\course{Professional Skill for Engineers}
\semester{252}
\instructor{Dr.\ Nguyen Van A}
\title{Report title}
\city{Ho Chi Minh City}
% \date{April 2026}

% --- Optional: leave empty and the line on the cover disappears ---
\reporttype{ASSIGNMENT REPORT}
\classcode{L01}
\group{5}
```

| Command | Printed on | Notes |
| --- | --- | --- |
| `\university`, `\school` | First two lines of the cover | |
| `\headertext` | Header, right of the logo | |
| `\logo` | Cover and header | Path to the image, no file extension. `\logo{}` removes the logo |
| `\coverbackground` | Cover background image | `\coverbackground{}` removes it |
| `\course` | Cover (largest text), footer, the PDF's *Subject* | |
| `\semester` | Footer: "Semester 252" / "Học kỳ 252" | |
| `\instructor` | Cover: "Instructor: …" | Write `Dr.\ Nguyen` (with `\` after the period) so LaTeX does not treat the period as the end of a sentence |
| `\title` | Cover (theme colour), the PDF's *Title* | |
| `\city`, `\date` | Last line of the cover: "Ho Chi Minh City, April 2026." | See [Date on the cover](#date-on-the-cover) |
| `\reporttype` | Line right below the course name | Optional |
| `\classcode`, `\group` | "Class: L01 – Group: 5" below the instructor | Optional. You can set just one of them |

Long titles wrap automatically. To break at a specific point, use `\\`, for example `\title{Artificial Intelligence\\in Digital Content}`.

## Date on the cover

Without a `\date{...}` line, the cover prints the **month and year of the build**, in the report's language: "November 2026" or "tháng 11 năm 2026". You never have to remember to update it before submitting.

To fix the date (for example, the day of the presentation), remove the `%` and write it yourself:

```latex
\date{15 December 2026}
```

## Members

Each member is declared with **one line** of `\addmember` holding four fields: full name, student ID, tasks and contribution.

```latex
\addmember{Nguyen Van An}{2310001}{Chapter 1, editing the report}{100\%}
\addmember{Tran Thi Binh}{2310002}{Chapter 2}{100\%}
\addmember{Le Hoang Cuong}{2310003}{Chapters 3 and 4}{90\%}
```

> [!WARNING]
> The `%` sign must be written `\%`. Otherwise the rest of the line becomes a comment and the build fails.

- The order of the lines is the order in every table. To sort by name or by student ID, just reorder the lines.
- To add or remove a member, add or delete a line. Every table follows.

From this list, the template builds:

| Where | Columns | Command |
| --- | --- | --- |
| Cover page | Name, student ID | `\printstudenttable` (already called by `\makecover`) |
| Member page | No., name, tasks, contribution | `\printcontributiontable` |
| Member page | No., name, empty cell for the lecturer's assessment | `\printassessmenttable` |
| Declaration page | No., name, student ID, signature cell | `\printsignaturetable` |
| PDF properties | *Author*: every member's name, comma-separated | Automatic |

## Member page

`frontmatter/members.tex` has two parts: the workload table and the lecturer's assessment table. If your course does not need the assessment table, delete the last three lines of the file:

```latex
\section*{\memberlistname}
\printcontributiontable

\vspace{1cm}                    % <- delete from here
\section*{\assessmentname}
\printassessmenttable           % <- to here
```

`\memberlistname` and `\assessmentname` are headings that follow the language option ("Member List & Workload" / "Danh sách thành viên & phân công"). You can replace them with your own text, for example `\section*{Division of Work}`.

## Declaration

Some courses require a declaration page signed by every member. The page is included but **switched off**. To switch it on, remove the `%` in front of this line in `main.tex`:

```latex
\input{frontmatter/declaration}
```

The page has a declaration paragraph and a signature table. The paragraph comes in English and Vietnamese and follows the language option. To change the wording, edit `frontmatter/declaration.tex` directly:

```latex
\ifreportvietnamese
Chúng em xin cam đoan ...        % Vietnamese version
\else
We hereby declare ...            % English version
\fi
```

## Order of the front pages

The order of the pages before the main content is set in `main.tex`. You can reorder, remove or add pages:

```latex
\makecover                          % cover page
\input{frontmatter/members}         % members + assessment
% \input{frontmatter/declaration}   % declaration
\clearpage
{\hypersetup{linkcolor=black}\tableofcontents}   % table of contents
\listoftodos                        % list of notes, draft only
\printfrontlists                    % lists of figures/tables, abbreviations
```

To add a page such as *Acknowledgements*, create `frontmatter/acknowledgements.tex`:

```latex
\clearpage
\section*{Acknowledgements}
We would like to thank ...
```

then add `\input{frontmatter/acknowledgements}` at the right place in `main.tex`.

Use `\section*` (with the star) so the page does not get a chapter number.

---

[← Previous: Getting started](00-getting-started.md) | [Contents](README.md) | [Next: Template options →](02-options.md)
