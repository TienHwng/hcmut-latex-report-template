# Template báo cáo LaTeX (HCMUT)

Template báo cáo nhóm, biên dịch bằng **pdfLaTeX + BibTeX** và có hỗ trợ tiếng Việt.

## Cấu trúc

```text
main.tex                  Điểm vào: chỉ liệt kê các phần của báo cáo
config/
  metadata.tex            Tên đề tài, môn học, giảng viên, thành viên  <- sửa đầu tiên
  abbreviations.tex       Danh sách từ viết tắt
  report.sty              Package, lề trang, màu, header/footer, trang bìa, macro
  assets/                 Logo trường, ảnh nền bìa (ảnh của template, không phải của bài)
frontmatter/
  members.tex             Bảng phân công và bảng đánh giá của giảng viên
  declaration.tex         Lời cam đoan có chỗ ký (bật trong main.tex khi cần)
chapters/                 Mỗi section một file: 01-..., 02-..., ...
appendices/               Mỗi phụ lục một file
bib/references.bib        Tài liệu tham khảo
images/                   Hình trong bài, có thể chia thư mục con theo chương
.latexmkrc                Cấu hình build: main.pdf ở root, file phụ trong build/
.chktexrc                 Luật kiểm tra lỗi LaTeX (ChkTeX)
.vscode/                  Cấu hình LaTeX Workshop, LTeX+ và extension gợi ý
.github/workflows/        Tự build PDF trên GitHub
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
| Overleaf | Upload toàn bộ thư mục, chọn compiler **pdfLaTeX** và main document **main.tex**. Overleaf tự chọn thư mục output nên `.latexmkrc` không gây ảnh hưởng |
| GitHub | Push lên là tự build, xem mục [Build trên GitHub](#build-trên-github) |

**Nhảy qua lại giữa code và PDF (SyncTeX)** trong VS Code:

- Từ PDF sang code: giữ **Ctrl** rồi click vào chữ trong PDF.
- Từ code sang PDF: bấm **Ctrl+Alt+J** khi con trỏ đang ở file `.tex`. Có thể đổi phím tắt này trong *Keyboard Shortcuts*, tìm `latex-workshop.synctex`.

File `main.synctex.gz` phải nằm cạnh `main.pdf` thì SyncTeX mới chạy, nên đừng xoá hay di chuyển nó.

Khi đang viết một chương, bỏ comment dòng `\includeonly{...}` trong `main.tex` để chỉ biên dịch chương đó. Số trang và tham chiếu tới các chương khác vẫn được giữ.

## Tuỳ chọn của template

Đặt option ở dòng `\usepackage{config/report}` trong `main.tex`:

```latex
\usepackage[vietnamese,draft]{config/report}
```

| Option | Tác dụng |
| --- | --- |
| `english` (mặc định) | Tiêu đề, caption, chữ trên bìa, header/footer bằng tiếng Anh |
| `vietnamese` | Chuyển tất cả sang tiếng Việt: "Mục lục", "Tài liệu tham khảo", "Bảng 3.1", "Giảng viên hướng dẫn", "MSSV", "Trang 3/18"..., kể cả chữ mà `\cref` in ra ("Mục 2.4", "Phụ lục A") |
| `final` (mặc định) | Bản để nộp |
| `draft` | Bản nháp: hiện ghi chú `\todo`/`\note` bên lề, danh sách ghi chú sau mục lục và chữ chìm **DRAFT** |
| `print` | Bản in giấy: link và số trích dẫn màu đen, không có khung |
| `lists` | Thêm danh sách hình và danh sách bảng sau mục lục |

**Ngày trên bìa**: nếu xoá dòng `\date{...}` trong `config/metadata.tex`, bìa tự in tháng và năm lúc build, theo ngôn ngữ đã chọn ("November 2026" hoặc "tháng 11 năm 2026"). Giữ dòng đó nếu muốn cố định ngày nộp.

**Văn bản khác nhau theo ngôn ngữ**: trong các file nội dung có thể viết

```latex
\ifreportvietnamese Văn bản tiếng Việt \else English text \fi
```

Ví dụ có sẵn trong `frontmatter/declaration.tex`.

**Màu chủ đạo**: hai màu `primary` (xanh đậm) và `secondary` (xanh nhạt) lấy từ logo trường, khai báo ở mục 3 của `config/report.sty`. Đổi hai dòng đó là đổi màu tên đề tài, đường kẻ trên bìa, link, hộp `keybox` và ghi chú nháp. Trong bài cũng dùng được, ví dụ `\textcolor{primary}{...}`.

## Cách viết

**Thêm thành viên** (trong `config/metadata.tex`). Một dòng sẽ tự xuất hiện ở trang bìa, bảng phân công, bảng đánh giá và trường *Author* của file PDF:

```latex
\addmember{Nguyễn Văn A}{2312345}{Viết chương 2}{100\%}
```

**Thông tin thêm trên bìa** (trong `config/metadata.tex`, để trống hoặc xoá thì không hiện):

```latex
\reporttype{BÁO CÁO BÀI TẬP LỚN}   % dòng dưới tên môn học
\classcode{L01}                    % "Lớp: L01"
\group{5}                          % "Nhóm: 5"
```

**Lời cam đoan**: bỏ comment dòng `\input{frontmatter/declaration}` trong `main.tex`. Trang này có đoạn cam đoan (tự đổi theo ngôn ngữ) và bảng để từng thành viên ký, lấy từ danh sách `\addmember`.

**Từ viết tắt**: khai báo trong `config/abbreviations.tex`, rồi dùng `\ac{key}` trong bài.

```latex
\abbreviation{genai}{GenAI}{Generative Artificial Intelligence}   % khai báo
\ac{genai}    % lần đầu: "Generative Artificial Intelligence (GenAI)", sau đó: "GenAI"
\Ac{genai}    % như \ac nhưng viết hoa chữ đầu, dùng ở đầu câu
\acs{genai}   % luôn in dạng ngắn "GenAI"
\acl{genai}   % luôn in dạng đầy đủ
```

Trang *List of Abbreviations* (hay *Danh mục từ viết tắt*) tự xuất hiện sau mục lục, chỉ gồm các từ có dùng trong bài. Xoá hết khai báo thì trang này cũng biến mất. Không dùng `\ac` trong tiêu đề mục hay caption, vì nội dung đó còn được in ở mục lục: lần xuất hiện "đầu tiên" sẽ bị tính nhầm ở mục lục. Ở những chỗ đó viết chữ thường (`GenAI`). Trong nhãn in đậm thì dùng `\acs`.

**Thêm chương**: tạo `chapters/06-ten-chuong.tex` bắt đầu bằng `\section{...}\label{sec:ten-chuong}`, rồi thêm `\include{chapters/06-ten-chuong}` vào `main.tex`. Mỗi `\include` tự sang trang mới, nên không cần `\newpage`.

**Đoạn văn**: để một dòng trống giữa hai đoạn. **Không** kết thúc đoạn bằng `\\`, vì sẽ gây warning `Underfull \hbox`. Khoảng cách giữa các đoạn do package `parskip` lo.

**Hình**: đặt file vào `images/` (hoặc thư mục con theo chương, ví dụ `images/03-solution-design/`) rồi gọi theo đường dẫn tính từ `images/`, không cần ghi đuôi file. Sơ đồ và biểu đồ nên xuất PDF (vector), ảnh chụp màn hình dùng PNG, ảnh chụp thật dùng JPG.

```latex
\begin{figure}[H]
  \centering
  \includegraphics[width=0.8\textwidth]{03-solution-design/architecture}
  \caption{Mô tả hình}\label{fig:architecture}
