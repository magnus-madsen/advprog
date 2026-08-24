# Builds each deck with XeLaTeX and renders slide 2 as a PNG thumbnail.
# The thumbnails are the "Download Slides" images used by the book (see src/week1.md).

SLIDES := week1 week2 week3
TYPST  := welcome

PDFS   := $(SLIDES:%=%.pdf) $(TYPST:%=%.pdf)
THUMBS := $(SLIDES:%=%-02.png)
COMMON := header.tex macro.tex pr-welcome.tex flix.sty oubraces.sty $(wildcard img/*)

.PHONY: all clean
all: $(PDFS) $(THUMBS)

# XeLaTeX runs twice so the table of contents and the navigation bar settle.
%.pdf: %.tex $(COMMON)
	xelatex -halt-on-error -interaction=nonstopmode $<
	xelatex -halt-on-error -interaction=nonstopmode $<

# Typst decks are self-contained. Note that the first build needs network
# access: touying is fetched from the package registry into the local cache.
%.pdf: %.typ
	typst compile $<

# -singlefile fixes the output name: without it pdftoppm appends the page
# number, padded differently depending on the poppler version.
%-02.png: %.pdf
	pdftoppm -png -f 2 -l 2 -singlefile $< $*-02

clean:
	rm -f $(PDFS) $(THUMBS) \
	      $(SLIDES:%=%.aux) $(SLIDES:%=%.log) $(SLIDES:%=%.nav) \
	      $(SLIDES:%=%.out) $(SLIDES:%=%.snm) $(SLIDES:%=%.toc) \
	      $(SLIDES:%=%.vrb) $(SLIDES:%=%.xdv) \
	      $(SLIDES:%=%.fls) $(SLIDES:%=%.fdb_latexmk)
