# latexmk configuration (Perl syntax).
#   latexmk        build main.pdf (re-runs pdflatex/bibtex as needed)
#   latexmk -pvc   rebuild automatically on every save
#   latexmk -c     remove auxiliary files in build/ (keep the PDF)
#   latexmk -C     also remove main.pdf and main.synctex.gz
#
# Output layout:
#   main.pdf, main.synctex.gz   project root (SyncTeX must sit next to the PDF)
#   .aux .log .toc .bbl ...     build/

@default_files = ('main.tex');
$pdf_mode      = 1;           # pdfLaTeX
$out_dir       = '.';         # final files: PDF + SyncTeX
$aux_dir       = 'build';     # everything else
$emulate_aux   = 1;           # TeX Live has no -aux-directory: latexmk compiles
                              # into build/ and then moves the PDF to the root
$bibtex_use    = 2;           # run BibTeX when needed; -C also deletes .bbl
$pdflatex      = 'pdflatex -synctex=1 -interaction=nonstopmode -file-line-error %O %S';

# \include{chapters/foo} writes build/chapters/foo.aux, but pdflatex cannot
# create folders inside its output directory. Mirror every source folder that
# holds .tex files into build/ before compiling.
use File::Find;
use File::Path qw(make_path);
find({ no_chdir => 1, wanted => sub {
  if (-d $_ && m{^\./(\.git|\.vscode|\Q$aux_dir\E)$}) { $File::Find::prune = 1; return; }
  make_path("$aux_dir/$File::Find::dir") if /\.tex$/ && $File::Find::dir ne '.';
} }, '.');
