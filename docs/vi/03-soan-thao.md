# Soạn thảo văn bản

**Tiếng Việt** | [English](../en/03-writing.md)

## Chương, mục và mục con

Template dùng class `article`, nên **mỗi chương là một `\section`**:

```latex
\section{Phương pháp}\label{sec:method}             % 2      (chương)
\subsection{Thu thập dữ liệu}\label{sec:data}      % 2.1
\subsubsection{Khảo sát}                           % 2.1.1
\paragraph{Câu hỏi mở}                             % 2.1.1.1 (in đậm, không có trong mục lục)
```

- Mục lục hiện tới cấp `\subsubsection`.
- Tiêu đề có dấu sao, ví dụ `\section*{Lời cảm ơn}`, thì không đánh số và không có trong mục lục.
- Header bên phải mỗi trang tự in số và tên chương hiện tại.
- Tiêu đề dài thì viết thêm bản ngắn để dùng cho mục lục và header: `\section[Bản ngắn]{Tiêu đề rất dài ...}`.

### Thêm, bớt, đổi thứ tự chương

Mỗi chương là một file trong `chapters/`, được gọi trong `main.tex` theo thứ tự:

```latex
\include{chapters/01-introduction}
\include{chapters/02-method}
\include{chapters/03-results}
\include{chapters/05-discussion}     % file mới: chapters/05-discussion.tex
\include{chapters/04-conclusion}
```

- Số chương được đánh theo thứ tự `\include`, không theo tên file. Tiền tố `01-`, `02-` chỉ để file hiện đúng thứ tự trong thư mục.
- Mỗi `\include` tự bắt đầu ở trang mới. Muốn hai chương nằm liền nhau trên cùng một trang thì dùng `\input` thay cho `\include`.

> [!WARNING]
> Tên file không dấu, không khoảng trắng. `chương 1.tex` sẽ gây lỗi khó hiểu; hãy đặt `01-gioi-thieu.tex`.

### Phụ lục

Tạo file trong `appendices/`, bắt đầu bằng `\section{...}`, rồi thêm vào khối `appendices` trong `main.tex`:

```latex
\begin{appendices}
\include{appendices/example}
\include{appendices/survey}          % file mới: appendices/survey.tex
\end{appendices}
```

Phụ lục được đánh chữ (Appendix A, B, C… hoặc Phụ lục A, B, C…), và mục con đánh A.1, A.2… Đặt nhãn với tiền tố `app:`, ví dụ `\section{Bảng khảo sát}\label{app:survey}`.

## Đoạn văn

- Xuống đoạn bằng **một dòng trống**. Template tự chừa khoảng cách giữa các đoạn và không thụt đầu dòng.
- Xuống dòng một lần trong file nguồn không tạo dòng mới trong PDF. Bạn có thể viết mỗi câu một dòng để dễ xem thay đổi khi dùng Git.
- Sang trang mới: `\clearpage`.

**Đừng** kết thúc đoạn bằng `\\`: nó gây cảnh báo `Underfull \hbox` và làm lệch khoảng cách giữa các đoạn. Nhiều dòng trống liền nhau cũng không tạo thêm khoảng cách, vì LaTeX coi chúng như một dòng trống.

### Định dạng chữ

| Viết | Kết quả |
| --- | --- |
| `\textbf{chữ}` | **in đậm** |
| `\textit{chữ}` hoặc `\emph{chữ}` | *in nghiêng* |
| `\term{chữ}` | ***đậm nghiêng***, dùng khi giới thiệu một thuật ngữ quan trọng lần đầu |
| `\underline{chữ}` | gạch chân |
| `\texttt{chữ}` | `chữ đơn cách`, dùng cho tên file, tên lệnh |
| `\textcolor{primary}{chữ}` | chữ màu chủ đạo (xem [Tuỳ biến](10-tuy-bien.md#màu-chủ-đạo)) |
| `{\small chữ}`, `{\large chữ}` | chữ nhỏ hoặc to hơn |

Dùng `\term` thay vì gõ `\textbf{\textit{...}}`: muốn đổi kiểu thuật ngữ cho cả bài thì chỉ cần sửa một chỗ trong `report.sty`.

### Dấu câu

- Dấu ngoặc kép: mở bằng hai dấu huyền (phím `` ` `` bên trái số 1), đóng bằng hai dấu nháy đơn. Phím `"` sẽ cho ra dấu sai.

  ```latex
  ``trích dẫn''
  ```

- Gạch nối `-` (*well-known*), gạch ngang ngắn `--` (*2020--2025*), gạch ngang dài `---`.
- Sau chữ viết tắt có dấu chấm (vs., e.g., i.e., Dr.) và còn chữ đứng sau, viết `\` trước khoảng trắng: `e.g.\ ChatGPT`. Nếu không, LaTeX tưởng là hết câu và chừa khoảng trắng rộng.
- Dấu `~` là khoảng trắng không ngắt dòng, giữ hai chữ luôn nằm cùng dòng: `Stage~3`, `Figure~1`.

### Ký tự đặc biệt

Một số ký tự có nghĩa riêng trong LaTeX nên phải viết khác đi:

| Muốn in | Viết | Muốn in | Viết |
| :---: | --- | :---: | --- |
| % | `\%` | # | `\#` |
| & | `\&` | $ | `\$` |
| _ | `\_` | { } | `\{ \}` |
| ~ | `\textasciitilde{}` | \ | `\textbackslash{}` |

Dòng (hoặc phần cuối dòng) bắt đầu bằng `%` là comment, không được in ra.

## Danh sách

```latex
\begin{itemize}                 % gạch đầu dòng
  \item \textbf{Ý chính:} giải thích...
  \item Ý thứ hai
  \begin{itemize}               % danh sách lồng nhau
    \item Ý con
  \end{itemize}
\end{itemize}

\begin{enumerate}               % đánh số 1. 2. 3.
  \item Bước một
  \item Bước hai
\end{enumerate}

\begin{enumerate}[label=(\alph*)]   % đánh (a) (b) (c); dùng \roman* cho i, ii, iii
  \item Phương án một
  \item Phương án hai
\end{enumerate}
```

Muốn danh sách đánh số tiếp từ danh sách trước thì dùng `\begin{enumerate}[resume]`.

## Chú thích chân trang và link

```latex
Theo khảo sát\footnote{Thực hiện trên 120 sinh viên năm 2026.} ...

Xem thêm tại \url{https://www.hcmut.edu.vn}.
Xem \href{https://www.hcmut.edu.vn}{trang chủ của trường}.
```

Đường dẫn dài trong `\url{...}` tự ngắt dòng, và không cần viết `\_` hay `\%` bên trong `\url`.

## Hộp nhấn mạnh

Dùng cho câu hỏi nghiên cứu, kết luận chính hoặc định nghĩa cần nổi bật:

```latex
\begin{keybox}{Vấn đề cốt lõi}
  Làm thế nào để ...?
\end{keybox}
```

Hộp có khung và tiêu đề màu chủ đạo, và có thể chứa danh sách, công thức hay nhiều đoạn văn.

## Trích dẫn nguyên văn

```latex
\begin{quote}
  Một đoạn trích dẫn dài, được thụt vào hai bên.
\end{quote}
```

Nhớ thêm `~\cite{...}` cho đoạn trích (xem [Trích dẫn](06-tham-chieu-va-trich-dan.md#trích-dẫn)).

---

[← Trang trước: Tuỳ chọn của template](02-tuy-chon.md) | [Mục lục](README.md) | [Trang sau: Hình và bảng →](04-hinh-va-bang.md)
