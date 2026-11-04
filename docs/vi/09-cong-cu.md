# Công cụ: build, kiểm tra lỗi, CI

**Tiếng Việt** | [English](../en/09-tools.md)

## Build

### LaTeX Workshop (VS Code)

Mở **thư mục** template bằng VS Code. Mỗi lần lưu file `.tex`, LaTeX Workshop tự build lại.

| Thao tác | Phím tắt hoặc lệnh |
| --- | --- |
| Build | Lưu file (`Ctrl+S`), hoặc `Ctrl+Alt+B` |
| Xem PDF trong VS Code | `Ctrl+Alt+V` |
| Xem lỗi và cảnh báo | Tab *Problems* (`Ctrl+Shift+M`) |
| Xem log build đầy đủ | Nút *TeX* ở thanh bên trái → *View log messages* |
| Xoá file phụ | `Ctrl+Shift+P` → *LaTeX Workshop: Clean up auxiliary files* |

Không muốn tự build mỗi lần lưu? Mở *Settings* (`Ctrl+,`), tìm `latex-workshop.latex.autoBuild.run` và chọn `never`. Khi đó bạn tự bấm `Ctrl+Alt+B` để build.

### latexmk (terminal)

```sh
latexmk            # build ra main.pdf
latexmk -pvc       # tự build lại mỗi khi lưu file, chạy cho tới khi bấm Ctrl+C
latexmk -c         # xoá file phụ, giữ main.pdf
latexmk -C         # xoá file phụ và cả main.pdf
latexmk -g         # build lại từ đầu dù không có gì thay đổi
```

`latexmk` tự chạy pdfLaTeX và BibTeX đủ số lượt để tham chiếu và trích dẫn ra số đúng.

### Các file được tạo ra

```text
template-latex/
├── main.pdf            # kết quả để nộp
├── main.synctex.gz     # dữ liệu để nhảy code ↔ PDF
└── build/              # mọi file phụ: .aux, .log, .bbl, .toc...
    ├── main.log        # log đầy đủ, xem khi có lỗi
    └── main.blg        # log của BibTeX, xem khi trích dẫn có vấn đề
```

> [!IMPORTANT]
> Cấu hình này nằm trong `.latexmkrc` và `.vscode/settings.json`. Nếu sửa, phải sửa **cả hai** cho khớp. Trên Overleaf thì `.latexmkrc` không ảnh hưởng gì, vì Overleaf tự quản lý thư mục build của nó.

Một bản build tốt **không có cảnh báo nào**. Sau khi build, tab *Problems* nên trống.

### Các file cấu hình khác

