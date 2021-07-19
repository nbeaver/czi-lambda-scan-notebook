IPYNB :=Plot_CZI_lambda_scan.ipynb
HTML  :=index.html
PY    :=$(patsubst %.ipynb,%.py, $(IPYNB))
PDF   :=$(patsubst %.ipynb,%.pdf, $(IPYNB))

ZIP := plot-czi-lambda-scan.zip

.PHONY: all
all : $(HTML) $(PY) $(PDF)

.PHONY: ipython-notebook
ipython-notebook:
	jupyter notebook

.PHONY: jupyter-notebook
jupyter-notebook:
	jupyter notebook

$(HTML) : $(IPYNB)
	jupyter nbconvert --to html $< --stdout > $@

$(PDF) : $(IPYNB)
	jupyter nbconvert --to pdf $<

$(PY) : $(IPYNB)
	jupyter nbconvert --to script $<


.PHONY: clean
clean :
	rm -f -- $(HTML) $(PY) $(PDF) $(ZIP)

.PHONY: zip
zip : $(ZIP)

.PHONY: $(ZIP)
$(ZIP): Makefile .gitignore $(IPYNB) 2PA_lambda_long.czi
	zip --filesync --quiet $@ $^

# man /usr/share/man/man1/jupyter-nbconvert.1.gz
# https://ipython.org/ipython-doc/dev/notebook/nbconvert.html
