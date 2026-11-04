# Công thức và code

**Tiếng Việt** | [English](../en/05-math-and-code.md)

## Công thức

### Trong dòng và đứng riêng

```latex
Năng lượng được tính bằng $E = mc^2$, trong đó $m$ là khối lượng.

\begin{equation}
  S = \sum_{i=1}^{n} w_i s_i \label{eq:score}
\end{equation}
```

- `$...$` là công thức nằm trong câu.
- `equation` là công thức đứng riêng một dòng, được đánh số theo chương, ví dụ (2.1). Tham chiếu tới nó bằng `\cref{eq:score}`, in ra "Equation (2.1)" hoặc "Công thức (2.1)".
- Công thức không cần đánh số thì dùng `\[ ... \]` hoặc `equation*`.

**`$...$` hay `\(...\)`?** Cả hai cho kết quả giống hệt nhau. `$...$` ngắn gọn và phổ biến hơn hẳn, nên template dùng nó. `\(...\)` là cú pháp "chuẩn" của LaTeX và báo lỗi rõ hơn khi quên đóng, nhưng ít người dùng. Chọn một kiểu và dùng thống nhất trong cả bài. ChkTeX đã được cấu hình để không nhắc chuyển sang `\(...\)`.

### Nhiều dòng thẳng hàng

```latex
\begin{align}
  a &= b + c \label{eq:first}\\
  d &= e - f \label{eq:second}
\end{align}
```

Dấu `&` đánh dấu chỗ các dòng thẳng hàng với nhau (thường đặt trước dấu `=`). Mỗi dòng có số riêng; dòng nào không cần số thì thêm `\nonumber` trước `\\`. Tham chiếu nhiều công thức cùng lúc: `\cref{eq:first,eq:second}` in ra "Công thức (2.1) và (2.2)".

### Ký hiệu hay dùng

| Viết | Kết quả | Viết | Kết quả |
| --- | --- | --- | --- |
| `x^2`, `x_i` | mũ, chỉ số dưới | `\frac{a}{b}` | phân số |
| `\sqrt{x}` | căn bậc hai | `\sum_{i=1}^{n}` | tổng |
| `\le`, `\ge`, `\ne` | ≤, ≥, ≠ | `\approx`, `\times` | ≈, × |
| `\alpha`, `\beta`, `\lambda` | α, β, λ | `\in`, `\mathbb{R}` | ∈, ℝ |
| `\text{điểm}` | chữ thường trong công thức | `\left( \frac{a}{b} \right)` | ngoặc tự to theo nội dung |

Không nhớ lệnh thì vẽ ký hiệu vào [Detexify](https://detexify.kirelabs.org), trang này sẽ cho biết tên lệnh.

## Code

### Đoạn code ngắn

```latex
\begin{lstlisting}[language=Python, caption={Tính điểm có trọng số}, label={lst:score}]
def score(weights, scores):
    return sum(w * s for w, s in zip(weights, scores))
\end{lstlisting}
```

- Code có sẵn số dòng, khung, màu cho từ khoá, chuỗi và comment, và tự xuống dòng khi quá dài.
- `caption` nằm dưới đoạn code: "Listing 1" hoặc "Đoạn mã 1". Tham chiếu bằng `\cref{lst:score}`.
- Ngôn ngữ hỗ trợ: `Python`, `C`, `C++`, `Java`, `SQL`, `HTML`, `bash`, `Matlab`, `R`… Bỏ `language=...` nếu là văn bản thuần, ví dụ output của chương trình.
- Code bên trong `lstlisting` được in nguyên văn, nên không cần viết `\_` hay `\%`.

> [!WARNING]
> **Không gõ chữ có dấu** trong code, kể cả trong comment: `listings` không hiểu tiếng Việt có dấu và build sẽ báo lỗi.

### Nhúng cả file code

Thay vì copy code vào bài, có thể nhúng trực tiếp file. Khi file code thay đổi, báo cáo cũng tự cập nhật theo:

```latex
\lstinputlisting[language=Python, caption={Chương trình chính}, label={lst:main}]{code/main.py}
```

Đường dẫn tính từ thư mục gốc của template, nên bạn có thể tạo thư mục `code/` để chứa các file. Chỉ lấy một đoạn trong file: thêm `firstline=10, lastline=25` vào trong ngoặc vuông.

### Code trong dòng

Tên hàm, tên biến hay tên file nằm trong câu thì dùng `\texttt{...}`, ví dụ `\texttt{main.py}`. Ký tự đặc biệt bên trong vẫn phải viết dạng `\_`: `\texttt{read\_file}`.

---

[← Trang trước: Hình và bảng](04-hinh-va-bang.md) | [Mục lục](README.md) | [Trang sau: Tham chiếu chéo và trích dẫn →](06-tham-chieu-va-trich-dan.md)
