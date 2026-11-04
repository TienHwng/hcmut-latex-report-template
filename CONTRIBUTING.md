# Đóng góp

Cảm ơn bạn đã muốn góp phần cải thiện template. Issue và pull request bằng tiếng Việt hoặc tiếng Anh đều được. *Issues and pull requests in English are welcome.*

## Báo lỗi hoặc đề xuất

Mở một [issue](https://github.com/tienhwng/hcmut-latex-report-template/issues) và ghi rõ:

- Bạn build bằng gì (Overleaf, TeX Live, MiKTeX) và phiên bản nào.
- Option đang dùng trên dòng `\usepackage` của `main.tex`.
- Thông báo lỗi đầu tiên trong log (`build/main.log`, hoặc log của Overleaf), và đoạn code nhỏ nhất gây ra lỗi.

Trước khi mở issue, xem [Xử lý lỗi thường gặp](docs/vi/11-xu-ly-loi.md); nhiều lỗi đã có cách sửa ở đó.

## Gửi thay đổi

1. Fork repo và tạo một nhánh mới từ `main`.
2. Sửa code. Nếu thay đổi ảnh hưởng tới cách dùng template, cập nhật cả README, `docs/vi/`, `docs/en/` và `AGENTS.md`. Ghi chú kỹ thuật về cách template hoạt động nằm trong [.github/MAINTAINING.md](.github/MAINTAINING.md).
3. Chạy các lệnh kiểm tra dưới đây và bảo đảm không còn lỗi hay cảnh báo.
4. Mở pull request vào `main`, mô tả ngắn thay đổi và lý do.

```sh
latexmk                                            # build: không có cảnh báo trong build/main.log
latexmk zz-test.tex                                # (tuỳ chọn) bản copy của main.tex với [vietnamese]
chktex -q -l .chktexrc main.tex                    # không in ra gì
npx markdownlint-cli2 "*.md" "docs/**/*.md" ".github/*.md"   # 0 issues
```

CI trên GitHub chạy lại các bước kiểm tra này cho mỗi pull request.

## Quy ước

- Mọi chữ cố định mới mà template in ra (trong `config/report.sty`) cần có cả bản tiếng Anh và tiếng Việt.
- Đặt `\label` ngay sau lệnh tạo số, với tiền tố `sec:`, `fig:`, `tab:`, `eq:`, `lst:`, `app:`.
- Dùng màu `primary` và `secondary` thay cho mã màu viết tay.
- Docs viết ngắn gọn, không dùng emoji; mỗi trang tiếng Việt có trang tiếng Anh tương ứng.

## Giấy phép

Khi gửi pull request, bạn đồng ý rằng phần đóng góp của mình được phát hành theo [giấy phép MIT](LICENSE) của dự án.
