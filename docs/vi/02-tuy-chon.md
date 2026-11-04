# Tuỳ chọn của template

**Tiếng Việt** | [English](../en/02-options.md)

Option được ghi ở dòng `\usepackage` trong `main.tex`. Có thể dùng nhiều option cùng lúc, cách nhau bằng dấu phẩy, không phân biệt thứ tự:

```latex
\usepackage{config/report}                        % mặc định: tiếng Anh, bản nộp
\usepackage[vietnamese]{config/report}            % tiếng Việt, bản nộp
\usepackage[vietnamese,draft]{config/report}      % tiếng Việt, bản nháp
\usepackage[vietnamese,print,lists]{config/report}
```

| Option | Tác dụng |
| --- | --- |
| `english` | (mặc định) Chữ do template sinh ra bằng tiếng Anh |
| `vietnamese` | Chữ do template sinh ra bằng tiếng Việt |
| `final` | (mặc định) Bản nộp: không ghi chú, không chữ chìm |
| `draft` | Bản nháp: hiện ghi chú `\todo`/`\note`, danh sách ghi chú và chữ chìm DRAFT |
| `print` | Bản in giấy: link và số trích dẫn màu đen thay vì màu xanh |
| `lists` | Thêm danh sách hình và danh sách bảng sau mục lục |

Option viết sai tên (ví dụ `vietnam`) **không** làm build thất bại. Log chỉ có cảnh báo `Unknown option` và option đó không có tác dụng, nên rất dễ bỏ sót.

## Ngôn ngữ: `english` / `vietnamese`

> [!IMPORTANT]
> Option ngôn ngữ **chỉ đổi những chữ do template tự sinh ra**. Nội dung bạn viết trong `chapters/` thì giữ nguyên: báo cáo tiếng Việt thì bạn tự viết bằng tiếng Việt.

| Chỗ | `english` | `vietnamese` |
| --- | --- | --- |
| Tiêu đề các danh sách | Contents, References, List of Figures, List of Tables, List of Abbreviations | Mục lục, Tài liệu tham khảo, Danh sách hình vẽ, Danh sách bảng, Danh mục từ viết tắt |
| Caption | Figure 1.1, Table 1.1, Listing 1 | Hình 1.1, Bảng 1.1, Đoạn mã 1 |
| `\cref{...}` | Section 2, Figure 1.1, Table 1.1, Equation (1.1), Appendix A | Mục 2, Hình 1.1, Bảng 1.1, Công thức (1.1), Phụ lục A |
| Phụ lục | Appendix A | Phụ lục A |
| Trang bìa | Instructor, Class, Group, Student's Name, Student ID | Giảng viên hướng dẫn, Lớp, Nhóm, Họ và tên, MSSV |
| Bảng thành viên | No., Full name, Contribution, Percentage, Evaluation, Signature | STT, Họ và tên, Nhiệm vụ, Mức độ, Đánh giá, Chữ ký |
| Tiêu đề trang đầu | Member List & Workload, Lecturer's Assessment, Declaration | Danh sách thành viên & phân công, Đánh giá của giảng viên, Lời cam đoan |
| Footer | Semester 252, Page 3/10 | Học kỳ 252, Trang 3/10 |
| Ngày mặc định | November 2026 | tháng 11 năm 2026 |
| Quy tắc ngắt từ, ngôn ngữ của PDF | Tiếng Anh | Tiếng Việt |

Đổi ngôn ngữ **không** dịch những gì bạn tự viết: thông tin trong `config/metadata.tex` (tên trường, tên môn, dòng chữ ở đầu trang, công việc của thành viên) và nội dung các chương. Các chương mẫu trên nhánh `main` viết bằng tiếng Anh, nên nếu chỉ bật `vietnamese` thì báo cáo sẽ nửa Anh nửa Việt cho đến khi bạn viết lại chúng. Báo cáo tiếng Việt thì bạn nhập những phần đó bằng tiếng Việt.

### Viết một đoạn khác nhau theo ngôn ngữ

Đa số báo cáo chỉ viết bằng một ngôn ngữ nên không cần đến phần này. Nhưng khi muốn một đoạn văn tự đổi theo option, ví dụ để dùng cùng một bản nguồn cho cả hai thứ tiếng, hãy dùng `\ifreportvietnamese`:

```latex
\ifreportvietnamese
  Nội dung tiếng Việt.
\else
  English content.
\fi
```

`frontmatter/declaration.tex` dùng đúng cách này để có lời cam đoan hai thứ tiếng.

### Chèn một đoạn tiếng Anh vào bài tiếng Việt

Cả hai ngôn ngữ luôn được nạp sẵn. Một trích dẫn dài bằng tiếng Anh trong bài tiếng Việt có thể dùng quy tắc ngắt từ tiếng Anh:

```latex
\begin{otherlanguage}{english}
  A long quotation in English ...
\end{otherlanguage}
```

## Bản nháp: `draft`

Dùng trong lúc viết và sửa bài:

- Các ghi chú `\todo{...}` và `\note{...}` hiện ra bên lề (xem [Làm việc nhóm](08-lam-viec-nhom.md#ghi-chú-cho-nhau)).
- Sau mục lục có trang **List of Todos** (bản tiếng Việt: *Danh sách ghi chú*) liệt kê mọi ghi chú; bấm vào một dòng để nhảy tới chỗ ghi chú đó.
- Mỗi trang có chữ chìm **DRAFT** màu xám, nên không thể nhầm bản nháp với bản nộp.

Bỏ `draft` đi thì cả ba thứ trên tự biến mất. Bạn không cần xoá ghi chú khỏi file nguồn.

## Bản in: `print`

Mặc định, link, số trích dẫn và tham chiếu được tô màu xanh để dễ nhận ra trên màn hình. Khi in ra giấy, màu xanh trông giống lỗi in, nên option `print` chuyển chúng về màu chữ bình thường. Link vẫn bấm được khi mở PDF.

Bản nộp file thì nên **bỏ** `print`, còn bản nộp giấy thì nên thêm vào.

## Danh sách hình và bảng: `lists`

Thêm hai trang *List of Figures* và *List of Tables* (Danh sách hình vẽ, Danh sách bảng) ngay sau mục lục; cả hai cũng có mục trong mục lục. Nên dùng khi báo cáo có nhiều hình và bảng hoặc khi môn học yêu cầu.

Trang **danh mục từ viết tắt** không cần option nào: nó tự xuất hiện khi `config/abbreviations.tex` có khai báo từ viết tắt (xem [Từ viết tắt](07-tu-viet-tat.md)).

## Thử option mà không sửa main.tex

Muốn xem thử bản nháp nhưng không muốn làm thay đổi `main.tex` của cả nhóm? Copy `main.tex` thành `thu.tex`, sửa dòng `\usepackage` trong file copy, rồi build:

```sh
latexmk thu.tex
```

Xem xong thì xoá `thu.tex`, `thu.pdf` và `thu.synctex.gz`.

---

[← Trang trước: Thông tin báo cáo và trang bìa](01-thong-tin-bao-cao.md) | [Mục lục](README.md) | [Trang sau: Soạn thảo văn bản →](03-soan-thao.md)