| File | Dùng để |
| --- | --- |
| `.latexmkrc` | Cấu hình `latexmk`: PDF ra thư mục gốc, file phụ vào `build/` |
| `.chktexrc` | Luật kiểm tra lỗi của ChkTeX |
| `.editorconfig` | Mã UTF-8 và kiểu thụt lề chung cho mọi editor |
| `.gitignore` | Không đưa `build/` và PDF lên Git |
| `.markdownlint.jsonc` | Luật kiểm tra file Markdown (README, docs) |
| `.vscode/settings.json` | Cấu hình LaTeX Workshop, ChkTeX, LTeX+ |
| `.vscode/extensions.json` | Extension VS Code gợi ý cài |
| `.github/workflows/build.yml` | GitHub Actions: kiểm tra, build PDF, release |
| `AGENTS.md`, `CLAUDE.md` | Hướng dẫn cho trợ lý AI (xem [Bắt đầu](00-bat-dau.md#dùng-cùng-trợ-lý-ai)) |
| `.github/MAINTAINING.md` | Ghi chú cho người bảo trì template; không cần khi viết báo cáo |

## Kiểm tra lỗi định dạng: ChkTeX

ChkTeX tìm các lỗi LaTeX hay gặp, ví dụ thiếu `~` trước `\cite`, sai loại dấu gạch, hoặc khoảng trắng sau dấu chấm của chữ viết tắt.

- **VS Code**: chạy tự động mỗi lần lưu; lỗi hiện thành gạch chân vàng và trong tab *Problems*.
- **Terminal**:

  ```sh
  chktex -q -l .chktexrc main.tex      # không in ra gì nghĩa là sạch
  ```

`.chktexrc` đã tắt sẵn những cảnh báo không phù hợp với template, ví dụ cảnh báo số 46 (đòi viết `\(...\)` thay cho `$...$`, xem [Công thức](05-cong-thuc-va-code.md#trong-dòng-và-đứng-riêng)). Hiếm khi cần tắt cảnh báo cho một dòng cụ thể, nhưng nếu cần thì thêm comment `% chktex 8` (số là mã cảnh báo) ở cuối dòng đó.

## Soát chính tả tiếng Anh: LTeX+

Extension **LTeX+** soát chính tả và ngữ pháp tiếng Anh ngay trong file `.tex`, gạch chân xanh những chỗ nghi ngờ. Đưa chuột vào chỗ gạch chân để xem gợi ý sửa.

- Từ chuyên ngành bị báo sai: chọn *Add to dictionary*. Từ sẽ được lưu vào `ltex.dictionary` trong `.vscode/settings.json`, nên cả nhóm dùng chung.
- Một đoạn tiếng Việt nằm trong bài tiếng Anh thì bọc giữa hai dòng `% LTeX: enabled=false` và `% LTeX: enabled=true`, như trong `frontmatter/declaration.tex`.

LTeX+ **không hỗ trợ tiếng Việt**. Với báo cáo tiếng Việt, nên tắt nó cho đỡ rối: đổi `"ltex.enabled": ["latex"]` thành `"ltex.enabled": false` trong `.vscode/settings.json`.

## Đếm chữ

- **VS Code**: `Ctrl+Shift+P` → *LaTeX Workshop: Count words in LaTeX project*.
- **Terminal**:

  ```sh
  texcount -inc -brief -q main.tex     # số chữ của từng chương và tổng
  ```

- **Overleaf**: *Menu → Word Count*.

Số chữ chỉ tính phần nội dung, không tính lệnh LaTeX và comment.

## Build tự động trên GitHub

Nếu nhóm đưa repo lên GitHub, file `.github/workflows/build.yml` sẽ tự chạy mỗi lần push lên nhánh `main` và mỗi khi có pull request. Nó gồm ba việc chạy song song:

| Job | Làm gì | Khi thất bại |
| --- | --- | --- |
| `lint` | Chạy ChkTeX như trên | Có cảnh báo định dạng. Sửa theo log của job, PDF vẫn được build |
| `docs` | Kiểm tra README và `docs/` bằng markdownlint | File Markdown sai định dạng. Nhóm không cần docs thì xoá job này khỏi `build.yml` |
| `build` | Build `main.pdf` bằng TeX Live đầy đủ | Có lỗi LaTeX. Xem log để biết dòng nào lỗi |

**Tải PDF**: vào tab *Actions* của repo, chọn lần chạy mới nhất, rồi tải file trong mục *Artifacts* (`report-pdf`, dạng ZIP).

**Tạo bản chốt**: gắn tag bắt đầu bằng `v` để GitHub tạo một *Release* có đính kèm PDF, tiện gửi cho giảng viên hoặc lưu bản đã nộp:

```sh
git tag v1.0                 # ví dụ: bản nộp giữa kỳ
git push origin v1.0
```

Không muốn dùng tính năng này thì xoá thư mục `.github/`.

## Xem tài liệu Markdown

README và các trang trong `docs/` dùng **hộp ghi chú** theo cú pháp của GitHub (Obsidian cũng dùng cú pháp này):

```markdown
> [!TIP]
> Nội dung của hộp.
```

Có năm loại: `NOTE`, `TIP`, `IMPORTANT`, `WARNING`, `CAUTION`. Trên GitHub chúng hiển thị thành hộp có màu và biểu tượng. Trình xem Markdown mặc định của VS Code thì chỉ hiện chúng như đoạn trích dẫn bình thường.

Để xem đúng trong VS Code, dùng extension **Markdown Preview Enhanced** (đã có trong danh sách gợi ý của template):

| Thao tác | Phím tắt |
| --- | --- |
| Mở preview bên cạnh | `Ctrl+K` rồi `V` |
| Mở preview thay cho file | `Ctrl+Shift+V` |

Sau khi cài Markdown Preview Enhanced, hai phím tắt trên mở preview của extension thay cho preview mặc định. Ở góc trên bên phải editor sẽ có hai nút preview trông gần giống nhau, một của VS Code và một của extension, nên dùng phím tắt là chắc nhất.

Chỉ dùng năm loại hộp trên. Obsidian còn có thêm `[!info]`, `[!example]`, hộp thu gọn `[!note]-`…, nhưng GitHub không hiểu các loại đó. Hai hộp đứng liền nhau thì cần một dòng `<!-- -->` ở giữa, nếu không chúng bị gộp làm một.

---

[← Trang trước: Làm việc nhóm](08-lam-viec-nhom.md) | [Mục lục](README.md) | [Trang sau: Tuỳ biến giao diện →](10-tuy-bien.md)
