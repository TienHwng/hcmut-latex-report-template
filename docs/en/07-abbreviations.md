# Abbreviations

[Tiếng Việt](../vi/07-tu-viet-tat.md) | **English**

The template manages abbreviations for you: the first use prints the full form with the abbreviation, later uses print only the abbreviation. The **list of abbreviations** page is generated too.

## Declaring

Each abbreviation is declared once in `config/abbreviations.tex`:

```latex
% \abbreviation{key}{Short form}{Long form}
\abbreviation{ai}{AI}{Artificial Intelligence}
\abbreviation{genai}{GenAI}{Generative Artificial Intelligence}
\abbreviation{api}{API}{Application Programming Interface}
\abbreviation{hcmut}{HCMUT}{Ho Chi Minh City University of Technology}
\abbreviation{db}{DB}{database}
```

- The **key** is the name you use while writing: lowercase, no accents, no spaces. It is never printed.
- Write the **long form** in the report's language. It can be lowercase (`database`) if the term usually appears mid-sentence.

## Using them

| Command | First use | Later uses | When |
| --- | --- | --- | --- |
| `\ac{api}` | Application Programming Interface (API) | API | Almost everywhere |
| `\Ac{api}` | Like `\ac`, first letter capitalised | API | Start of a sentence (matters when the long form is lowercase) |
| `\acp{api}` | Application Programming Interfaces (APIs) | APIs | Plural, English only |
| `\acs{api}` | API | API | Always the short form, for example in bold list labels |
| `\acl{api}` | Application Programming Interface | Application Programming Interface | Always the long form |

Example:

```latex
\Ac{db} design follows the relational model.          % Database (DB) ...
Each service exposes its own \ac{api}.                 % first use: long form
These \acp{api} communicate over HTTP.                 % later: APIs

\begin{itemize}
  \item \textbf{\acs{api}:} the interface between services.
\end{itemize}
```

## Where not to use `\ac`

> [!WARNING]
> In **chapter and section headings and in captions**, type the abbreviation as plain text, without `\ac`.

```latex
\section{Applications of GenAI}\label{sec:genai}        % right
\section{Applications of \ac{genai}}                     % avoid
```

Headings and captions are printed again in the table of contents and the lists of figures and tables. With `\ac` there, the "first use" lands in the table of contents, and the text only ever shows the abbreviation, never the long form.

## The list of abbreviations

- The **List of Abbreviations** page (Danh mục từ viết tắt) appears after the table of contents as soon as `config/abbreviations.tex` declares at least one abbreviation.
- Only abbreviations **actually used** in the text (through `\ac`, `\acs`…) are listed, so extra declarations do no harm.
- The list is sorted alphabetically.
- If you do not want the page, delete or comment out every `\abbreviation` line and write abbreviations by hand.

## Abbreviations with a period

For common abbreviations that need no declaration, such as *e.g.*, *i.e.*, *vs.* or *Dr.*, remember the `\` before the following space: `e.g.\ ChatGPT`. See [Writing text](03-writing.md#punctuation).

---

[← Previous: Cross-references and citations](06-cross-references-and-citations.md) | [Contents](README.md) | [Next: Teamwork →](08-teamwork.md)
