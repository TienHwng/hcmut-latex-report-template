# Cross-references and citations

[Tiếng Việt](../vi/06-tham-chieu-va-trich-dan.md) | **English**

## Cross-references

### Labels

Anything numbered can get a label with `\label{...}`. Put the `\label` **right after** the command that creates the number, on the same line:

```latex
\section{Method}\label{sec:method}
\caption{System architecture}\label{fig:architecture}
\caption{Experimental results}\label{tab:results}
\begin{equation} S = \sum w_i s_i \label{eq:score} \end{equation}
\begin{lstlisting}[caption={...}, label={lst:score}]
```

> [!WARNING]
> A `\label` placed **before** `\caption` picks up the chapter's number instead of the figure's.

Labels carry a prefix that says what they point to. Typing `\cref{fig:` then lists only the figures:

| Prefix | For | Example |
| --- | --- | --- |
| `sec:` | Chapters, sections | `sec:method`, `sec:data-collection` |
| `fig:` | Figures | `fig:architecture` |
| `tab:` | Tables | `tab:results` |
| `eq:` | Equations | `eq:score` |
| `lst:` | Code listings | `lst:score` |
| `app:` | Appendices | `app:survey` |

Use only lowercase letters without accents, digits and `-` in labels. Each label may be used only once in the whole report; when several people write, add the chapter name (`fig:method-pipeline`) to avoid clashes.

### Referring

```latex
As shown in \cref{fig:architecture}, ...
\Cref{sec:method} describes ...
The results in \cref{tab:results,tab:cost} show ...
The questionnaire is given in \cref{app:survey}.
```

| Write | English report | Vietnamese report |
| --- | --- | --- |
| `\cref{fig:architecture}` | Figure 2.1 | Hình 2.1 |
| `\cref{sec:method}` | Section 2 | Mục 2 |
| `\cref{eq:score}` | Equation (2.1) | Công thức (2.1) |
| `\cref{tab:results,tab:cost}` | Tables 3.1 and 3.2 | Bảng 3.1 và 3.2 |
| `\cref{app:survey}` | Appendix A | Phụ lục A |
| `\pageref{fig:architecture}` | 5 (page number) | 5 |

- `\cref` adds the word "Figure"/"Hình" itself, so **don't** write `Figure \cref{...}`.
- `\Cref` is for the start of a sentence. The template capitalises both, so in practice they print the same.
- The printed text is a link: clicking it jumps to the figure, table or section.

**Never type** "Table 3.1" by hand: add or remove one table and the number is wrong, whereas `\cref` updates itself.

### Keeping the assignment's own wording

When the assignment gives a part its own name, such as "Stage 3", and you want to keep that wording but still have a link, use `\hyperref`:

```latex
The output of \hyperref[sec:stage3]{Stage~3} is used in ...
```

### When you see `??`

LaTeX needs two passes: the first records each label's number, the second prints it. `latexmk` and LaTeX Workshop run enough passes by themselves. If `??` remains after a build, the label name is misspelled or the `\label` does not exist. Open the *Problems* tab in VS Code to find the line with a `Reference ... undefined` warning.

## Citations

### Adding sources to `bib/references.bib`

Each source is a BibTeX entry.

The quickest way: find the paper on [Google Scholar](https://scholar.google.com), click **Cite → BibTeX** and copy the result into the file. For books and articles with a DOI, paste the DOI into [doi2bib](https://www.doi2bib.org).

```bibtex
@article{chesney2019,
  author  = {Chesney, Robert and Citron, Danielle Keats},
  title   = {Deep Fakes: A Looming Challenge for Privacy, Democracy, and National Security},
  journal = {California Law Review},
  volume  = {107},
  pages   = {1753--1820},
  year    = {2019}
}

@book{collingridge1980,
  author    = {Collingridge, David},
  title     = {The Social Control of Technology},
  publisher = {St. Martin's Press},
  address   = {New York},
  year      = {1980}
}

@inproceedings{rombach2022,
  author    = {Rombach, Robin and Blattmann, Andreas and Lorenz, Dominik and Esser, Patrick and Ommer, Bj{\"o}rn},
  title     = {High-Resolution Image Synthesis with Latent Diffusion Models},
  booktitle = {Proc. IEEE/CVF Conf. Computer Vision and Pattern Recognition (CVPR)},
  pages     = {10684--10695},
  year      = {2022}
}

@misc{acm,
  author       = {{Association for Computing Machinery}},
  title        = {{ACM} Code of Ethics and Professional Conduct},
  year         = {2018},
  howpublished = {\url{https://www.acm.org/code-of-ethics}},
  note         = {Accessed: Apr. 16, 2026}
}
```

| Type | For |
| --- | --- |
| `@article` | Journal articles |
| `@inproceedings` | Conference papers |
| `@book` | Books |
| `@misc` | Web pages, reports by organisations, videos, anything else |
| `@techreport` | Technical reports |
| `@phdthesis`, `@mastersthesis` | Theses |

### Common mistakes in the `.bib` file

- **Organisations as authors** need **double braces**: `{{Association for Computing Machinery}}`. With single braces BibTeX reads a person's name, takes "Machinery" as the surname and prints "A. for Computing Machinery".
- **Several authors** are separated by `and`, not by commas: `Smith, John and {{Trần Thị Bình}}`.
- **Capitals in titles**, such as proper nouns and acronyms, may be lowercased by the IEEE style. Wrap them in braces to keep them: `{ACM}`, `{Python}`, `{Việt Nam}`.
- **Special characters** such as `&` and `%` in titles still have to be written `\&`, `\%`.
- Every entry needs a **unique key** (the first word after `{`).

> [!WARNING]
> **Vietnamese authors** must be written in double braces: `{{Nguyễn Đức Anh}}`. The name is then printed in full, which is the usual way to cite Vietnamese names. Written the Western way, `Nguyễn, Đức Anh`, the IEEE style shortens the given names to initials ("Đ. A. Nguyễn"); when the initial is an accented letter (Đ, Á, Ô, Ư…), BibTeX cuts the character in half and the build fails with `Invalid UTF-8 byte sequence`.

### Citing in the text

```latex
According to the ACM Code of Ethics~\cite{acm}, ...
Several studies have shown this~\cite{chesney2019,rombach2022}.
```

- The `~` keeps the citation number `[1]` on the same line as the word before it.
- To cite several sources at once, separate the keys with commas, as in `\cite{a,b,c}`, which prints `[1]–[3]`.
- In VS Code, typing `\cite{` pops up the sources in `references.bib` to choose from.

### The bibliography

- It follows the **IEEE** style, numbered in **order of first citation**, and appears by itself before the appendices.
- Only sources that are `\cite`d are listed, so unused entries in the `.bib` file do no harm. To list a source that is not cited in the text, add `\nocite{key}` anywhere.
- `[?]` in the PDF means the key in `\cite` matches no key in the `.bib` file. Check the spelling, or look at `build/main.blg` to see which entry has a problem.

---

[← Previous: Math and code](05-math-and-code.md) | [Contents](README.md) | [Next: Abbreviations →](07-abbreviations.md)
