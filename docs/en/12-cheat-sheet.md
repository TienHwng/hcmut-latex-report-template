# Cheat sheet

[Tiếng Việt](../vi/12-tra-cuu-nhanh.md) | **English**

The most common commands, with links to the detailed guides.

| To | Write | Details |
| --- | --- | --- |
| Start a chapter | `\section{Name}\label{sec:name}` | [Writing](03-writing.md#chapters-sections-and-subsections) |
| Introduce a key term | `\term{...}` | [Writing](03-writing.md#text-formatting) |
| Print `% & _ #` | `\% \& \_ \#` | [Writing](03-writing.md#special-characters) |
| Insert an image | `\includegraphics[width=0.8\textwidth]{file-name}` | [Figures](04-figures-and-tables.md#inserting-an-image) |
| Make a table | `tabularx` + `\toprule \midrule \bottomrule` | [Tables](04-figures-and-tables.md#tables) |
| Inline math | `$E = mc^2$` | [Math](05-math-and-code.md#inline-and-displayed) |
| Numbered equation | `\begin{equation} ... \label{eq:name} \end{equation}` | [Math](05-math-and-code.md#equations) |
| Code listing | `\begin{lstlisting}[language=Python, caption={...}]` | [Code](05-math-and-code.md#code) |
| Cross-reference | `\cref{fig:name}` → "Figure 2.1" | [Cross-references](06-cross-references-and-citations.md#cross-references) |
| Cite | `text~\cite{key}` → "text [1]" | [Citations](06-cross-references-and-citations.md#citations) |
| Abbreviation | `\ac{key}` | [Abbreviations](07-abbreviations.md) |
| Highlight box | `\begin{keybox}{Title} ... \end{keybox}` | [Writing](03-writing.md#highlight-box) |
| Note for the team | `\todo{...}`, `\note[Name]{...}` | [Teamwork](08-teamwork.md#notes-for-each-other) |
| Language-dependent text | `\ifreportvietnamese ... \else ... \fi` | [Options](02-options.md#text-that-depends-on-the-language) |

## VS Code shortcuts

| Action | Shortcut |
| --- | --- |
| Build | `Ctrl+S` (save) or `Ctrl+Alt+B` |
| View the PDF | `Ctrl+Alt+V` |
| Jump from code to PDF | `Ctrl+Alt+J` |
| Jump from PDF to code | `Ctrl` + click in the PDF |
| Show problems | `Ctrl+Shift+M` |
| Preview Markdown (README, docs) | `Ctrl+K` then `V` |

---

[← Previous: Troubleshooting](11-troubleshooting.md) | [Contents](README.md)
