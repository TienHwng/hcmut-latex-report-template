# Template báo cáo LaTeX (HCMUT)

Template báo cáo nhóm, biên dịch bằng **pdfLaTeX + BibTeX** và có hỗ trợ tiếng Việt.

## Cấu trúc

```text
main.tex                  Điểm vào: chỉ liệt kê các phần của báo cáo
config/
  metadata.tex            Tên đề tài, môn học, giảng viên, thành viên  <- sửa đầu tiên
  report.sty              Package, lề trang, header/footer, trang bìa, macro
  assets/                 Logo trường, ảnh nền bìa (ảnh của template, không phải của bài)
frontmatter/
  members.tex             Bảng phân công và bảng đánh giá của giảng viên
chapters/                 Mỗi section một file: 01-..., 02-..., ...
appendices/               Mỗi phụ lục một file
bib/references.bib        Tài liệu tham khảo
images/                   Hình trong bài, có thể chia thư mục con theo chương
.latexmkrc                Cấu hình build: main.pdf ở root, file phụ trong build/
```

Nguyên tắc là **nội dung, dữ liệu và định dạng nằm ở ba nơi khác nhau**:

- Đổi thông tin nhóm thì chỉ sửa `config/metadata.tex`.
- Đổi giao diện thì chỉ sửa `config/report.sty` và `config/assets/`.
- Viết bài thì chỉ sửa `chapters/` và `appendices/`.

Bắt đầu báo cáo mới: copy cả thư mục `config/` sang là có đủ định dạng lẫn logo.

## Build

| Cách | Lệnh |
| --- | --- |
| Terminal | `latexmk`, PDF ra ở `main.pdf` (root); `.aux`, `.log`... nằm trong `build/` |
| Tự build lại mỗi khi lưu | `latexmk -pvc` |
| Xoá file phụ | `latexmk -c` (giữ PDF) hoặc `latexmk -C` (xoá cả PDF) |
| VS Code | Cài extension **LaTeX Workshop**, mở `main.tex`, rồi lưu file là tự build (đã cấu hình sẵn trong `.vscode/settings.json`) |
| Overleaf | Upload toàn bộ thư mục, chọn compiler **pdfLaTeX** và main document **main.tex** |

**Nhảy qua lại giữa code và PDF (SyncTeX)** trong VS Code:

- Từ PDF sang code: giữ **Ctrl** rồi click vào chữ trong PDF.
- Từ code sang PDF: bấm **Ctrl+Alt+J** khi con trỏ đang ở file `.tex`. Có thể đổi phím tắt này trong *Keyboard Shortcuts*, tìm `latex-workshop.synctex`.

File `main.synctex.gz` phải nằm cạnh `main.pdf` thì SyncTeX mới chạy, nên đừng xoá hay di chuyển nó.

Khi đang viết một chương, bỏ comment dòng `\includeonly{...}` trong `main.tex` để chỉ biên dịch chương đó. Số trang và tham chiếu tới các chương khác vẫn được giữ.

## Cách viết

**Thêm thành viên** (trong `config/metadata.tex`). Một dòng sẽ tự xuất hiện ở trang bìa, bảng phân công và bảng đánh giá:

```latex
\addmember{Nguyễn Văn A}{2312345}{Viết chương 2}{100\%}
```

**Thêm chương**: tạo `chapters/06-ten-chuong.tex` bắt đầu bằng `\section{...}`, rồi thêm `\include{chapters/06-ten-chuong}` vào `main.tex`. Mỗi `\include` tự sang trang mới, nên không cần `\newpage`.

**Đoạn văn**: để một dòng trống giữa hai đoạn. **Không** kết thúc đoạn bằng `\\`, vì sẽ gây warning `Underfull \hbox`. Khoảng cách giữa các đoạn do package `parskip` lo.

**Hình**: đặt file vào `images/` (hoặc thư mục con theo chương, ví dụ `images/03-solution-design/`) rồi gọi theo đường dẫn tính từ `images/`, không cần ghi đuôi file. Sơ đồ và biểu đồ nên xuất PDF (vector), ảnh chụp màn hình dùng PNG, ảnh chụp thật dùng JPG.

```latex
\begin{figure}[H]
  \centering
  \includegraphics[width=0.8\textwidth]{03-solution-design/architecture}
  \caption{Mô tả hình}
  \label{fig:architecture}
\end{figure}
```

**Bảng**: caption đặt **trên** bảng. Với cột chữ dài, dùng các kiểu cột có sẵn sau để chữ không bị giãn:

- `L`: cột X căn trái
- `C`: cột X căn giữa
- `P{3cm}`: cột rộng cố định, căn trái

```latex
\begin{table}[H]
  \centering
  \caption{Mô tả bảng}
  \label{tab:ten-bang}
  \begin{tabularx}{\textwidth}{|P{3cm}|L|}
    \hline
    \textbf{Cột 1} & \textbf{Cột 2} \\ \hline
    ...
  \end{tabularx}
\end{table}
```

**Tham chiếu**: dùng `\cref{tab:ten-bang}`, LaTeX sẽ tự in "Table 3.1". Quy ước tiền tố cho nhãn: `fig:`, `tab:`, `sec:`, `eq:`, `lst:`, `app:`.

**Trích dẫn**: thêm entry vào `bib/references.bib` rồi gọi `\cite{key}`. Danh sách tài liệu tham khảo dùng style IEEE. Với văn bản luật hay tổ chức, đặt tên trong cặp ngoặc kép `{{...}}` để BibTeX không tách thành họ và tên.

**Hộp nhấn mạnh**:

```latex
\begin{keybox}{Tiêu đề}
  Nội dung...
\end{keybox}
```

**Code**: `\begin{lstlisting}[language=Python, caption={...}]` ... `\end{lstlisting}`.

## Báo cáo viết bằng tiếng Việt

Trong `config/report.sty`, đổi `\RequirePackage[vietnamese,english]{babel}` thành `[english,vietnamese]` (ngôn ngữ đứng cuối là ngôn ngữ chính). Khi đó các tiêu đề "Contents", "References", "Appendix" và nhãn caption "Table", "Figure" sẽ chuyển sang tiếng Việt. Riêng `\cref` vẫn in "Table"/"Figure" vì package `cleveref` chưa có bản dịch tiếng Việt. Muốn đổi, thêm vào cuối `report.sty` (ngay trước `\endinput`):

```latex
\crefname{table}{Bảng}{Bảng}   \Crefname{table}{Bảng}{Bảng}
\crefname{figure}{Hình}{Hình}  \Crefname{figure}{Hình}{Hình}
```
