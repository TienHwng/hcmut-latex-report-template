# Xử lý lỗi thường gặp

**Tiếng Việt** | [English](../en/11-troubleshooting.md)

**Cách đọc lỗi**: trong VS Code, mở tab *Problems* (`Ctrl+Shift+M`); mỗi lỗi có tên file và số dòng, bấm vào để nhảy tới. Trên Overleaf, bấm biểu tượng log cạnh nút *Recompile*.

> [!IMPORTANT]
> Hãy sửa **lỗi đầu tiên** trước: một lỗi thường kéo theo nhiều lỗi khác phía sau.

## Lỗi khi build

### `Undefined control sequence`

Gõ sai tên lệnh (ví dụ `\cfer` thay vì `\cref`), hoặc dùng lệnh của một package chưa được nạp. Kiểm tra dòng mà lỗi chỉ ra.

### `Misplaced alignment tab character &` hoặc `Missing $ inserted`

Trong văn bản có ký tự `&` hoặc `_` chưa được viết thành `\&`, `\_`. Lỗi này hay gặp với tên biến, tên file và URL nằm ngoài `\url{...}`. Xem bảng [ký tự đặc biệt](03-soan-thao.md#ký-tự-đặc-biệt).

### `Runaway argument` hoặc `File ended while scanning`

Thiếu dấu `}` đóng ngoặc. Lỗi thường nằm **trước** dòng được báo. Trong VS Code, đặt con trỏ cạnh `{` để xem dấu đóng tương ứng được tô sáng.

### `Invalid UTF-8 byte sequence`

- Nếu lỗi nằm trong file `.bbl`: tên tác giả người Việt có chữ đầu có dấu bị BibTeX cắt hỏng. Đặt cả họ tên trong hai cặp ngoặc, ví dụ `{{Nguyễn Đức Anh}}` (xem [Trích dẫn](06-tham-chieu-va-trich-dan.md#những-lỗi-hay-gặp-trong-file-bib)).
- Nếu lỗi nằm trong `lstlisting`: code có chữ tiếng Việt có dấu. Bỏ dấu, hoặc viết comment bằng tiếng Anh.
- Còn lại: file không được lưu ở mã UTF-8 (xem mục bên dưới).

### Chữ tiếng Việt bị lỗi hoặc mất dấu

File phải được lưu ở mã **UTF-8**. Trong VS Code, nhìn góc phải dưới: nếu không phải `UTF-8` thì bấm vào đó, chọn *Save with Encoding → UTF-8*. File copy từ Word hoặc từ máy khác hay gặp lỗi này.

### `File '...png' not found`

- Đường dẫn trong `\includegraphics{...}` tính từ thư mục `images/` và không cần đuôi file.
- Kiểm tra chữ hoa/thường: `Chart.png` khác `chart.png` trên Overleaf và GitHub, dù trên Windows thì vẫn chạy.
- Tên file không được có dấu hay khoảng trắng.

### `I can't write on file 'chapters/....aux'`

Bạn đang chạy `pdflatex` trực tiếp. Hãy build bằng `latexmk` hoặc LaTeX Workshop: chúng đã được cấu hình để tạo đủ thư mục con trong `build/`.

### `latexmk` không chạy được trên Windows

Thường do dùng MiKTeX mà chưa có Perl. Cài [Strawberry Perl](https://strawberryperl.com) rồi mở lại VS Code, hoặc chuyển sang TeX Live.

### `Package amsmath Error: Multiple \label's`

Có hai `\label` trong cùng một dòng công thức, thường do quên `\\` giữa các dòng của `align`.

## PDF ra không như mong muốn

### Có `??` hoặc `[?]`

Build thêm một lần nữa. Nếu vẫn còn:

- `??`: tên trong `\cref{...}` không khớp với `\label{...}` nào.
- `[?]`: key trong `\cite{...}` không khớp với entry nào trong `references.bib`, hoặc file `.bib` có lỗi cú pháp. Xem `build/main.blg`.

### Nguồn tham khảo không xuất hiện trong danh sách

Chỉ những nguồn được `\cite` mới được liệt kê. Dùng `\nocite{key}` nếu muốn liệt kê nguồn không trích dẫn trong bài.

### Hình nằm sai chỗ

Dùng `[H]` để đặt hình đúng chỗ trong file nguồn. Xem [Vị trí của hình](04-hinh-va-bang.md#vị-trí-của-hình).

### Bảng hoặc hình tràn ra lề phải

- Bảng: dùng `tabularx` với cột `L` để chữ tự xuống dòng (xem [Bảng có cột chữ dài](04-hinh-va-bang.md#bảng-có-cột-chữ-dài)).
- Hình: đặt `width=\textwidth` hoặc nhỏ hơn.
- URL dài: đặt trong `\url{...}` để nó tự ngắt dòng.

### Khoảng trắng lớn sau dấu chấm giữa câu

LaTeX tưởng dấu chấm của chữ viết tắt là hết câu. Thêm `\` trước khoảng trắng: `e.g.\ ChatGPT`, `AI vs.\ con người`, `Dr.\ Nguyễn`.

### Ghi chú `\todo` không hiện

Ghi chú chỉ hiện ở bản nháp. Thêm `draft` vào dòng `\usepackage` trong `main.tex`.

### Bản nộp vẫn còn chữ DRAFT

Bỏ `draft` khỏi dòng `\usepackage` trong `main.tex` rồi build lại.

### Thiếu chương trong PDF

Dòng `\includeonly{...}` trong `main.tex` chưa được comment lại.

### Danh mục từ viết tắt không xuất hiện, hoặc thiếu từ

Chỉ những từ được dùng bằng `\ac`, `\acs`… mới có trong danh mục. Gõ chữ viết tắt bằng tay thì nó không được tính.

## Lỗi của công cụ

### PDF không cập nhật, hoặc lỗi khó hiểu sau khi đổi nhiều thứ

Xoá file phụ rồi build lại: chạy `latexmk -C` rồi `latexmk`. Trong VS Code thì dùng lệnh *LaTeX Workshop: Clean up auxiliary files*.

### `Ctrl` + click trong PDF không nhảy về code

File `main.synctex.gz` phải nằm cạnh `main.pdf`. Hãy build bằng LaTeX Workshop hoặc `latexmk`, và đừng xoá hay di chuyển file này.

### Build hai lần liên tiếp báo lỗi lạ

VS Code tự build mỗi khi lưu. Nếu bạn đồng thời chạy `latexmk` trong terminal, hai lần build sẽ ghi đè lên nhau trong `build/`. Đợi một lần build xong rồi chạy lại, hoặc tắt build tự động (xem [Công cụ](09-cong-cu.md#latex-workshop-vs-code)).

### Hộp `> [!NOTE]` trong README hiện thành đoạn trích dẫn thường

Trình xem Markdown mặc định của VS Code không hỗ trợ loại hộp này. Mở bằng Markdown Preview Enhanced (`Ctrl+K` `V`); xem [Xem tài liệu Markdown](09-cong-cu.md#xem-tài-liệu-markdown).

## Vẫn không sửa được

1. Đọc lỗi đầu tiên trong `build/main.log` (tìm dòng bắt đầu bằng `!` hoặc có `Error`).
2. Comment tạm đoạn vừa sửa bằng `%` để khoanh vùng: nếu hết lỗi thì lỗi nằm trong đoạn đó.
3. Tìm nguyên văn thông báo lỗi trên [TeX Stack Exchange](https://tex.stackexchange.com).

---

[← Trang trước: Tuỳ biến giao diện](10-tuy-bien.md) | [Mục lục](README.md) | [Trang sau: Tra cứu nhanh →](12-tra-cuu-nhanh.md)
