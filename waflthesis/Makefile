SHELL=/bin/sh

LATEXDIR=".:"

all: makedvi makebib
#all: makedvi makeps makebib makepdf

makebib:
	( export BIBINPUTS=$(LATEXDIR) ; exec bibtex thesis )

makedvi:
	( export TEXINPUTS=$(LATEXDIR) ; exec pdflatex thesis )

makeps:
	( export TEXINPUTS=$(LATEXDIR) ; exec dvips -t letter thesis.dvi -o thesis.ps )

makepdf:
	( exec ps2pdf13 thesis.ps thesis.pdf )

clean:
	( rm -f core missfont.log *.bak )
	( rm -f thesis.ps thesis.dvi thesis.aux thesis.blg thesis.log thesis.toc thesis.ttt thesis.fff thesis.lot thesis.lof )

cleanall: clean
	( rm -f thesis.pdf thesis.bbl)

