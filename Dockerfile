FROM ocaml/opam:ubuntu

WORKDIR /app

COPY src/ src/
COPY dune-project .
COPY LICENSE.txt .
COPY report.pdf .

RUN opam init
RUN opam install ocaml-lsp-server odoc ocamlformat utop
RUN eval $(opam env) && dune build src/miniml