# Hình và bảng

**Tiếng Việt** | [English](../en/04-figures-and-tables.md)

Hình và bảng được đánh số theo chương: Hình 2.1, Hình 2.2, Bảng 3.1… Luôn gắn `\label` để tham chiếu bằng `\cref` (xem [Tham chiếu chéo](06-tham-chieu-va-trich-dan.md)).

## Hình

### Chèn một ảnh

Đặt file ảnh vào `images/`. Có thể chia thư mục con theo chương:

```text
images/
├── 01-introduction/
│   └── timeline.png
└── 02-method/
    ├── architecture.pdf
    └── survey-form.jpg
```

```latex
\begin{figure}[H]
  \centering
  \includegraphics[width=0.8\textwidth]{02-method/architecture}
  \caption{Kiến trúc hệ thống}\label{fig:architecture}
\end{figure}
```

- Đường dẫn tính từ `images/` và **không cần đuôi file**. LaTeX tự tìm `.pdf`, `.png`, `.jpg`.
- `width=0.8\textwidth` là 80% bề rộng vùng chữ. Có thể dùng `height=6cm`, hoặc `width=\textwidth, height=8cm, keepaspectratio` để ảnh vừa khung mà không méo.
- Caption đặt **dưới** hình, `\label` đặt ngay sau `\caption`.

> [!WARNING]
> Tên file và thư mục không dấu, không khoảng trắng; chữ hoa và chữ thường phải khớp. Trên Windows `Chart.png` và `chart.png` là một, nhưng Overleaf và GitHub thì phân biệt, nên build ở đó sẽ báo không tìm thấy file.

**Nên chọn định dạng nào?** Sơ đồ và biểu đồ (từ draw.io, Excel, matplotlib…) nên xuất ra **PDF** để giữ nét khi phóng to. Ảnh chụp màn hình dùng **PNG**, ảnh chụp thật dùng **JPG**.

### Vị trí của hình

| Viết | Ý nghĩa |
| --- | --- |
| `[H]` | Đặt **đúng chỗ** trong file nguồn. Dễ đoán, nhưng có thể để lại khoảng trắng cuối trang nếu hình không vừa |
| `[htbp]` | Để LaTeX tự chọn: tại chỗ, đầu trang, cuối trang hoặc trang riêng. Dàn trang đẹp hơn với bài nhiều hình |

Với `[htbp]`, hình có thể trôi sang trang sau, nên trong bài hãy viết "như \cref{fig:...}" thay vì "như hình dưới đây".

### Nhiều ảnh cạnh nhau

```latex
\begin{figure}[H]
  \centering
  \begin{subfigure}{0.45\textwidth}
    \centering
    \includegraphics[width=\linewidth]{03-results/before}
    \caption{Trước khi tối ưu}\label{fig:before}
  \end{subfigure}\hfill
  \begin{subfigure}{0.45\textwidth}
    \centering
    \includegraphics[width=\linewidth]{03-results/after}
    \caption{Sau khi tối ưu}\label{fig:after}
  \end{subfigure}
  \caption{So sánh thời gian phản hồi}\label{fig:comparison}
\end{figure}
```

Kết quả gồm Hình 3.1a, Hình 3.1b và Hình 3.1. `\cref{fig:before}` in "Hình 3.1a", `\cref{fig:comparison}` in "Hình 3.1".

Tổng bề rộng các `subfigure` (ở đây 0.45 + 0.45) phải nhỏ hơn 1. Muốn ba ảnh trên một hàng thì dùng 0.3 cho mỗi ảnh.

### Vẽ sơ đồ bằng TikZ

Sơ đồ đơn giản có thể vẽ thẳng trong LaTeX, không cần file ảnh. Chữ trong sơ đồ dùng cùng font với bài viết. Xem ví dụ đầy đủ trong `chapters/02-method.tex`:

```latex
\begin{figure}[H]
  \centering
  \begin{tikzpicture}[
      node distance=1.2cm,
      box/.style={draw=primary, fill=primary!8, rounded corners,
                  minimum width=2.6cm, minimum height=1cm, align=center},
      arrow/.style={-Stealth, thick, primary}]
    \node[box] (a) {Thu thập};
    \node[box, right=of a] (b) {Xử lý};
    \node[box, right=of b] (c) {Đánh giá};
    \draw[arrow] (a) -- (b);
    \draw[arrow] (b) -- (c);
  \end{tikzpicture}
  \caption{Quy trình làm việc}\label{fig:pipeline}
\end{figure}
```

