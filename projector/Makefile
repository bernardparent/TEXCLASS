SHELL=/bin/sh

LATEXDIR=".:"

all: makedvi 
#all: makedvi makeps makepspdf


makedvi:
	( export TEXINPUTS=$(LATEXDIR) ; exec pdflatex --shell-escape slides.tex )

makepdf:
	( export TEXINPUTS=$(LATEXDIR) ; exec dvipdf slides.dvi slides.pdf )

makeps:
	( export TEXINPUTS=$(LATEXDIR) ; exec dvips  slides.dvi -o slides.ps )

makepspdf:
	( export TEXINPUTS=$(LATEXDIR) ; exec ps2pdf13 slides.ps slides.pdf )

clean:
	( rm -f core missfont.log *.bak )
	( rm -f slides.ps slides.dvi slides.aux slides.blg slides.log slides.toc slides.ttt slides.fff slides.lot slides.lof )

cleanall: clean
	( rm -f slides.ps slides-pics.pdf slides.bm slides-short.pdf slides.out slides.oldaux slides.pdf slides.bbl)

