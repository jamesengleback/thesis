# Introduction 

## Contents

- [Project Overview](#projectoverview)
	- [Aim](#aim)
	- [Virtual Directed Evolution](#vde)
	- [Machine Learning-Based Design](#mldesign)
- [Herbicide Resistance Engineering](#herbicideresistanceengineering)
	- [Metabolic Bypassing](#metabolicbypass)
	- [Metabolic Deactivation](#metabolicdeactivation)
	- [Mesotrione: The Target Herbicide ](#mesotrione) 
- [P450s and BM3: The Design Template](#p450s) 
	- [P450s Function, Structure, Evolution](#p450sfn) 
	- [P450 Analytical Techniques](#p450analytical) 
- [Enzyme Design Strategies](#enzymedesign) 
	- [Directed Evolution](#directedevolution) 
	- [Virtual Directed Evolution ](#vde) 
	- [Machine Learning-Based Design ](#mldesign)
- [Open Source and `git`](#git)


------------

<a name="projectoverview" ></a>

## Project Overview 


This project has two peices of work both with the aim to engineer a P450 BM3 mutant with some sort of metabolic activity towards the herbicide mesotrione, ideally hydroxylation at carbon 5. 

One approach uses classical structure prediction and docking combined with a genetic algorithm to generate mutantions with predicted activity. 
Prediction of BM3-mutant binding will be used as a fitness metric in virtual directed evolution experiments. The resulting mutants will be made and tested for predicted activity in the lab. 

The other uses a deep learning model trained on screening data of BM3 mutant binding with herbicide-like compounds, with the aim of being able to predict the activity of any BM3 mutant with any herbicide.
This work involves high-throughput screening of BM3 mutants against herbicide-like compounds.
Mutants resulting from virtual directed evolution experiments using the deep learning model for fitness estimation will be made in the lab and tested for predicted activity. 

<a name="aim" ></a>

### Aim


Mesotrione is an important herbicide whose metabolism in plants is initiated by hydroxylation of carbon 5 by a P450. Given the promiscuity of glutathione-S transferases that help sequester a hydroxylated xenobiotic, alternative hydroxylation sites may be sufficient to initiate herbicide metabolism in plants.
A BM3 mutant that hydroxylates mesotrione at any position may be suitable for engineering mesotrione resistance into a crop. 

<a name="vde"></a>

### Virtual Directed Evolution 

The two approaches developed here are based on traditional structure-based methods and one based on machine learning. 
Both approaches will produce a pool of BM3 variants with predicted binding activity towards mesotrione, for whom $K_d$, $K_{cat}$, $K_M$ and product formation will be measured. 
In this document, this project is referred to as `enz`. 

<a name="mldesign"></a>
  
### Machine Learning-Based Design 

An artificial intelligence-based approach uses a deep neural network to predict the likelihood of binding between input amino acid sequences and chemical smiles and design lab experiments.
The network is trained on data of $K_d$ between 5-10 BM3 mutants and around 100 herbicide-like compounds, and will be used to make $K_d$ predictions for pairs of amino acid sequences and compound. 

The screening data is generated in the lab using a high-throughput UV-Vis assay for measuring $K_d$.

The trained model can estimate $K_d$ rapidly and at scale, and is used for large-scale virtual directed evolution experiments selecting for mesotrione affinity to generate pools of new BM3 mutants to be made in the lab and tested for predicted activity.

Both approaches generate pools of BM3 mutant sequences with predicted binding activity for mesotrione. The lab validation process is:

-  Preparation of expression plasmids will be done using site-directed mutagenesis. Several BM3 mutant plasmids are in stock and can serve as starting points. The search depth of the models will be limited to reduce the number of mutagenesis steps. 
-  Expression of BM3 mutants in E. coli is fairly robust. Two mutants per shaker should yeild sufficient protein for testing. The full length protien will be expressed.
-  Purification by a single Nickel-affinity chromatography step is sufficient to reliably yeild BM3 mutants at a purity suitable for measuring $K_{cat}$, $K_d$, $K_m$ and product formation.
-  Measurement:
	- $K_d$ will be measured by titration of compound into BM3 with UV-Vis measurements. This experiment typically lasts 20 minutes.
	- $K_m$ and $K_{cat}$ will be measured by monitoring NADPH consumption at 340 nm.
	- Product formation will be detected my LCMS of a turnover reaction. Indication of any mesotrione metabolite is the target. Further elucidation is future work.


<a name="herbicideresistanceengineering"></a>

## Herbicide Resistance Engineering

Herbicide resistance can be engineered into crops by introduction of sets of genes that confer metabolic tolerance to a given herbicide. Resistance mechanisms can generally be classed as **1)** A metobolic bybass: the inhibition target of the herbicide is replaced or complemented with a variant that tolerates the herbicide. **2)** Metabolic deactivation: genes are introduced that aid in metabolism and detoxification of the herbicide.

<a name="metabolicbypass"></a>

#### Metabolic Bypassing

An example of a metabolic bypass in engineered crops is glyphosate resistance conferred by introduction of a glyphosate-tolerant EPSP synthase. Glyphosate is a ubiquitous herbicide that targets X_PATHWAY by EPSP inhibition, leading to accumulation of toxic precursors and plant death after 2-3 weeks. XBACTERIA growing near a glyphosate production facility were found in 1995(?) to express an EPSP synthase variant tolerant to glyphosate present in the soil [ref](ref), which was developed into a crop resistance gene by scientists at Monsanto and commercialized under the brand name *Roundup Ready*. *Roundup Ready* crops were the first commercially available herbicide resistant crops and the fastest-adopted technology in the history of agriculture [ref](ref). Since its release, *Roundup Ready* has been introduced into Maize (*Zea mays*), Soy (*Glycine max*), ... , and has cumulative sales worth $X since 1994.

<a name="metabolicdeactivation"></a>

#### Metabolic Deactivation

An example of metobolic deactivation in engineered crops is 2, 4 D

<a name="mesotrione"></a>

### Mesotrione: The Target Herbicide 



<a name="p450s"></a>

## P450s and BM3: The Design Template

cytochrome p450s are a ubiquitous class of enzymes involved in xenobiotic metabolism and can intitiate metobolism of herbicides. bacterial p450s are practical to engineer towards herbicide metabolism and are engineered to metabolise the herbicide ... here. directed evolution is simulated using a genetic algorithm, protein structure prediction and molecular docking. the engineered mutant is confirmed to have target activity towards ... 

<a name="p450sfn"></a>

### P450s Function, Structure, Evolution

<a name="p450analytical"></a>

### P450 Analytical Techniques

<a name="enzymedesign"></a>

## Enzyme Design Strategies

<a name="directedevolution"></a>

### Directed Evolution

<a name="vde"></a>

### Virtual Directed Evolution 

<a name="mldesign"></a>

### Machine Learning-Based Design 


<a name="git"></a>

## Open Source and `git`

------------------------------------
