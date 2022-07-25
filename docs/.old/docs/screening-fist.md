# Screening

## Contents
- **Overview**
- **Requirements**
- **Assay Development**
- **Protein Production**
- **Compound Selection**
- **Analysis Pipeline**
- **Model Building**
- **Adaptive Learning**

-------

## Overview

Screening Fist is a lab-based enzyme-ligand screening program.
Consisting of a high throughput Cytochrome P450 ligand binding assay, surrounding software tools and a machine learning model, Screening Fist aims to demonstrate a screening program directed by a model.

The model aims to learn enzyme-ligand specificity based on input data of enzyme sequence and ligand SMILES.
Training data only comprises a small subset of chemical and sequence space, so an indication of model prediction uncertainties is essential.
The model uncertainties can be used to design subsequent rounds of screening by estimation of expected information gain ($EIG$) from a candidate experimental design.

In this work one full design iteration of the screening program was completed. 
This includes:

- [ ] Assay Development
	- [ ] Design software
	- [ ] Lab Protocol
	- [ ] Benchmarking
	- [ ] Analysis Software
- [ ] Screening five P450 BM3 mutants against 980 FDA-approved drug compounds
	- [ ] Design, execution and analysis
- [ ] Enzyme data scraping and database construction
- [ ] Machine learning model pretraining and training

``` mermaid
graph TD

a(in-house compounds) --> A(compound screening library) ;
b(machine-selected compounds) --> A ;
A --> B ;
c(purified P450 BM3 mutants) --> B(screening experiment) ;
cc(mutants from literature) --> c ;
d(generated echo picklists) --> B ;
B --> C(Automated data analysis) ; 
C --> D(Database upload) ; 
e(Enzyme-substrate data mining) --> D ;
D -->|Mined enzyme:ligand data| f(model pre-training) ;
f --> E(model training) ;
D -->|screening data| E ; 
E -->|model evaluation| F(Model) ;
F -->|Maximise Expected</br>Information Gain| G(Next experiment design) ;
G --> B ;
F -->|Sequence SMILES pair| H(P450 ligand specificity predictions) ;
```

---

## Aim

The background objective is to engineer a Cytochrome P450 BM3 mutant that can viably perform a Phase I metabolic deactivation of a triketone 4-HPPD herbicide in plants.
Early tests failed to identify a BM3 mutant that binds to mesotrione, a model triketone HPPD herbicide.

With no expectation of success in the background objective, a sub-objective of R&D process development was established.
The sub-objective aims to explore a machine learning-based approach to enzyme design that does not rely on a large number of enzyme sequences using materials available.

The general approach here is to screen a small number of purified proteins against a large number of compounds for activity using a biochemical assay.
That data is used to train a machine learning model to generate activity predictions for given pairs of protein sequences and ligand structural formulae.

One advantage of this approach is that by using a biochemical assay with purified protein, activity measurements have potentially fewer confounding factors than cell-based assays.
Since a major bottleneck in this approach is production of purified protein, a large compound screening set increases the information gained from each protein.

The model is only trained on a small subset of sequence and ligand pairs, so it is essential that prediction uncertainties are indicated at inference.
Model uncertainty information is useful for both protein design and for design of subsequent experiments, where it can be used to estimate the $\text{Expected Information Gain} (EIG)$ of a candidate experiment design.

The expected use case for the model described here is to guide protein design for ligand binding, in conjunction with other property prediction algorithms.

Ability to predict $EIG$ enables a continuous screening operation to map local sequence:ligand affinity space.
Automation of experiment design enables scalability and also makes full automation of the process viable.

---

## Requirements and Objectives

To meet the aims established, an R&D pipeline is required.
The components of the pipeline are:

### Data Collection

The scope of  Data Collection includes lab-based screening and mining of enzyme-ligand data from online databases.
Relevant data indicates presence, absence or some quantity of protein-ligand binding, which can be narrowed by task relevance to sequence space close to BM3 and chemical space close to mesotrione.

Assay data generated here is the most task-relevant.
Mined data is useful for pre-training models before training on assay data, which increases training efficiency significantly.

More concretely, the data collection requirements are:

