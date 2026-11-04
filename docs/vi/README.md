# Tài liệu

**Tiếng Việt** | [English](../en/README.md)

Mỗi trang hướng dẫn một nhóm tính năng của template. Mọi đoạn code ví dụ đều đã được build thử, nên có thể copy vào bài và dùng ngay. Nếu mới dùng lần đầu, bắt đầu từ trang [Bắt đầu](00-bat-dau.md).

## Bắt đầu

| Trang | Nội dung |
| --- | --- |
| [Bắt đầu](00-bat-dau.md) | Cài đặt, tạo báo cáo mới, kiểm tra trước khi nộp |
| [Thông tin báo cáo và trang bìa](01-thong-tin-bao-cao.md) | Môn học, đề tài, giảng viên, ngày, thành viên; các bảng tự sinh; lời cam đoan |
| [Tuỳ chọn của template](02-tuy-chon.md) | `vietnamese`, `draft`, `print`, `lists`; đoạn văn theo ngôn ngữ |

## Viết báo cáo

| Trang | Nội dung |
| --- | --- |
| [Soạn thảo văn bản](03-soan-thao.md) | Chương, mục, phụ lục; đoạn văn, ký tự đặc biệt, danh sách, chú thích, link, hộp nhấn mạnh |
| [Hình và bảng](04-hinh-va-bang.md) | Chèn ảnh, nhiều ảnh cạnh nhau, TikZ; bảng booktabs, gộp ô, tô màu dòng |
| [Công thức và code](05-cong-thuc-va-code.md) | Công thức trong dòng, đánh số, nhiều dòng; đoạn code, nhúng file code |
| [Tham chiếu chéo và trích dẫn](06-tham-chieu-va-trich-dan.md) | `\label`, `\cref`; BibTeX, `\cite` |
| [Từ viết tắt](07-tu-viet-tat.md) | `\abbreviation`, `\ac`, danh mục từ viết tắt |
| [Làm việc nhóm](08-lam-viec-nhom.md) | Ghi chú `\todo`/`\note`, chia file, build từng chương, Git, SyncTeX |

## Công cụ và tham khảo

| Trang | Nội dung |
| --- | --- |
| [Công cụ: build, kiểm tra lỗi, CI](09-cong-cu.md) | `latexmk`, LaTeX Workshop, ChkTeX, LTeX+, đếm chữ, GitHub Actions, xem Markdown |
| [Tuỳ biến giao diện](10-tuy-bien.md) | Logo, màu, cỡ chữ, lề, header/footer, chữ cố định của template |
| [Xử lý lỗi thường gặp](11-xu-ly-loi.md) | Ý nghĩa các thông báo lỗi hay gặp và cách sửa |
| [Tra cứu nhanh](12-tra-cuu-nhanh.md) | Các lệnh và phím tắt hay dùng |

## Quy ước

- Đường dẫn như `main.tex`, `config/metadata.tex` tính từ thư mục gốc của template.
- Trong code LaTeX, phần sau dấu `%` là comment giải thích; không cần gõ theo.
- "Bản nháp" là PDF build với option `draft`; "bản nộp" là PDF build không có `draft`.
- Hộp **Warning** đánh dấu những lỗi dễ mắc. Trong VS Code, các hộp này chỉ hiển thị đúng khi mở bằng Markdown Preview Enhanced (`Ctrl+K` rồi `V`); xem [Xem tài liệu Markdown](09-cong-cu.md#xem-tài-liệu-markdown).
