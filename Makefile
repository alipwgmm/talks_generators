FIGURES=$(wildcard fig/*.pdf fig/*.png fig/*.jpg)

all: build/main.pdf

build/main.pdf: Makefile src/*.tex $(FIGURES)
	[ -d build ] || mkdir build
	(cd build && TEXINPUTS="../src/:" pdflatex --shell-escape main)
#	(cd build && BSTINPUTS="../src:" BIBINPUTS="../src:" bibtex main)
#	TEXINPUTS="src/:" pdflatex -output-directory=build main

fig/%.pdf: fig/src/%.gp
	gnuplot $<

plot:
	(cd fig && aliroot -l -b -q src/plot.C)

plot_frag:
	(cd fig && aliroot -l -b -q src/plot_frag.C'(0)')
	(cd fig && aliroot -l -b -q src/plot_frag.C'(1)')

dist:
	tar cvfz dist.tgz *.tex *.bib *.cls fig/

arxiv:
	# arxiv requires the processed bbl-file, not the plain bib-file
	tar cvfz arxix.tgz *.tex *.bbl *.cls fig/
