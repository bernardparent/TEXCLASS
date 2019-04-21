SHELL=/bin/sh

LATEXDIR=".:"

all: makedvi makebib
#all: makedvi makeps makepdf makebib 

makebib:
	( export BIBINPUTS=$(LATEXDIR) ; exec bibtex report )

makedvi:
	( export TEXINPUTS=$(LATEXDIR) ; exec pdflatex report )

makeps:
	( export TEXINPUTS=$(LATEXDIR) ; exec dvips -t letter report.dvi -o report.ps )

makepdf:
	( export TEXINPUTS=$(LATEXDIR) ; exec ps2pdf13 report.ps report.pdf)

clean:
	( rm -f core missfont.log *.bak )
	( rm -f report.dvi report.aux report.blg report.out report.spl report.log report.toc report.ttt report.fff report.lot report.lof *~ )

cleanall: clean
	( rm -f report.pdf report.ps report.bbl )

