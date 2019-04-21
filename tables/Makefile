SHELL=/bin/sh

LATEXDIR=".:"

all: makedvi
#all: makedvi  makeps makepdf

makebib:
	( export BIBINPUTS=$(LATEXDIR) ; exec bibtex tables )

makedvi:
	( export TEXINPUTS=$(LATEXDIR) ; exec pdflatex tables )

makeps:
	( export TEXINPUTS=$(LATEXDIR) ; exec dvips -t letter tables.dvi -o tables.ps )

makepdf:
	( export TEXINPUTS=$(LATEXDIR) ; exec ps2pdf13 tables.ps tables.pdf )

clean:
	( rm -f core missfont.log *.bak *~ )
	( rm -f texput.log tables.dvi tables.aux tables.blg tables.log tables.toc tables.ttt tables.fff tables.lot tables.lof )

cleanall: clean
	( rm -f tables.ps tables.bbl tables.pdf)