\end{figure}
```

**Bảng**: caption đặt **trên** bảng. Bảng nội dung dùng kiểu *booktabs*: không kẻ dọc, chỉ có ba đường kẻ ngang `\toprule`, `\midrule`, `\bottomrule`, và ngăn các dòng dài bằng `\addlinespace`. `@{}` ở hai đầu bỏ khoảng trống thừa ở mép bảng. Với cột chữ dài, dùng các kiểu cột có sẵn sau để chữ không bị giãn:

- `L`: cột X căn trái
- `C`: cột X căn giữa
- `P{3cm}`: cột rộng cố định, căn trái

```latex
\begin{table}[H]
  \centering
  \caption{Mô tả bảng}\label{tab:ten-bang}
  \begin{tabularx}{\textwidth}{@{}P{3cm}L@{}}
    \toprule
    \textbf{Cột 1} & \textbf{Cột 2} \\
    \midrule
    Dòng 1 & ... \\
    \addlinespace
    Dòng 2 & ... \\
    \bottomrule
  \end{tabularx}
\end{table}
```

**Nhãn và tham chiếu**: đặt `\label` ngay sau lệnh tạo số (`\section{...}\label{...}`, `\caption{...}\label{...}`), không xuống dòng ở giữa. Quy ước tiền tố: `sec:`, `fig:`, `tab:`, `eq:`, `lst:`, `app:`.

- `\cref{tab:ten-bang}` in "Table 3.1" kèm link. Nếu đổi thứ tự chương, số tự cập nhật.
- `\hyperref[sec:solution-design]{Stage~3}` giữ nguyên chữ bạn viết nhưng biến nó thành link. Dùng khi tên gọi cố định (như "Stage 3" theo đề bài) không phải là số mục.

**Trích dẫn**: thêm entry vào `bib/references.bib` rồi gọi `Code of Ethics~\cite{acm}`. Dấu `~` là khoảng trắng không ngắt dòng, giúp `[1]` không bị đẩy xuống đầu dòng sau. Danh sách tài liệu tham khảo dùng style IEEE và đánh số theo thứ tự xuất hiện. Với văn bản luật hay tổ chức, đặt tên trong cặp ngoặc kép `{{...}}` để BibTeX không tách thành họ và tên.

**Viết tắt có dấu chấm** như "vs.", "e.g.", "i.e.": thêm `\` ngay trước khoảng trắng phía sau, ví dụ `deepfakes vs.\ innovation`. Nếu không, LaTeX tưởng là hết câu và chừa khoảng trắng rộng.

**Thuật ngữ**: `\term{pacing problem}` in đậm nghiêng. Muốn đổi cách nhấn mạnh mọi thuật ngữ, chỉ sửa định nghĩa `\term` trong `report.sty`.

**Hộp nhấn mạnh**:

```latex
\begin{keybox}{Tiêu đề}
  Nội dung...
