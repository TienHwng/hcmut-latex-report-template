# Bắt đầu

**Tiếng Việt** | [English](../en/00-getting-started.md)

Trang này đi từ lúc cài đặt tới lúc nộp bài. Nếu chỉ muốn thử template trên Overleaf, xem [Bắt đầu nhanh](../../README.md#bắt-đầu-nhanh) trong README.

## Cài đặt trên máy

| Hệ điều hành | Bộ TeX nên cài | Ghi chú |
| --- | --- | --- |
| Windows | [TeX Live](https://tug.org/texlive/windows.html), file `install-tl-windows.exe` | Đã có sẵn Perl và `latexmk` |
| macOS | [MacTeX](https://tug.org/mactex/) | |
| Ubuntu/Debian | `sudo apt install texlive-full` | |

Nên chọn bản cài **đầy đủ** (scheme *full*, khoảng 5–9 GB) để không bị thiếu package. Cài xong, mở terminal mới và kiểm tra:

```sh
pdflatex --version
latexmk -v
```

Sau đó cài [VS Code](https://code.visualstudio.com) và mở **thư mục** template (*File → Open Folder*). VS Code sẽ gợi ý cài các extension trong `.vscode/extensions.json`; quan trọng nhất là **LaTeX Workshop**.

Nếu dùng **MiKTeX** trên Windows, cần cài thêm [Strawberry Perl](https://strawberryperl.com), nếu không `latexmk` sẽ không chạy được.

## Tạo một báo cáo mới

### Bước 1: Lấy template

Copy cả thư mục template thành thư mục mới cho báo cáo. Nếu dùng Git:

```sh
git clone https://github.com/tienhwng/hcmut-latex-report-template.git ten-bao-cao
```

### Bước 2: Điền thông tin nhóm

Mở `config/metadata.tex` và sửa:

```latex
\course{Professional Skill for Engineers}   % tên môn học
\semester{252}                               % học kỳ, in ở footer
\instructor{Dr.\ Nguyễn Văn A}               % giảng viên
\title{Tên đề tài}

% Mỗi thành viên một dòng: Họ tên, MSSV, Công việc, Mức độ đóng góp
\addmember{Nguyễn Văn An}{2310001}{Viết chương 1, tổng hợp báo cáo}{100\%}
\addmember{Trần Thị Bình}{2310002}{Viết chương 2}{100\%}
```

> [!WARNING]
> Dấu `%` trong mức độ đóng góp phải viết là `\%`. Viết `100%` thì phần còn lại của dòng bị coi là comment và build báo lỗi.

Các trường khác (lớp, nhóm, loại báo cáo, ngày…) xem ở [Thông tin báo cáo và trang bìa](01-thong-tin-bao-cao.md).

### Bước 3: Chọn ngôn ngữ

Báo cáo viết bằng tiếng Việt thì sửa dòng sau trong `main.tex`:

```latex
\usepackage[vietnamese]{config/report}
```

Để nguyên `\usepackage{config/report}` nếu viết tiếng Anh. Option này chỉ đổi phần chữ do template sinh ra (trang bìa, caption, header…); nội dung bạn viết thì giữ nguyên. Các option khác xem ở [Tuỳ chọn của template](02-tuy-chon.md).

### Bước 4: Viết các chương

Mỗi chương là một file trong `chapters/`. Template có sẵn 4 chương ví dụ (`01-introduction` … `04-conclusion`), minh hoạ cách dùng hình, bảng, công thức, code và trích dẫn. Đọc qua rồi thay bằng nội dung của bạn. Thêm, bớt hoặc đổi tên chương thì sửa danh sách `\include` trong `main.tex` (xem [Soạn thảo văn bản](03-soan-thao.md)).

### Bước 5: Thêm tài liệu tham khảo

Thêm nguồn vào `bib/references.bib` và xoá các entry mẫu không dùng (xem [Trích dẫn](06-tham-chieu-va-trich-dan.md#trích-dẫn)).

### Bước 6: Build và nộp

Build, đọc lại PDF, rồi rà theo danh sách ở mục tiếp theo. File nộp là `main.pdf` ở thư mục gốc.

## Dùng cùng trợ lý AI

Nếu nhờ AI (Claude, ChatGPT, Copilot, Cursor…) viết hoặc sửa báo cáo, hãy cho nó đọc file `AGENTS.md` ở thư mục gốc trước. File này chỉ cho AI biết sửa file nào, dùng lệnh nào của template và tránh những lỗi build hay gặp (như dấu `%`, tên tác giả tiếng Việt trong `.bib`). Claude Code, Copilot, Cursor và Codex tự đọc file này khi bạn mở thư mục template; với ChatGPT hay Claude trên web, hãy đính kèm file này cùng các file `.tex` cần sửa.

AI vẫn có thể bịa nguồn tham khảo hoặc số liệu. Kiểm tra lại mọi trích dẫn trước khi nộp.

## Kiểm tra trước khi nộp

- [ ] Dòng `\usepackage` trong `main.tex` **không còn** `draft` (không còn chữ DRAFT và ghi chú).
- [ ] Dòng `\includeonly` đã được comment lại (bản nộp có đủ các chương).
- [ ] PDF không còn `??` (tham chiếu sai) hay `[?]` (trích dẫn sai).
- [ ] Thông tin trong `config/metadata.tex` đúng: tên môn, đề tài, giảng viên, MSSV, ngày.
- [ ] Mọi nguồn tham khảo đều được trích dẫn trong bài.
- [ ] Không còn lỗi trong tab *Problems* của VS Code, hoặc chạy `chktex -q -l .chktexrc main.tex` không in ra gì.
- [ ] Đúng giới hạn số trang/số chữ (xem [Đếm chữ](09-cong-cu.md#đếm-chữ)).
- [ ] Nếu nộp bản in: thêm option `print`.

Gặp lỗi khi build thì xem [Xử lý lỗi thường gặp](11-xu-ly-loi.md).

---

[Mục lục](README.md) | [Trang sau: Thông tin báo cáo và trang bìa →](01-thong-tin-bao-cao.md)