- **Screening Assay:** A biochemical assay of protein-ligand binding, must be scalable to large experimental designs and tightly coupled to functional activity. The components of this and their requirements are:
	- **Robust Protocol:** A repeatable method that can be adapted to hardware availability. Must be well documented enough to not require "know-how". Must be de-buggable and robust to last minute issues, which should be documented.
	- **Automation tools:** Software to progam lab automation hardware for variable experiment design. Must be reusable and flexible enough to accomodate varied experimental designs. Should parse machine logs for debugging.
	- **Benchmark:** Comparison of assay performance compared to standard techniques. Weaknesses and blindspots should be documented.
	- **Automated Data Analysis:** Software to process raw data to usable and interprable data for database upload. Must be flexible enough for varied experimental designs. Must flag and handle edge cases.

- **Data Scraping:** Enzyme-ligand binding information, priority to sequences similar to BM3 and ligands similar to mesotrione. Size should accomodate a low computational budget.

### Data Management

A major consideration when working at scale. 
Data that should be stored are: raw and processed experimental data and metadata, and partially processed mined data. 
Databases overcome data availability limitations imposed by conventional disk storage and supports increased scale. 
Data *lakes* and *warehouses* are a popular model of data management `\ref`.

A *lake* refers to a dump of raw data, where the availability requirements are low compared to processed data and the storage costs must be low. 
Cloud computing services offer *object storage* as a solution, virtual disk space accessable by authorized clients.

*Warehouses* refers to databases of processed data with high availability, which is essential for flexibly generating custom model training datasets.
The *warehouse* must accomodate the variable data and metadata structures.
The *warehouse*, a database, must be simple to implement.

### Model

The model should predict presence, absence or some quantity of task-relevant enzyme-ligand interaction.
It should train robustly and be evaluated on a held-back subset of processed screening data.

It should also provide an indication of its uncertainty in its predictions, which is essential for both protein design and experimental design via estimating $EIG$. 

It should train efficiently on small datasets and have as cheap virtual hardware costs as viable.
Many instances of the model must be trained so their management is essential.

---

## Assay Development

The assay developed here aims to qualify or better, quantify a ligand-P450 binding interaction whilst remaining robust to unexpected issues at screening time.

### Background

It was based on standard P450 UV-Visible spectroscopy-based methods for quantifying the these interactions via their dissosciation constant ($K_{d}$), in 384 well plate form factor.
The standard spectroscopy method involves titration of a test compound into a cuvette containing a purified Cytochrome P450 (heme domain).
At each compound concentration, a UV-Visible absorbance measurement is taken from the P450-ligand mix between around 200 and 800 nm.
A particular shift in the UV-Visible absorbance trace indicative of ligand binding can be quantified in relation to ligand concentration, which can be used to calculate $K_{d}$ - an affinity metric.
`\ref`

The shift in question is most pronounced between 350 and 450 nm, where with increased concentration of a ligand causes an absorbance peak migration from around 418 to 390 nm.
The migration is quantified by taking the sum of the absolute changes in absorbance at 390 and 418 nm.

!!! todo
	titration figure

### Assay Development

The assay developed here attempts to mimic the standard titration method in 384 well plates, each with several concentrations of each screening compound.
To that, a detectable concentration of a P450 heme domain in a suitable buffer is added to each well.
The primary cost of manual liquid handling to the assay is precision, limiting its usefulness to qualifying binding interactions.
On the other hand, automated liquid handling improves precision enough to enable quantification of binding interactions.

Liquid handling hardware availability varied over the project, the most important capability being accurate dispensing compounds at near nl precision.
This was done using a *Labcyte Echo 550* - a high speed, high precision acoustic liquid handling device and a custom tool to generate dispensing instructions.

A precision bulk liquid dispensing system is best for dispensing protein in buffer and controls in terms of both speed and precision.
In development, a Thermodrop Multi `\ref` was the preferred peice of equipment for this, which in conjunction with acoustic compound dispensing provided the best precision, enabling $K_{d}$ estimation.

In the screening experiments here, the *Labcyte Echo 550* was used to dispense compounds and an electronic multichannel pipette was used to dispense protein and buffer.
The precision is adequate for qualification of binding interactions and low precision estimations of $K_{d}$.


## Protein Selection and Production
## Compound Selection 
## Analysis Pipeline
## Model Building
## Adaptive Learning