\end{keybox}
```

**Code**: `\begin{lstlisting}[language=Python, caption={...}]` ... `\end{lstlisting}`.

## Làm việc nhóm: ghi chú nháp

Khi build với option `draft`, các ghi chú hiện bên lề và được liệt kê sau mục lục. Với `final`, chúng tự biến mất nên không cần xoá trước khi nộp.

```latex
\todo{Cần thêm nguồn}               % ghi chú cam bên lề
\todo[inline]{Viết lại đoạn này}    % ghi chú chiếm cả chiều ngang
\note[Hưng]{Kiểm tra lại số liệu}   % ghi chú xanh, có tên người viết
```

## Công cụ kiểm tra

Mở thư mục bằng VS Code sẽ thấy gợi ý cài các extension trong `.vscode/extensions.json`.

- **ChkTeX** (có sẵn trong TeX Live): LaTeX Workshop chạy mỗi khi lưu và gạch chân lỗi như thiếu `~` trước `\cite`, sai loại gạch ngang, khoảng trắng sau dấu chấm. Luật nằm trong `.chktexrc`. Chạy tay: `chktex -q -l .chktexrc main.tex`.
- **LTeX+**: kiểm tra chính tả và ngữ pháp **tiếng Anh**, hiểu được cú pháp LaTeX. LanguageTool (công cụ LTeX+ dùng để soát lỗi) không có tiếng Việt, nên với báo cáo tiếng Việt hãy tắt LTeX+. Từ chuyên ngành bị báo sai thì chọn *Add to dictionary* (lưu vào `ltex.dictionary`).
- **Đếm chữ**: `Ctrl+Shift+P` rồi chọn *LaTeX Workshop: Count words in LaTeX project*, hoặc chạy trong terminal:

  ```sh
  texcount -inc -brief -q main.tex
  ```

  Lệnh này in số chữ của từng chương và tổng cộng.

## Build trên GitHub

`.github/workflows/build.yml` chạy hai việc song song mỗi khi push hoặc mở pull request:

- **lint**: chạy ChkTeX với `.chktexrc`. Có cảnh báo nào thì GitHub đánh dấu đỏ, nhưng PDF vẫn được build.
- **build**: build `main.pdf`. PDF nằm ở trang của lần chạy, trong tab *Actions*, mục *Artifacts*.
- Khi push một tag bắt đầu bằng `v`, PDF được đính kèm vào một GitHub Release. Đây là cách tiện để nộp hoặc chia sẻ bản chốt:

  ```sh
  git tag v1.0
  git push origin v1.0
  ```

Thành viên không cài TeX vẫn tải được bản PDF mới nhất.