Sơ đồ phức tạp thì vẽ bằng [draw.io](https://app.diagrams.net) và xuất ra PDF sẽ nhanh hơn.

## Bảng

Template dùng kiểu bảng **booktabs**: không kẻ dọc, chỉ ba đường ngang (trên cùng, dưới tiêu đề, dưới cùng). Kiểu này dễ đọc hơn bảng kẻ ô.

Caption của bảng đặt **trên** bảng, ngược với hình (caption dưới hình).

### Bảng cơ bản

```latex
\begin{table}[H]
  \centering
  \caption{Kết quả thử nghiệm}\label{tab:results}
  \begin{tabular}{@{}lcr@{}}
    \toprule
    \textbf{Mô hình} & \textbf{Độ chính xác} & \textbf{Thời gian (s)} \\
    \midrule
    Baseline  & 0.72 & 12.4 \\
    Đề xuất   & 0.85 & 15.1 \\
    \bottomrule
  \end{tabular}
\end{table}
```

- `&` ngăn cột, `\\` kết thúc dòng.
- `{@{}lcr@{}}`: ba cột căn trái (`l`), giữa (`c`) và phải (`r`). `@{}` ở hai đầu bỏ khoảng trống thừa ở mép bảng.
- `\toprule`, `\midrule`, `\bottomrule` là ba đường kẻ. Muốn tách nhóm dòng thì dùng `\addlinespace` (khoảng trắng) hoặc `\midrule`.
- Số nên căn phải (`r`) để các chữ số thẳng hàng.

### Bảng có cột chữ dài

Với cột `l`/`c`/`r`, chữ không tự xuống dòng nên bảng dễ tràn lề. Khi đó dùng `tabularx` với các kiểu cột của template:

```latex
\begin{table}[H]
  \centering
  \caption{So sánh các phương án}\label{tab:comparison}
  \begin{tabularx}{\textwidth}{@{}P{3cm}LC@{}}
    \toprule
    \textbf{Phương án} & \textbf{Nhận xét} & \textbf{Điểm} \\
    \midrule
    Phương án A & Chi phí thấp nhưng phạm vi hẹp, khó mở rộng khi số người dùng tăng. & 0.55 \\
    \addlinespace
    Phương án B & Cân bằng giữa chi phí và lợi ích. & 0.80 \\
    \bottomrule
  \end{tabularx}
\end{table}
```

| Kiểu cột | Ý nghĩa |
| :---: | --- |
| `l`, `c`, `r` | Rộng vừa chữ, căn trái/giữa/phải, không xuống dòng |
| `L` | Tự giãn cho bảng rộng đúng `\textwidth`, căn trái, tự xuống dòng |
| `C` | Như `L` nhưng căn giữa |
| `P{3cm}` | Rộng cố định 3 cm, căn trái, tự xuống dòng |

Bảng phải có ít nhất một cột `L` hoặc `C` thì `tabularx` mới biết cột nào được giãn.

### Gộp ô và tô màu dòng

```latex
\begin{tabular}{@{}llr@{}}
  \toprule
  \textbf{Nhóm} & \textbf{Hạng mục} & \textbf{Giá trị} \\
  \midrule
  \multirow{2}{*}{A} & Thiết kế  & 1 \\
                     & Lập trình & 2 \\
  \cmidrule(l){2-3}
  \rowcolor{primary!10} B & Kiểm thử & 3 \\
  \bottomrule
\end{tabular}
```

- `\multirow{2}{*}{A}` gộp 2 dòng của cột đầu; các dòng sau để trống ô đó.
- `\multicolumn{2}{c}{Tiêu đề chung}` gộp 2 cột.
- `\cmidrule(l){2-3}` kẻ đường ngắn chỉ ở cột 2 đến 3.
- `\rowcolor{primary!10}` tô nền dòng bằng màu chủ đạo pha nhạt 10%.

### Bảng quá dài hoặc quá rộng

- Bảng rộng: thu chữ bằng `\small` hoặc `\footnotesize` đặt ngay sau `\centering`, hoặc chuyển các cột chữ sang `L`.
- Bảng dài hơn một trang: chia thành nhiều bảng nhỏ, hoặc đưa bảng đầy đủ vào phụ lục và chỉ giữ bảng tóm tắt trong bài.

### Tạo bảng nhanh

Bảng lớn có sẵn trong Excel hoặc Google Sheets thì dùng [Tables Generator](https://www.tablesgenerator.com/latex_tables): dán dữ liệu vào, chọn *Booktabs table style*, rồi copy code về và sửa lại caption và label.

---

[← Trang trước: Soạn thảo văn bản](03-soan-thao.md) | [Mục lục](README.md) | [Trang sau: Công thức và code →](05-cong-thuc-va-code.md)
