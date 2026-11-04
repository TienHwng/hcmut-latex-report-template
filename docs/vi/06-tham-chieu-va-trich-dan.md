# Tham chiếu chéo và trích dẫn

**Tiếng Việt** | [English](../en/06-cross-references-and-citations.md)

## Tham chiếu chéo

### Gắn nhãn

Mọi thứ được đánh số đều có thể gắn nhãn bằng `\label{...}`. Đặt `\label` **ngay sau** lệnh tạo số, trên cùng dòng:

```latex
\section{Phương pháp}\label{sec:method}
\caption{Kiến trúc hệ thống}\label{fig:architecture}
\caption{Kết quả thử nghiệm}\label{tab:results}
\begin{equation} S = \sum w_i s_i \label{eq:score} \end{equation}
\begin{lstlisting}[caption={...}, label={lst:score}]
```

> [!WARNING]
> Nếu `\label` đặt **trước** `\caption`, nó sẽ lấy số của chương chứ không phải số của hình.

Nhãn dùng tiền tố cho biết loại đối tượng. Nhờ vậy, khi gõ `\cref{fig:` bạn chỉ thấy danh sách các hình:

| Tiền tố | Dùng cho | Ví dụ |
| --- | --- | --- |
| `sec:` | Chương, mục | `sec:method`, `sec:data-collection` |
| `fig:` | Hình | `fig:architecture` |
| `tab:` | Bảng | `tab:results` |
| `eq:` | Công thức | `eq:score` |
| `lst:` | Đoạn code | `lst:score` |
| `app:` | Phụ lục | `app:survey` |

Nhãn chỉ dùng chữ thường không dấu, số và dấu `-`. Mỗi nhãn chỉ được dùng một lần trong cả báo cáo; khi nhiều người cùng viết, nên thêm tên chương vào nhãn (`fig:method-pipeline`) để tránh trùng.

### Tham chiếu

```latex
Như minh hoạ trong \cref{fig:architecture}, ...
\Cref{sec:method} trình bày ...
Kết quả ở \cref{tab:results,tab:cost} cho thấy ...
Chi tiết bảng hỏi xem tại \cref{app:survey}.
```

| Viết | Báo cáo tiếng Anh | Báo cáo tiếng Việt |
| --- | --- | --- |
| `\cref{fig:architecture}` | Figure 2.1 | Hình 2.1 |
| `\cref{sec:method}` | Section 2 | Mục 2 |
| `\cref{eq:score}` | Equation (2.1) | Công thức (2.1) |
| `\cref{tab:results,tab:cost}` | Tables 3.1 and 3.2 | Bảng 3.1 và 3.2 |
| `\cref{app:survey}` | Appendix A | Phụ lục A |
| `\pageref{fig:architecture}` | 5 (số trang) | 5 |

- `\cref` tự thêm chữ "Figure"/"Hình", nên **đừng** viết `Hình \cref{...}`.
- `\Cref` dùng ở đầu câu. Template đã viết hoa sẵn cả hai, nên trong thực tế chúng in giống nhau.
- Chữ in ra là link: bấm vào sẽ nhảy tới hình, bảng hay mục đó.

**Đừng gõ tay** "Bảng 3.1": thêm hoặc bớt một bảng là số sai ngay, còn `\cref` tự cập nhật.

### Giữ nguyên cách gọi của đề bài

Khi đề bài đặt tên riêng cho một phần, ví dụ "Stage 3" hay "Giai đoạn 3", và bạn muốn giữ đúng chữ đó nhưng vẫn có link, hãy dùng `\hyperref`:

```latex
Kết quả của \hyperref[sec:stage3]{Giai đoạn~3} được dùng ở ...
```

### Khi thấy `??`

LaTeX cần chạy hai lượt: lượt đầu ghi lại số của từng nhãn, lượt sau mới in số. `latexmk` và LaTeX Workshop tự chạy đủ lượt. Nếu build xong vẫn còn `??`, nghĩa là tên nhãn bị gõ sai hoặc chưa có `\label` đó. Mở tab *Problems* trong VS Code để xem dòng có cảnh báo `Reference ... undefined`.

## Trích dẫn

### Thêm nguồn vào `bib/references.bib`

Mỗi nguồn là một entry BibTeX.

