# Tuỳ biến giao diện

**Tiếng Việt** | [English](../en/10-customization.md)

Phần này dành cho người muốn chỉnh giao diện template. Mọi định dạng nằm trong `config/report.sty`, chia thành các mục có đánh số:

| Mục | Nội dung |
| :---: | --- |
| 0 | Các option (`vietnamese`, `draft`…) |
| 1 | Font chữ và ngôn ngữ |
| 2 | Lề trang |
| 3 | Hình và màu |
| 4 | Bảng và caption |
| 5 | Danh sách, đánh số, phụ lục |
| 6 | Code, hộp nhấn mạnh, `\term`, ghi chú nháp |
| 7 | Link, tham chiếu chéo, từ viết tắt |
| 8 | Các lệnh nhập thông tin và chữ cố định của template |
| 9 | Header và footer |
| 10 | Trang bìa và các bảng thành viên |
| 11 | Các danh sách sau mục lục |

> [!WARNING]
> Trước khi sửa `report.sty`, nên copy ra một bản dự phòng. Sửa xong thì build lại và kiểm tra tab *Problems* không có lỗi mới.

## Logo và ảnh nền bìa

Không cần sửa `report.sty`. Thay file trong `config/assets/`, hoặc trỏ tới file khác trong `config/metadata.tex`:

```latex
\logo{config/assets/logo-khoa}        % logo ở bìa và header
\coverbackground{}                     % không dùng ảnh nền
```

Logo nên là PNG nền trong suốt hoặc PDF. Ảnh nền được co giãn vừa khổ A4 và giữ nguyên tỉ lệ.

## Màu chủ đạo

Template có hai màu, định nghĩa ở mục 3 của `report.sty`:

```latex
\definecolor{primary}{HTML}{032B91}     % xanh đậm: tên đề tài, link, hộp nhấn mạnh
\definecolor{secondary}{HTML}{1488DB}   % xanh nhạt: đường kẻ bìa, ghi chú \note
```

Mặc định hai màu được lấy từ logo HCMUT. Đổi mã màu thì mọi chỗ dùng màu đó đổi theo.

Trong bài viết, dùng **tên màu** thay vì mã màu, ví dụ `\textcolor{primary}{...}`, hoặc `primary!10` cho màu nhạt 10%. Như vậy khi đổi màu chủ đạo, các chỗ đó cũng đổi theo.

## Cỡ chữ

Sửa dòng đầu `main.tex`:

```latex
\documentclass[a4paper,12pt]{article}    % 10pt (mặc định), 11pt hoặc 12pt
```

## Giãn dòng

Thêm vào `main.tex`, ngay sau dòng `\usepackage{...}{config/report}`:

```latex
\linespread{1.3}         % tương đương giãn dòng 1.5 trong Word; 1.6 tương đương giãn dòng 2
```

Hệ số của LaTeX khác với Word: `\linespread{1.3}` mới cho khoảng cách giống "1.5 lines" trong Word.

## Lề trang

Mục 2 của `report.sty`:

```latex
left=2.5cm, right=2.5cm,
top=3.5cm, bottom=2.5cm,
% bindingoffset=1cm,       % bỏ % nếu cần chừa thêm lề để đóng gáy
```

Lề trên rộng hơn lề dưới vì header có logo.

## Header và footer

Mục 9 của `report.sty`. Mặc định:

| | Trái | Phải |
| --- | --- | --- |
| **Header** | Logo + `\headertext` | Số và tên chương hiện tại |
| **Footer** | Tên môn, học kỳ | Trang x/tổng số trang |

Chỉ muốn đổi dòng chữ ở header thì sửa `\headertext{...}` trong `metadata.tex`. Muốn đổi nội dung một ô thì sửa lệnh `\fancyhead[L]`, `\fancyhead[R]`, `\fancyfoot[L]` hoặc `\fancyfoot[R]` trong mục 9. Ví dụ, thêm tên nhóm vào footer bên trái:

```latex
\fancyfoot[L]{\scriptsize\ttfamily
  \rpt@course, \rpt@txt@semester\ \rpt@semester\ -- Nhóm 5}
```

## Chữ cố định của template

Những chữ như "Instructor", "Student ID" hay "Semester" nằm ở mục 8 của `report.sty`. Mỗi chữ có hai bản, tiếng Việt (khối `\ifrpt@vietnamese`) và tiếng Anh (khối `\else`):

```latex
\newcommand*{\rpt@txt@instructor}{Giảng viên hướng dẫn}   % bản tiếng Việt
...
\newcommand*{\rpt@txt@instructor}{Instructor}             % bản tiếng Anh
```

Muốn đổi, ví dụ thành "Supervisor", thì sửa ở **cả hai** khối nếu nhóm có thể dùng cả hai ngôn ngữ.

Tiêu đề của các trang đầu (`\memberlistname`, `\assessmentname`, `\declarationname`, `\abbreviationsname`) có thể đổi riêng cho một báo cáo mà không cần sửa template. Thêm vào cuối `config/metadata.tex`:

```latex
\renewcommand*{\memberlistname}{Bảng phân công công việc}
```

## Trang bìa

Mục 10 của `report.sty`, lệnh `\makecover`. Mỗi dòng trên bìa ứng với một dòng trong lệnh này, theo thứ tự từ trên xuống. Các khoảng cách `\vspace{...}` quyết định bố cục; tăng hoặc giảm chúng để dàn lại trang bìa.

## Thêm package

Package dùng cho riêng một báo cáo thì thêm vào `main.tex`, ngay sau dòng `\usepackage{...}{config/report}`. Package muốn mọi báo cáo dùng template đều có thì thêm vào `report.sty`, ở mục phù hợp và **trước** mục 7 (`hyperref` phải được nạp gần cuối).

Template đã nạp sẵn: `amsmath`, `amssymb`, `graphicx`, `xcolor`, `tikz`, `float`, `subcaption`, `tabularx`, `booktabs`, `multirow`, `enumitem`, `listings`, `tcolorbox`, `hyperref`, `cleveref`, `acro`. Không cần nạp lại các package này.

---

[← Trang trước: Công cụ: build, kiểm tra lỗi, CI](09-cong-cu.md) | [Mục lục](README.md) | [Trang sau: Xử lý lỗi thường gặp →](11-xu-ly-loi.md)
