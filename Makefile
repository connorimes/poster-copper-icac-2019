LATEX=latex
BIBTEX=bibtex
DVIPS=dvips
DVIPDF=dvipdf
DVIPDF=dvipdfm
PDFLATEX=pdflatex

FIG-FILES = figures/*.png img/*.tex
TEX-FILES = *.tex
BIB-FILES = *.bib
TOP-LEVEL-ROOT = seec
CRNAME = imes-poster-icac-2019-copper

all: ${TOP-LEVEL-ROOT}.pdf $(CRNAME)

outdir:
	mkdir -p out

${TOP-LEVEL-ROOT}.pdf: outdir ${PDF-FILES} ${TEX-FILES} ${BIB-FILES} ${FIG-FILES}
	$(PDFLATEX) -shell-escape ${TOP-LEVEL-ROOT}
	$(PDFLATEX) -shell-escape ${TOP-LEVEL-ROOT}
	$(BIBTEX) ${TOP-LEVEL-ROOT}
	$(PDFLATEX) -shell-escape ${TOP-LEVEL-ROOT}
	$(PDFLATEX) -shell-escape ${TOP-LEVEL-ROOT}

${CRNAME}: ${TOP-LEVEL-ROOT}.pdf
	gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dEmbedAllFonts=true -sOutputFile=${CRNAME}.pdf -f $(TOP-LEVEL-ROOT).pdf

clean:
	rm -f *.auxlock *-blx.bib *.run.xml *.aux *.bbl *.blg *.log *.dvi *.out *.idx *.bak *~ *.toc *.lof out/*
	rm -f *.pdf
