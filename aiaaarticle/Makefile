SHELL=/bin/sh

LATEXDIR=".:"

all: makedvi makebib
#all: makedvi makeps makepdf makebib 

makebib:
	( export BIBINPUTS=$(LATEXDIR) ; exec bibtex article )

makedvi:
	( export TEXINPUTS=$(LATEXDIR) ; exec pdflatex article )

makeps:
	( export TEXINPUTS=$(LATEXDIR) ; exec dvips -t letter article.dvi -o article.ps )

makepdf:
	( export TEXINPUTS=$(LATEXDIR) ; exec ps2pdf13 article.ps article.pdf)

clean:
	( rm -f core missfont.log *.bak )
	( rm -f article.dvi article.aux article.blg article.out article.spl article.log article.toc article.ttt article.fff article.lot article.ps article.lof *~ )

cleanall: clean
	( rm -f article.pdf  article.bbl )

