#!/bin/sh

cat ../docs/overview.md \
	../docs/aims.md \
	../docs/herbicide-resistance.md \
	../docs/mesotrione.md \
	../docs/p450s.md \
	../docs/bm3.md \
	../docs/enzyme-engineering.md \
	../docs/methods-general.md \
	../docs/intro-evo.md \
	../docs/docking.md \
	../docs/protein-structure-pred.md \
	../docs/molecular-dynamics.md \
	../docs/evo-outline.md \
	../docs/methods-evo.md \
	../docs/enz.md \
	../docs/mxn.md \
	../docs/results-evo.md \
	../docs/methods-rio.md \
	../docs/discussion-evo.md \
	../docs/intro-rio.md \
	../docs/hts.md \
	../docs/deep-learning.md \
	../docs/plates.md \
	../docs/echo.md \
	../docs/cpd.md \
	../docs/results-rio.md \
	../docs/rio-outline.md \
	../docs/screening-fist.md \
	../docs/discussion-rio.md \
	../docs/references.md       > thesis.md

pandoc -f markdown -t latex thesis.md > _thesis.tex
./fmt.py > thesis.tex
xelatex thesis.tex
