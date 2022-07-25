# Introduction

## Abstract

*Screening Fist* is a screening operation used to train a machine
learning model to predict the likelihood of a given enzyme binding to a
given small molecule from sequence. The model is pre-trained on a large
and general dataset of protein and small molecule binding pairs scraped
from several online sources before retraining on the screening data. The
screening data is generated in-house with a high-throughput, custom
developed Cytochrome P450-small molecule binding assay, with which five
P450 BM3 mutants were each screened for binding against 980 drug-like
molecules.

The retrained model can be used for virtual screening of new enzyme
sequences against a specific target molecule, or to query a single
sequence against many prospective small molecule binding partners. It
can also be used to design subsequent rounds of screening based on the
expected information gain of an experimental design.

## Introduction

### Engineering Problem and Context

Herbicide-resistant crops are important for global agriculture because
they mitigate yield losses due to weeds and give farmers extra
flexibility in their herbicide application programs, which is important
to suppress emergence of herbicide-resistant weeds.

Herbicides kill plants by inhibiting key metabolic processes and their
species-specificity is determined by susceptibility of herbicide target
and their ability to metabolize the herbicide. HPPD inhibitors are a key
herbicide class that cause leaf bleaching and death in susceptible
plants. HPPD inhibition disrupts tyrosine catabolism which disrupts
UV-protection via carotenoid production and photosynthetic electron
shuttling via plastoquinone, leading to death by UV damage and radical
toxicity.

Engineering HPPD-inhibitor resistance into plants have used the HPPD and
metabolic enzymes from naturally resistant species like *Avena fatua*.
**note: ref this.** CYP72A1 is a cytochrome P450 that initiates
metabolism of HPPD herbicides by ring hydroxylation at $C_5$ and has
been explored as a means of engineering HPPD herbicide metabolism into
soybean. **Figure [3.1](#mesotrione){reference-type="ref"
reference="mesotrione"}** shows the chemical structure of mesotrione and
its primary metabolite 5-hydroxy mesotrione.

