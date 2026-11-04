# Math and code

[Tiếng Việt](../vi/05-cong-thuc-va-code.md) | **English**

## Equations

### Inline and displayed

```latex
Energy is given by $E = mc^2$, where $m$ is the mass.

\begin{equation}
  S = \sum_{i=1}^{n} w_i s_i \label{eq:score}
\end{equation}
```

- `$...$` is math inside a sentence.
- `equation` is a displayed equation on its own line, numbered per chapter, for example (2.1). Refer to it with `\cref{eq:score}`, which prints "Equation (2.1)" or "Công thức (2.1)".
- For an unnumbered equation, use `\[ ... \]` or `equation*`.

**`$...$` or `\(...\)`?** Both give exactly the same output. `$...$` is shorter and far more common, so the template uses it. `\(...\)` is LaTeX's "official" syntax and gives a clearer error when you forget to close it, but few people use it. Pick one and use it consistently. ChkTeX is configured not to ask you to switch to `\(...\)`.

### Several aligned lines

```latex
\begin{align}
  a &= b + c \label{eq:first}\\
  d &= e - f \label{eq:second}
\end{align}
```

`&` marks where the lines align (usually just before `=`). Each line gets its own number; add `\nonumber` before `\\` on a line that should not have one. To refer to several equations at once: `\cref{eq:first,eq:second}` prints "Equations (2.1) and (2.2)".

### Common symbols

| Write | Result | Write | Result |
| --- | --- | --- | --- |
| `x^2`, `x_i` | superscript, subscript | `\frac{a}{b}` | fraction |
| `\sqrt{x}` | square root | `\sum_{i=1}^{n}` | sum |
| `\le`, `\ge`, `\ne` | ≤, ≥, ≠ | `\approx`, `\times` | ≈, × |
| `\alpha`, `\beta`, `\lambda` | α, β, λ | `\in`, `\mathbb{R}` | ∈, ℝ |
| `\text{score}` | upright text inside math | `\left( \frac{a}{b} \right)` | brackets that grow with the content |

Can't remember a command? Draw the symbol in [Detexify](https://detexify.kirelabs.org) and it tells you the name.

## Code

### A short listing

```latex
\begin{lstlisting}[language=Python, caption={Computing the weighted score}, label={lst:score}]
def score(weights, scores):
    return sum(w * s for w, s in zip(weights, scores))
\end{lstlisting}
```

- Listings come with line numbers, a frame, colours for keywords, strings and comments, and wrap long lines.
- The `caption` goes below the code: "Listing 1" or "Đoạn mã 1". Refer to it with `\cref{lst:score}`.
- Supported languages include `Python`, `C`, `C++`, `Java`, `SQL`, `HTML`, `bash`, `Matlab`, `R`… Leave out `language=...` for plain text, such as program output.
- Code inside `lstlisting` is printed verbatim, so no `\_` or `\%` is needed.

> [!WARNING]
> **No accented letters** in code, comments included: `listings` cannot handle Vietnamese diacritics and the build fails.

### Including a whole code file

Instead of copying code into the report, include the file directly. When the file changes, the report follows:

```latex
\lstinputlisting[language=Python, caption={Main program}, label={lst:main}]{code/main.py}
```

The path is relative to the template's root folder, so you can create a `code/` folder for your files. To show only part of a file, add `firstline=10, lastline=25` inside the square brackets.

### Inline code

For a function, variable or file name inside a sentence, use `\texttt{...}`, for example `\texttt{main.py}`. Special characters inside still need escaping: `\texttt{read\_file}`.

---

[← Previous: Figures and tables](04-figures-and-tables.md) | [Contents](README.md) | [Next: Cross-references and citations →](06-cross-references-and-citations.md)