Cách nhanh nhất: tìm bài trên [Google Scholar](https://scholar.google.com), bấm **Cite → BibTeX** rồi copy vào file. Với sách và bài báo có DOI, có thể dán DOI vào [doi2bib](https://www.doi2bib.org).

```bibtex
@article{chesney2019,
  author  = {Chesney, Robert and Citron, Danielle Keats},
  title   = {Deep Fakes: A Looming Challenge for Privacy, Democracy, and National Security},
  journal = {California Law Review},
  volume  = {107},
  pages   = {1753--1820},
  year    = {2019}
}

@book{collingridge1980,
  author    = {Collingridge, David},
  title     = {The Social Control of Technology},
  publisher = {St. Martin's Press},
  address   = {New York},
  year      = {1980}
}

@inproceedings{rombach2022,
  author    = {Rombach, Robin and Blattmann, Andreas and Lorenz, Dominik and Esser, Patrick and Ommer, Bj{\"o}rn},
  title     = {High-Resolution Image Synthesis with Latent Diffusion Models},
  booktitle = {Proc. IEEE/CVF Conf. Computer Vision and Pattern Recognition (CVPR)},
  pages     = {10684--10695},
  year      = {2022}
}

@misc{acm,
  author       = {{Association for Computing Machinery}},
  title        = {{ACM} Code of Ethics and Professional Conduct},
  year         = {2018},
  howpublished = {\url{https://www.acm.org/code-of-ethics}},
  note         = {Accessed: Apr. 16, 2026}
}
```

| Loại | Dùng cho |
| --- | --- |
| `@article` | Bài báo trên tạp chí |
| `@inproceedings` | Bài báo hội nghị |
| `@book` | Sách |
| `@misc` | Trang web, báo cáo của tổ chức, video, tài liệu khác |
| `@techreport` | Báo cáo kỹ thuật |
| `@phdthesis`, `@mastersthesis` | Luận án, luận văn |

### Những lỗi hay gặp trong file `.bib`

- **Tác giả là tổ chức** phải đặt trong **hai cặp ngoặc**: `{{Association for Computing Machinery}}`. Nếu chỉ một cặp, BibTeX coi đó là tên một người, lấy "Machinery" làm họ và in ra "A. for Computing Machinery".
- **Nhiều tác giả** cách nhau bằng `and`, không dùng dấu phẩy: `Smith, John and {{Trần Thị Bình}}`.
- **Chữ viết hoa trong tiêu đề** như tên riêng hay từ viết tắt có thể bị kiểu IEEE đổi thành chữ thường. Bọc chúng trong ngoặc để giữ nguyên: `{ACM}`, `{Python}`, `{Việt Nam}`.
- **Ký tự đặc biệt** như `&` và `%` trong tiêu đề vẫn phải viết thành `\&`, `\%`.
- Mỗi entry phải có **key khác nhau** (từ đầu tiên sau `{`).

> [!WARNING]
> **Tác giả người Việt** phải đặt trong hai cặp ngoặc: `{{Nguyễn Đức Anh}}`. Khi đó tên được in đầy đủ, đúng thói quen trích dẫn tên Việt. Nếu viết kiểu nước ngoài `Nguyễn, Đức Anh`, kiểu IEEE sẽ rút tên thành chữ cái đầu ("Đ. A. Nguyễn"); với chữ đầu có dấu (Đ, Á, Ô, Ư…), BibTeX cắt hỏng ký tự đó và build báo lỗi `Invalid UTF-8 byte sequence`.

### Trích dẫn trong bài

```latex
Theo Bộ quy tắc đạo đức của ACM~\cite{acm}, ...
Nhiều nghiên cứu đã chỉ ra điều này~\cite{chesney2019,rombach2022}.
```

- Dấu `~` giữ số trích dẫn `[1]` luôn nằm cùng dòng với chữ đứng trước.
- Trích dẫn nhiều nguồn cùng lúc: các key cách nhau bằng dấu phẩy, ví dụ `\cite{a,b,c}`, in ra `[1]–[3]`.
- Trong VS Code, gõ `\cite{` thì danh sách nguồn trong `references.bib` sẽ hiện ra để chọn.

### Danh sách tài liệu tham khảo

- Danh sách theo chuẩn **IEEE**, đánh số theo **thứ tự trích dẫn lần đầu** trong bài, và tự xuất hiện trước phụ lục.
- Chỉ những nguồn được `\cite` mới có trong danh sách, nên trong `.bib` có thừa entry cũng không sao. Muốn đưa vào danh sách một nguồn không trích dẫn trong bài thì thêm `\nocite{key}` ở bất kỳ đâu.
- Thấy `[?]` trong PDF là key trong `\cite` không khớp với key nào trong `.bib`. Kiểm tra lỗi chính tả, hoặc xem file `build/main.blg` để biết entry nào có vấn đề.

---

[← Trang trước: Công thức và code](05-cong-thuc-va-code.md) | [Mục lục](README.md) | [Trang sau: Từ viết tắt →](07-tu-viet-tat.md)
