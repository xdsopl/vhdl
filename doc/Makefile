
.PHONY: all
all: quadrature_decoder.pdf

%.pdf: %.tex
	pdflatex $<

.PHONY: clean
clean:
	rm -f *.aux *.log
