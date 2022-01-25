# My Thesis

WIP

### Recently Changed

- [this page](index.md) - updated gantt chart 2022-01-20
- [vde methods](methods-evo.md) - vde runtime 2022-01-20

```mermaid
gantt
	title Thesis Schedule
	%%dateFormat YYYY-MM-DD
	%%axisFormat %Y/%m/%d
	%%axisFormat  %Y-%m-%d

	Deadline 				: milestone deadline 2022-03-30, 1d
	section xmas
	xmas shutdown 				: xmas, 2021-12-20, 2022-01-04

	section VDE
	Trial-Run      				:  crit, done, des2, after 2022-01-17, 2d
	Run      				:  crit, active, after 2022-01-20, 4d
	Analysis 				:  des4, after des2,4d
	Primer Design  				:  des5, after des4, 1d
	Primer Order & Shipping  		:  des6, after des5,  3d
	PCR      				:  des7, after des6,  3d
	PCR Sequencing   			:  des8, after des7,  3d
	Expression   				:  des9, after des8,  7d
	Purificaiton   				:  des10, after des8, 7d
	Titration 				:  des11, after des9, 4d
	Kinetics 				:  des12, after des9, 4d

	section Rio
	Clean echo package 			: rio0, after des4, 4d
	Design Echo Scripts             	: rio1, after des4, 5d
	Screen FDA w/ WT, A82F     	: rio2, after rio1, 7d
	Screen FDA w/ 1YQO, 1YQP   	: rio3, after rio1, 7d
	screen FDA w/ A264E, 1JME(P393H)   : rio4, after rio1, 7d
	Screen FDA w/ 1YQO, 1YQP   	: rio5, after rio1, 7d
	Screen analysis             		: rio6, after rio1, 10d

	Model Assembly              		: rio7, after des5, 19d
	Pre-training data assembly      	: rio8, after des5, 14d
	Model Pre-training          		: rio9, after des5, 19d
	Model Training              		: rio10, after rio6, 4d
	Test Model Mutant Design        	: rio11, after rio10, 4d
	Model Screen Design             	: rio12, after rio10, 4d

	section Writing
	VDE Methods                 		: active, wr1, after xmas, 40d
	VDE Results                 		: wr2, after des2, 40d
	VDE Discussion                 		: wr3, after des4, 40d
	VDE Introduction                 	: wr4, after des9, 40d

	Rio Methods                 		: wr5, after rio0, 28d
	Rio Results                 		: wr6, after rio2, 25d
	Rio Discussion                 		: wr7, after wr2, 28d
	Rio Introduction                 	: wr8, after wr5, 28d

	General Introduction 			: wr9, after wr5, 25d
	Appendix 				: wr10, after wr11, 25d
	Clean & Document Packages 		: wr11, after xmas, 63d

```



[:fontawesome-brands-github: **Project Github Page**](https://github.com/jamesengleback/thesis)

!!! info "help"
	:fontawesome-solid-edit: see [contributing](contributing.md) for info on suggesting edits etc via github

## Overveiw 
I'm structuring this thesis as two independent papers, though some background and methods overlap so these will be shared.
The appendix details the software developed for this work.

### Overlap 
> Files relevant to both papers

- **Motivation** The end goal for both projects is to re-engineer the Cytochrome P450 BM3 to bind to and turnover the herbicide mesotrione. The background information for the engineering context is in 
	- [**Herbicide-Resistance**](herbicide-resistance.md) - background on herbicide resistant crops, their value in food supply chains and approaches to their engineering
	- [**Enzyme Engineering**](intro-enzyme-engineering.md) -  background on approaches to enzyme engineering, including directed evolution, *in-silico* design and machine learning-guided design.
	- [**Cytochrome P450s**](p450s.md) - background on the class of enzyme being re-engineered here. Overveiws evolutionary history and phylogenetics, biological function, structure, biochemical mechanism of action, experimental techniques and applications in biotech.
	- [**BM3**](bm3.md) - background on phylogenetics, mechanism of action, structure, heterologous expression, engineering case studies.
	- [**General Methods**](methods-general.md) - mutageneis, expression and purification



### Paper 1
#### **Working Title**: Virtual Directed Evolution for Cytochrome P450 Engineering
> **Summary:** Simulate directed evoltuion using protein structure prediction, target ligand docking and scoring and a genetic algorithm to generate iteratively better mutants.

- [**Introduction**](intro-evo.md) - motivates engineering context, outlines aim and approach.
	- [**Protein Structure Prediction**](protein-structure-pred.md) - background on template-based design, relevant approaches.
	- [**Docking**](docking.md) - background on ligand docking applications, algorithms and limitations
	- [**Genetic Algorithms**]() - as sequence optimizers
- [**Methods**](methods-evo.md) - vde paramaters & run details, analysis, lab work
- [**Results**](results-evo.md) - docking analysis, evolutionary analysis, lab measured activity
- [**Discussion**](discussion-evo.md) - suitability of products for application, efficacy of technique, proposed improvements

### Paper 2 
#### **Working Title**: Screening Fist - Mapping Cytochrome P450 Substrate Specificity to Sequence with Machine Learning
> **Summary:** Train a machine learning model on P450 BM3 mutant:ligand binding screening data, use model for optimal screening design and to re-design BM3 for herbicide binding.

- [**Introduction**](intro-rio.md) - motivates engineering context, outlines aim and approach.
	- [**Deep Learning**](deep-learning.md) - perceptrons as a base neural unit, deep learning, transformers, evolutionary scale modelling, graph neural networks
	- [**High Throughput Screening**](hts.md) - background on high throughput screening, SBS plate standaerdisation, liquid handling automation, plate readers, applications in biotech, technology readiness level 
- [**Methods**](methods-rio.md) - model architecture, pre-training data, pre-training, lab screening program, training, planning subsequent screens with adaptive learning.
- [**Results**](results-rio.md) - model pre-training accuracy, screening results and analysis, model training & accuracy, adaptive learning.
- [**Discussion**](discussion-rio.md) - suitability of products for application, efficacy of technique, proposed improvements

### Appendix - Software
- [`enz`](enz.md) - a python wrapper for protein structure prediction, molecular docking and its analysis.
- [`plates`](plates.md) - a python utility for automating plate assay analysis
- [`echo`](echo.md) - a python utility for designing custom instructions for Labcyte Echo liquid handlers
- [`cpd`](cpd.md) - a python utility for selecting diverse sets of screening compounds
- [`mxn`](mxn.md) - a python utility for automated primer design for protein site-directed mutageneis
