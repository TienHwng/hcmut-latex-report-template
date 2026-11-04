# Tra cứu nhanh

**Tiếng Việt** | [English](../en/12-cheat-sheet.md)

Các lệnh hay dùng nhất, kèm link tới trang hướng dẫn chi tiết.

| Muốn | Viết | Chi tiết |
| --- | --- | --- |
| Chương mới | `\section{Tên}\label{sec:ten}` | [Soạn thảo](03-soan-thao.md#chương-mục-và-mục-con) |
| Thuật ngữ quan trọng | `\term{...}` | [Soạn thảo](03-soan-thao.md#định-dạng-chữ) |
| Ký tự `% & _ #` | `\% \& \_ \#` | [Soạn thảo](03-soan-thao.md#ký-tự-đặc-biệt) |
| Chèn hình | `\includegraphics[width=0.8\textwidth]{ten-file}` | [Hình](04-hinh-va-bang.md#chèn-một-ảnh) |
| Bảng | `tabularx` + `\toprule \midrule \bottomrule` | [Bảng](04-hinh-va-bang.md#bảng) |
| Công thức trong dòng | `$E = mc^2$` | [Công thức](05-cong-thuc-va-code.md#trong-dòng-và-đứng-riêng) |
| Công thức có số | `\begin{equation} ... \label{eq:ten} \end{equation}` | [Công thức](05-cong-thuc-va-code.md#công-thức) |
| Đoạn code | `\begin{lstlisting}[language=Python, caption={...}]` | [Code](05-cong-thuc-va-code.md#code) |
| Tham chiếu | `\cref{fig:ten}` → "Hình 2.1" | [Tham chiếu](06-tham-chieu-va-trich-dan.md#tham-chiếu-chéo) |
| Trích dẫn | `văn bản~\cite{key}` → "văn bản [1]" | [Trích dẫn](06-tham-chieu-va-trich-dan.md#trích-dẫn) |
| Từ viết tắt | `\ac{key}` | [Từ viết tắt](07-tu-viet-tat.md) |
| Hộp nhấn mạnh | `\begin{keybox}{Tiêu đề} ... \end{keybox}` | [Soạn thảo](03-soan-thao.md#hộp-nhấn-mạnh) |
| Ghi chú cho nhóm | `\todo{...}`, `\note[Tên]{...}` | [Làm việc nhóm](08-lam-viec-nhom.md#ghi-chú-cho-nhau) |
| Đoạn văn theo ngôn ngữ | `\ifreportvietnamese ... \else ... \fi` | [Tuỳ chọn](02-tuy-chon.md#viết-một-đoạn-khác-nhau-theo-ngôn-ngữ) |

## Phím tắt trong VS Code

| Thao tác | Phím tắt |
| --- | --- |
| Build | `Ctrl+S` (lưu file) hoặc `Ctrl+Alt+B` |
| Xem PDF | `Ctrl+Alt+V` |
| Nhảy từ code tới PDF | `Ctrl+Alt+J` |
| Nhảy từ PDF về code | `Ctrl` + click vào PDF |
| Xem lỗi | `Ctrl+Shift+M` |
| Xem file Markdown (README, docs) | `Ctrl+K` rồi `V` |

---

[← Trang trước: Xử lý lỗi thường gặp](11-xu-ly-loi.md) | [Mục lục](README.md)
