# Thesis

## ToDo

### Introduction
- [ ] Herbicides
	- [ ] Clean up 
	- [ ] Add new literature
- [ ] P450s
- [ ] BM3
- [ ] Protein Engineering

### Screening Fist
- [ ] Introduction
	- [ ] Machine Learning
		- [ ] General Overview
		- [ ] TAPE 
		- [ ] ESM/Transformers 
		- [ ] TAPE 
		- [ ] Biswas and application 
	- [ ] P450 BM3 
		- [ ] UV-Vis spec technique
		- [ ] Notable mutants
		- [ ] BM3 active site
	- [ ] High Throughput Screening 
		- [ ] SBS plates
		- [ ] Automation
- [ ] Methods
	- [ ] Describe Library
	- [ ] Protocol - Less formal, appendix and methods summary
	- [ ] Data Analysis
- [ ] Results
	- [ ] Describe hits, false positives, explain plots 
	- [ ] Sequence generation test
	- [ ] Experiment design test
- [ ] Discussion
	- [ ] Overview of work done
	- [ ] Dissect Library - diversity, colored compounds and out of date compounds
		- [ ] Future - select better set using molport api?
	- [ ] Dissect mutant selection - expected activity
		- [ ] Suggest better, more interesting mutants
	- [ ] Dissect Screening Protocol
		- [ ] Suggest improvements, dmso addition, multidrop, bsa
	- [ ] Dissect Data Analysis
		- [ ] Improvements: database, parralelization, error catching, different curve fit - bayes
	- [ ] Dissect Model
		- [ ] FPR/FNR - sampling
		- [ ] pretraining data set size - TrEMBL
		- [ ] pretraining set filtering - compound / sequence diversity
		- [ ] Validation set - replicas of pretraining?
		- [ ] model architecture - hyperoptimization, chemical embedding
		- [ ] Experiment design - repeat & dropout

### VDE
- [ ] Introduction
	- [ ] Herbicides
	- [ ] P450s
	- [ ] Directed Evolution
	- [ ] Structure-based Design
	- [ ] Protein Structure Prediction
	- [ ] Docking
	- [ ] Sequence optimization
	- [ ] Engineering Problem and Overview of work
- [ ] Methods
	- [ ] Repo guide
	- [ ] `enz`
	- [ ] Score function
	- [ ] Genetic Algorithm
	- [ ] Cloud Deployment
- [ ] Results
	- [ ] Describe data
		- [x] Fitness over time img
		- [ ] Fitness over time text
	- [ ] Converged sequences
		- [x] Fix template sequence logo
		- [x] Map clusters to score img
		- [ ] Map clusters to score text
		- [ ] Re-do conclusions and mutation table
		- [ ] Dock best, figures
	- [ ] Codon Design
- [ ] Discussion
	- [ ] Simulation accuracy
	- [ ] Score Relevance 
	- [ ] Scale
	- [ ] Analysis
	- [ ] Codon Design

