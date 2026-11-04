# Thông tin báo cáo và trang bìa

**Tiếng Việt** | [English](../en/01-report-info.md)

Mọi thông tin về môn học, đề tài và nhóm nằm trong **một file duy nhất**, `config/metadata.tex`. Template lấy thông tin từ đây để tạo trang bìa, header, footer, các bảng thành viên và thuộc tính của file PDF.

Bạn chỉ sửa thông tin ở `config/metadata.tex`. Mọi chỗ khác dùng thông tin đó (bìa, footer, bảng…) tự cập nhật theo.

## Các trường thông tin

```latex
% --- Trường ---
\university{VIETNAM NATIONAL UNIVERSITY HO CHI MINH CITY}
\school{HO CHI MINH CITY UNIVERSITY OF TECHNOLOGY}
\headertext{University of Technology, Ho Chi Minh City}
\logo{config/assets/hcmut}
\coverbackground{config/assets/background}

% --- Môn học và báo cáo ---
\course{Professional Skill for Engineers}
\semester{252}
\instructor{Dr.\ Nguyễn Văn A}
\title{Tên đề tài}
\city{Ho Chi Minh City}
% \date{April 2026}

% --- Không bắt buộc: bỏ trống thì dòng tương ứng trên bìa tự ẩn ---
\reporttype{ASSIGNMENT REPORT}
\classcode{L01}
\group{5}
```

