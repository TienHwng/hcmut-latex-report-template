# Làm việc nhóm

**Tiếng Việt** | [English](../en/08-teamwork.md)

## Chia việc theo file

Mỗi chương là một file riêng trong `chapters/`. Nên phân công **mỗi người phụ trách một hoặc vài file**:

- Hai người không sửa cùng một file cùng lúc, nên khi dùng Git hầu như không bị conflict.
- Trên Overleaf, mỗi người mở file của mình; lịch sử thay đổi cho biết ai sửa gì.
- Thông tin chung (`config/metadata.tex`, `config/abbreviations.tex`, `bib/references.bib`) nên giao cho một người tổng hợp. Nếu ai cũng cần thêm vào, mỗi người thêm dòng mới ở **cuối file** để tránh sửa đè lên nhau.

Để tránh trùng nhãn khi nhiều người cùng viết, nên thêm tên chương vào nhãn: `fig:method-pipeline`, `tab:results-cost`.

## Ghi chú cho nhau

Ghi chú được viết thẳng trong file nguồn và chỉ hiện khi build với option `draft` (xem [Tuỳ chọn](02-tuy-chon.md#bản-nháp-draft)):

```latex
\todo{Cần thêm nguồn cho số liệu này}         % ghi chú màu cam bên lề
\todo[inline]{Viết lại đoạn này cho gọn}      % ghi chú chiếm cả bề rộng trang
\note{Có nên đưa bảng này vào phụ lục?}       % ghi chú màu xanh
\note[Bình]{Đã kiểm tra lại số liệu, OK}      % ghi chú màu xanh, có tên người viết
```

- Mọi ghi chú được gom lại ở trang **List of Todos** ngay sau mục lục; bấm vào từng dòng để nhảy tới chỗ ghi chú.
- Ở bản nộp (không có `draft`), mọi ghi chú tự biến mất. Bạn không cần xoá chúng, nhưng nên xử lý hết trước khi nộp.
- Ghi chú bên lề dài quá có thể bị đẩy xuống dưới. Ghi chú dài thì dùng `[inline]`.

Không đặt `\todo` bên trong `\caption`, `\section` hay ô của bảng. Hãy đặt ngay sau chúng.

Muốn tìm mọi ghi chú còn sót trong VS Code: `Ctrl+Shift+F`, tìm `\todo` hoặc `\note`.

## Build riêng chương đang viết

Báo cáo dài thì mỗi lần build mất nhiều thời gian. Trong lúc viết, có thể chỉ build chương của mình bằng cách bỏ `%` ở dòng `\includeonly` trong `main.tex`:

```latex
\includeonly{chapters/02-method}
\includeonly{chapters/02-method,chapters/03-results}    % nhiều chương
```

- Trang bìa, mục lục và các trang đầu vẫn được build; chỉ các chương không có trong danh sách bị bỏ qua.
- Số trang, số hình và tham chiếu tới các chương khác vẫn đúng, vì LaTeX dùng lại thông tin từ lần build đầy đủ gần nhất.
- Cách này chỉ dùng được với các phần được gọi bằng `\include`, tức là các chương và phụ lục.

> [!IMPORTANT]
> **Nhớ comment lại** dòng `\includeonly` trước khi build bản nộp, nếu không PDF sẽ thiếu chương.

## Nhảy giữa code và PDF (SyncTeX)

Trong VS Code với LaTeX Workshop:

| Thao tác | Kết quả |
| --- | --- |
| `Ctrl` + click vào chữ trong PDF | Mở file nguồn tại dòng tương ứng |
| `Ctrl+Alt+J` trong file nguồn | PDF cuộn tới đoạn đang sửa |

Overleaf có tính năng tương tự: bấm đúp vào PDF, hoặc dùng nút mũi tên giữa hai khung.

Tính năng này cần file `main.synctex.gz` nằm cạnh `main.pdf`; build bằng `latexmk` hoặc LaTeX Workshop sẽ tự tạo file đó.

## Dùng Git

Thư mục đã có sẵn `.gitignore`, nên các file phụ trong `build/` và file PDF không bị đưa lên repo.

Quy trình gợi ý cho nhóm:

```sh
git pull                              # lấy bản mới nhất trước khi viết
# ... viết chương của mình ...
git add chapters/02-method.tex
git commit -m "Viết mục 2.1 Thu thập dữ liệu"
git pull                              # gộp thay đổi của bạn khác
git push
```

- Commit thường xuyên với mô tả rõ ràng.
- Viết mỗi câu một dòng trong file `.tex`. LaTeX vẫn in thành đoạn văn bình thường, còn Git sẽ chỉ ra chính xác câu nào bị sửa, và conflict (nếu có) cũng nhỏ hơn.
- Nếu nhóm đưa repo lên GitHub, mỗi lần push sẽ tự build PDF (xem [CI trên GitHub](09-cong-cu.md#build-tự-động-trên-github)).

## Overleaf và Git cùng lúc

Overleaf bản trả phí có thể đồng bộ với GitHub (*Menu → Sync → GitHub*). Bản miễn phí thì có thể tải ZIP từ Overleaf rồi commit, hoặc ngược lại tải ZIP từ GitHub lên Overleaf như ở [Bắt đầu nhanh](../../README.md#bắt-đầu-nhanh).

Nhóm nên thống nhất chọn **một nơi** làm bản chính (Overleaf hoặc Git) để tránh hai bản lệch nhau.

---

[← Trang trước: Từ viết tắt](07-tu-viet-tat.md) | [Mục lục](README.md) | [Trang sau: Công cụ: build, kiểm tra lỗi, CI →](09-cong-cu.md)
