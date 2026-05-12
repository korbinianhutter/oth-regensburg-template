# Generate the template thumbnail from the example document
thumbnail:
    sed 's|#import "@preview/oth-regensburg-thesis:0.1.0": \*|#import "../template/lib.typ": *|; s|bibliography-file: "references.bib"|bibliography-file: "../example/references.bib"|' example/main.typ > example/main.thumbnail.typ
    typst compile example/main.thumbnail.typ thumbnail.png --root . --format png --pages 1
    rm example/main.thumbnail.typ
