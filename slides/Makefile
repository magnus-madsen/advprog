# Builds each deck with XeLaTeX and renders slide 2 as a PNG thumbnail.
# The thumbnails are the "Download Slides" images used by the book (see src/week1.md).

SLIDES := week1 week2 week3

PDFS   := $(SLIDES:%=%.pdf)
THUMBS := $(SLIDES:%=%-02.png)
COMMON := header.tex macro.tex pr-welcome.tex flix.sty oubraces.sty $(wildcard img/*)

.PHONY: all clean
all: $(PDFS) $(THUMBS)

# latexmk reruns XeLaTeX as many times as the table of contents and the
# navigation bar need to settle.
%.pdf: %.tex $(COMMON)
	latexmk -xelatex -halt-on-error -interaction=nonstopmode $<

# -singlefile fixes the output name: without it pdftoppm appends the page
# number, padded differently depending on the poppler version.
%-02.png: %.pdf
	pdftoppm -png -f 2 -l 2 -singlefile $< $*-02

clean:
	latexmk -C
	rm -f $(THUMBS) $(SLIDES:%=%.nav) $(SLIDES:%=%.snm) $(SLIDES:%=%.vrb)
