# Abstract

## Common
This thesis develops two enzyme engineering methods.
Both centre around developing a mutant of the bacterial **Cytochrome P450 BM3** to hydroxylate the herbicide **mesotrione** at the $C_5$ position for use in herbicide-resistant crop engineering projects.

The project duration was 4 years and 6 months.
Work was done in the Manchester Institute of Biotechnology under supervision of Prof. Andrew Munro and later Dr. Sam Hay.
The project was funded by the BBSRC iCASE program in partnership with agricultural technology company Syngenta.

---

## Virtual Directed Evolution

Virtual Directed Evolution (VDE) is a program developed to engineer enzymes with target performance in simulation using black box optimization algorithms.
Simulations model an enzyme sequence *fitness* in a user-defined *task* and returns a score.
A black box function optimizer is used to find progressively higher-scoring protein sequences.

In this case, the *task* involves:

1. Protein structure prediction from input sequence (side-chain repacking)
2. Prediction of likely protein-mesotrione binding conformations (molecular docking)
3. Score based on favourability of mesotrione binding and the sequence distance from BM3 template.

The sequence:score information is passed to the optimizer and a new batch of protein sequences is generated and evaluated.
Genetic algorithms and Bayesian optimization are compared as optimization functions.

Once running, the process is fully automated.
Simulations are run in parallel and at scale on cloud infrastructure.
Here, throughput is 10<sup>4</sup> mutants per day on a 60 CPU virtual machine.
A total of 10<sup>5</sup> mutants are virtually screened in this way.
Several methods of generating protein libraries for lab testing are presented.


---

## Screening Fist
Screening Fist is an enzyme-substrate screening operation directed by an learning algorithm.
The screen detects binding activity between a purified enzyme and a compound screening library.

Screening data is passed to an agent to fine tune its internal, pre-trained model of protein function from sequence, which is used to design an array of screening experiments that maximizes expected information gain (EIG).
The end use of the model is to generate useful predictions of protein function from sequence in downstream enzyme engineering tasks.

A high throughput binding assay is developed, including software to automate test design, liquid handling and data analysis.
Five purified BM3 mutants are screened against a chemical library of ~ 900 FDA-approved drugs, some of which share common features with herbicides.

An agent containing a multi-task deep neural network is constructed and trained to functionally annotate an input protein sequence and estimate its likelihood of interacting with a particular compound.

Pre-trained from a custom database of ~ 10<sup>6</sup> annotated protein sequences and their known ligands, the model is retrained on screening data.
EIG is calculated using uncertainties in the models predictions in a sample space of interest.
EIG estimations of candidate experiment designs are combined with experimental costs to optimally design a subsequent screening experiment.
