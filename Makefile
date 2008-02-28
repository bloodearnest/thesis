# latex makefile

DVI2PS=dvips -q -Ppdf
BIBTEX=bibtex

SOURCES=$(shell ls *.tex */*.tex)
default: thesis.pdf 

%.pdf: TEX=pdflatex
%.pdf: TARGET=${@:.pdf=}
%.pdf: $(SOURCES)
	$(TEX) ${TARGET}
	$(TEX) ${TARGET}
	$(BIBTEX) $(TARGET)
	$(TEX) ${TARGET}
	$(TEX) ${TARGET}

%.ps: %.dvi
	$(DVI2PS) -o $@ $^

%.dvi: TEX=latex
%.dvi: TARGET=${@:.dvi=}
%.dvi: %.tex
	$(TEX) ${TARGET}
	$(BIBTEX) $(TARGET) || rm -f $(TARGET).dvi # to clean up after a failed latex
	$(TEX) ${TARGET}
	$(TEX) ${TARGET}

tidy:
	$(RM) *.aux *.log */*.aux

clean: tidy
	$(RM) *.dvi *.ps *.pdf *.bbl *.blg

fullclean: clean
	$(RM) *.bak *.toc