![[\[mesotrione\]]{#mesotrione label="mesotrione"} The HPPD-inhibiting
herbicide mesotrione and its primary metabolite 5-hydroxy mesotrione -
hydroxylated at the $C_5$ position naturally in some plants by
indigenous Cytochrome P450s, priming it for subsequent stages of
detoxification.](img/mesotrione+metabolite.png){#mesotrione
width="\\textwidth"}

![[\[mesotrione\]]{#mesotrione label="mesotrione"} The HPPD-inhibiting
herbicide mesotrione and its primary metabolite 5-hydroxy mesotrione -
hydroxylated at the $C_5$ position naturally in some plants by
indigenous Cytochrome P450s, priming it for subsequent stages of
detoxification.](img/mesotrione+metabolite.png){#mesotrione
width="\\textwidth"}

Cytochrome P450s are a ubiquitous class of heme-dependent
oxidoreductases that are frequently involved in xenobiotic metabolism.
Bacterial P450s have been engineered to catalyse a range of xenobiotic
biotransformations. The bacterial P450 BM3 from *Bacillus megaterium* is
one such bacterial P450 whose structure has been studied extensively
[@munro2002p450].

Notably, BM3 is a popular target for enzyme engineering studies, owing
in part to its extensive documentation, ease of expression and
*evolvability* [@bloom2006protein]. Some examples of BM3 mutants with
altered substrate scope are shown in **Table
[2.4](#bm3_table){reference-type="ref" reference="bm3_table"}** [@wong].

|**Mutant**             |**Substrate scope**                                                                                 |**Structure** 												|
|-----------------------|----------------------------------------------------------------------------------------------------|-----------------------------------------------------------|
|F87A/I263A/(A328I)     |Nootkatone                                                                                          |![image](img/nookatone.png)                                                     |
|A328F                  |Limonene                                                                                            |![image](img/limonene.png)                                                      |
|R47L/Y51F              |Alkylbenzenes (no heteroatoms)                                                                      |![image](img/alkyl-benzene.png)                                                 |
|R47L/F87V/L188Q (LVQ)  |Coumarins                                                                                           |![image](img/coumarin.png)                                                      |
|A74G/F87V/L188Q (GVQ)  |Indole, Lovastatinn, beta-ionine, organophosphates, polyaromatic hydrocarbons, chlorinated dioxins  |![image](img/indole.png)                                                        |

Examples of engineered BM3 Mutants with altered substrate scope [@wong]

The BM3 A82F/F87V mutant has a broad substrate specificity
[@butler2013key], and represents an attractive starting point for
engineering altered substrate scope, however it has no binding activity
towards the HPPD herbicide mesotrione.

### Technologies Used

#### Machine Learning

#### Transfer Learning

Transfer learning is a popular approach to enhancing model accuracy and
involves pretraining the model on a large, general dataset before
transferring to a new task. The effect is a reduction in the number of
samples required to train the model. Pre-training datasets do no
necessarily need to be closely related to the target task, for example:
models initially trained on the CIFAR 100 dataset (containing cars,
animals etc) have been successfully re-tasked on phenotype
identification from microscopy images [@ng2016nuts].

In the domain of protein sequence-based machine learning, thoroughly
pre-trained models are available for generating a neural embedding of a
given protein that can improve sample efficiency in downstream learning
tasks. Generally, these models are large attention-based models trained
*unsupervised* on a large corpus of protein sequences, like the *TrEMBL*
collection of *Uniprot*. In this case, unsupervised training often
entails reconstruction of a distorted or masked protein sequence and is
run on hardware far beyond the budget of this project.

#### The TAPE Benchmark

**note: explain relevance, flesh out**

Tasks Assessing Protein Embeddings [@tape2019] is a benchmark for
comparing numerical representations of protein sequence (learned or
otherwise) on a set of biological learning tasks from different domains
of protein science. It currently contains five tasks:

1.  **Secondary Structure Prediction Task:**

2.  **Structural Contact Prediction Task:**

3.  **Remote Homology Detection:**

4.  **Fluorescent Protein Landscape Prediction:**

5.  **Protein Stability Landscape Prediction:**

Tasks 4 and 5 are most applicable to protein engineering, since they
involve metric prediction from a set of largely similar protein
sequences. The leader boards for performance on these two tasks as of 5
Jun 2022 are:

**Fluorescence:**

| **Ranking**  |**Model**    |**Spearman's rho**  |
| -------------|-------------|--------------------|
| 1\.          |Transformer  |0.68                |
| 2\.          |LSTM         |0.67                |
| 2\.          |Unirep       |0.67                |
| 4\.          |Bepler       |0.33                |
| 5\.          |ResNet       |0.21                |
| 6\.          |One Hot      |0.14                |

Fluorescence TAPE benchmark leader boards 

**Stability:**

| **Ranking** | **Model**    |**Spearman's rho**  |
|-------------|--------------|--------------------|
| 1\.         | Transformer  |0.73                |
| 1\.         | Unirep       |0.73                |
| 1\.         | ResNet       |0.73                |
| 4\.         | LSTM         |0.69                |
| 5\.         | Bepler       |0.64                |
| 6\.         | One Hot      |0.19                |

Stability TAPE benchmark leader boards

**Facebook AI Research - Evolutionary-Scale Modelling** **note: explain
model architecture and purpose, set of pretrained models and
availability**

### Related Work

**note - do:**

-   **biswas**

### Overview of This Work

This project is a proof of concept for a new approach towards enzyme
engineering using machine learning. Broadly speaking, it involves
screening a number of enzyme mutants for activity towards a large number
of compounds of interest. This data is then used to train a machine
learning model to predict the likelihood of activity between a given
protein sequence and small molecule structure. The trained model has two
applications:

1.  Virtually screen a large number of potential protein and small
    molecule candidates for potential activity. These screens can be
    used to explore potential substrate scope of a given protein, or as
    a virtual fitness function for use in virtual directed evolution -
    where a sequence optimization algorithm evaluates sequences against
    a fitness function.

2.  Optimal design of subsequent screening rounds based on the expected
    information gain ($EIG$) of a candidate experimental design.

The specific approach in this project is to screen a local area of
sequence space surrounding the wild-type P450 BM3 against a library of
980 FDA-approved drug compounds. Drugs share chemical properties with
herbicides so are suitable for a proof of concept study.


