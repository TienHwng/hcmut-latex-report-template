# Từ viết tắt

**Tiếng Việt** | [English](../en/07-abbreviations.md)

Template tự quản lý từ viết tắt: lần đầu xuất hiện thì in đầy đủ kèm dạng viết tắt, các lần sau chỉ in dạng viết tắt. Trang **danh mục từ viết tắt** cũng được tạo tự động.

## Khai báo

Mỗi từ được khai báo một lần trong `config/abbreviations.tex`:

```latex
% \abbreviation{key}{Dạng ngắn}{Dạng đầy đủ}
\abbreviation{ai}{AI}{Artificial Intelligence}
\abbreviation{genai}{GenAI}{Generative Artificial Intelligence}
\abbreviation{api}{API}{Application Programming Interface}
\abbreviation{hcmut}{HCMUT}{Ho Chi Minh City University of Technology}
\abbreviation{csdl}{CSDL}{cơ sở dữ liệu}
```

- **key** là tên bạn dùng khi viết bài: chữ thường, không dấu, không khoảng trắng. Nó không được in ra.
- **Dạng đầy đủ** viết bằng ngôn ngữ của báo cáo. Có thể viết chữ thường (`cơ sở dữ liệu`) nếu từ đó thường đứng giữa câu.

## Dùng trong bài

| Lệnh | Lần đầu | Các lần sau | Dùng khi |
| --- | --- | --- | --- |
| `\ac{api}` | Application Programming Interface (API) | API | Hầu hết mọi chỗ |
| `\Ac{api}` | Như `\ac`, viết hoa chữ đầu | API | Đầu câu (quan trọng khi dạng đầy đủ viết thường) |
| `\acp{api}` | Application Programming Interfaces (APIs) | APIs | Số nhiều, chỉ dùng cho tiếng Anh |
| `\acs{api}` | API | API | Luôn muốn dạng ngắn, ví dụ trong nhãn in đậm của danh sách |
| `\acl{api}` | Application Programming Interface | Application Programming Interface | Luôn muốn dạng đầy đủ |

Ví dụ:

```latex
\Ac{csdl} của hệ thống được thiết kế theo mô hình quan hệ.   % Cơ sở dữ liệu (CSDL) ...
Mỗi dịch vụ cung cấp một \ac{api} riêng.                     % lần đầu: đầy đủ
Các \ac{api} này giao tiếp qua HTTP.                          % lần sau: API

\begin{itemize}
  \item \textbf{\acs{api}:} lớp giao tiếp giữa các dịch vụ.
\end{itemize}
```

## Chỗ không nên dùng `\ac`

> [!WARNING]
> Trong **tiêu đề chương, mục và caption**, hãy gõ chữ viết tắt bình thường, không dùng `\ac`.

```latex
\section{Ứng dụng của GenAI}\label{sec:genai}          % đúng
\section{Ứng dụng của \ac{genai}}                       % tránh
```

Tiêu đề và caption còn được in lại ở mục lục và danh sách hình/bảng. Nếu dùng `\ac` ở đó, lần xuất hiện "đầu tiên" sẽ rơi vào mục lục, và trong bài chỉ còn dạng viết tắt mà không bao giờ có dạng đầy đủ.

## Danh mục từ viết tắt

- Trang **List of Abbreviations** (Danh mục từ viết tắt) tự xuất hiện sau mục lục khi `config/abbreviations.tex` có ít nhất một từ.
- Chỉ những từ **thực sự được dùng** trong bài (qua `\ac`, `\acs`…) mới có trong danh mục, nên khai báo thừa cũng không sao.
- Danh mục tự sắp theo thứ tự chữ cái.
- Không muốn có trang này thì xoá hoặc comment hết các dòng `\abbreviation`, rồi viết tắt thủ công trong bài.

## Viết tắt kèm dấu chấm

Với những chữ viết tắt thông dụng không cần khai báo như *e.g.*, *i.e.*, *vs.* hay *Dr.*, nhớ thêm `\` trước khoảng trắng phía sau: `e.g.\ ChatGPT`. Xem thêm ở [Soạn thảo văn bản](03-soan-thao.md#dấu-câu).

---

[← Trang trước: Tham chiếu chéo và trích dẫn](06-tham-chieu-va-trich-dan.md) | [Mục lục](README.md) | [Trang sau: Làm việc nhóm →](08-lam-viec-nhom.md)