| Lệnh | In ở đâu | Ghi chú |
| --- | --- | --- |
| `\university`, `\school` | Hai dòng đầu trang bìa | |
| `\headertext` | Header, bên phải logo | |
| `\logo` | Trang bìa và header | Đường dẫn tới ảnh, không cần đuôi file. `\logo{}` để bỏ logo |
| `\coverbackground` | Ảnh nền trang bìa | `\coverbackground{}` để bỏ ảnh nền |
| `\course` | Trang bìa (chữ to nhất), footer, mục *Subject* của PDF | |
| `\semester` | Footer: "Semester 252" / "Học kỳ 252" | |
| `\instructor` | Trang bìa: "Instructor: …" | Viết `Dr.\ Nguyễn` (có `\` sau dấu chấm) để LaTeX không coi dấu chấm là hết câu |
| `\title` | Trang bìa (màu chủ đạo), mục *Title* của PDF | |
| `\city`, `\date` | Dòng cuối trang bìa: "Ho Chi Minh City, April 2026." | Xem [Ngày trên bìa](#ngày-trên-bìa) |
| `\reporttype` | Dòng ngay dưới tên môn | Không bắt buộc |
| `\classcode`, `\group` | "Class: L01 – Group: 5" dưới tên giảng viên | Không bắt buộc. Có thể chỉ đặt một trong hai |

Tiêu đề quá dài có thể tự ngắt dòng. Muốn ngắt ở đúng chỗ thì dùng `\\`, ví dụ `\title{Trí tuệ nhân tạo\\trong nội dung số}`.

## Ngày trên bìa

Khi không có dòng `\date{...}`, bìa tự in **tháng và năm lúc build**, theo ngôn ngữ của báo cáo: "November 2026" hoặc "tháng 11 năm 2026". Nhờ vậy bạn không phải nhớ sửa ngày trước khi nộp.

Muốn cố định ngày (ví dụ ngày thuyết trình), bỏ dấu `%` và tự ghi:

```latex
\date{ngày 15 tháng 12 năm 2026}
```

## Thành viên

Mỗi thành viên được khai báo bằng **một dòng** `\addmember` với 4 thông tin: họ tên, MSSV, công việc và mức độ đóng góp.

```latex
\addmember{Nguyễn Văn An}{2310001}{Viết chương 1, tổng hợp báo cáo}{100\%}
\addmember{Trần Thị Bình}{2310002}{Viết chương 2}{100\%}
\addmember{Lê Hoàng Cường}{2310003}{Viết chương 3 và 4}{90\%}
```

> [!WARNING]
> Dấu `%` phải viết là `\%`. Nếu không, phần còn lại của dòng sẽ bị coi là comment và build báo lỗi.

- Thứ tự các dòng cũng là thứ tự trong mọi bảng. Muốn xếp theo tên hay theo MSSV thì chỉ cần đổi thứ tự các dòng.
- Thêm hoặc bớt thành viên chỉ cần thêm hoặc xoá dòng. Mọi bảng tự cập nhật theo.

Từ danh sách này, template tự tạo:

| Ở đâu | Cột | Lệnh tạo bảng |
| --- | --- | --- |
| Trang bìa | Họ tên, MSSV | `\printstudenttable` (gọi sẵn trong `\makecover`) |
| Trang thành viên | STT, Họ tên, Nhiệm vụ, Mức độ | `\printcontributiontable` |
| Trang thành viên | STT, Họ tên, ô trống để giảng viên đánh giá | `\printassessmenttable` |
| Trang lời cam đoan | STT, Họ tên, MSSV, ô để ký | `\printsignaturetable` |
| Thuộc tính PDF | *Author*: tên mọi thành viên, cách nhau dấu phẩy | Tự động |

## Trang thành viên

`frontmatter/members.tex` gồm hai phần: bảng phân công và bảng đánh giá của giảng viên. Môn nào không cần bảng đánh giá thì xoá ba dòng cuối file:

```latex
\section*{\memberlistname}
\printcontributiontable

\vspace{1cm}                    % <- xoá từ đây
\section*{\assessmentname}
\printassessmenttable           % <- tới đây
```

`\memberlistname` và `\assessmentname` là tiêu đề tự đổi theo ngôn ngữ ("Member List & Workload" / "Danh sách thành viên & phân công"). Bạn có thể thay bằng chữ của mình, ví dụ `\section*{Phân công công việc}`.

## Lời cam đoan

Một số môn yêu cầu trang lời cam đoan có chữ ký của từng thành viên. Trang này đã có sẵn nhưng **đang tắt**. Muốn bật, bỏ dấu `%` ở dòng sau trong `main.tex`:

```latex
\input{frontmatter/declaration}
```

Trang gồm một đoạn cam đoan và bảng ký tên. Đoạn cam đoan có sẵn hai bản tiếng Anh và tiếng Việt, và tự chọn theo option ngôn ngữ. Muốn đổi lời văn thì sửa trực tiếp trong `frontmatter/declaration.tex`:

```latex
\ifreportvietnamese
Chúng em xin cam đoan ...        % bản tiếng Việt
\else
We hereby declare ...            % bản tiếng Anh
\fi
```

## Thứ tự các trang đầu

Thứ tự các trang trước nội dung chính được sắp trong `main.tex`. Có thể đổi chỗ, xoá hoặc thêm trang:

```latex
\makecover                          % trang bìa
\input{frontmatter/members}         % thành viên + đánh giá
% \input{frontmatter/declaration}   % lời cam đoan
\clearpage
{\hypersetup{linkcolor=black}\tableofcontents}   % mục lục
\listoftodos                        % danh sách ghi chú, chỉ có ở bản nháp
\printfrontlists                    % danh sách hình/bảng, từ viết tắt
```

Muốn thêm trang như *Lời cảm ơn*, hãy tạo file `frontmatter/acknowledgements.tex`:

```latex
\clearpage
\section*{Lời cảm ơn}
Nhóm xin chân thành cảm ơn ...
```

rồi thêm `\input{frontmatter/acknowledgements}` vào vị trí mong muốn trong `main.tex`.

Dùng `\section*` (có dấu sao) để trang không được đánh số chương.

---

[← Trang trước: Bắt đầu](00-bat-dau.md) | [Mục lục](README.md) | [Trang sau: Tuỳ chọn của template →](02-tuy-chon.md)
