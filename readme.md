# thesis
documents, data and packages related to my thesis:

## Engineering P450 BM3 to metabolize herbicides with virtual directed evolution and artificial intelligence

> or something like that

### Abstract

> Herbicide tolerance can be engineered into crops by inserting resistance genes either by metalic inactivation of the herbicide, or providing a metabolic bypass to the herbicide target site.
> Here, mutant variants of the cytochrome P450 BM3 are engineered to ring-hydroxylate the 4-hydroxyphenylpyruvate (HPPD) inhibitor mesotrione using two computational methods:
> **1)** virtual directed evolution using protein structure prediction, molecular docking and a genetic algorithm.
> **2)** machine learning guided design using a model designed to predict ligand binding based on sequence and smiles alone.
> This method uses a transformer and a graph neural network pretrained on enzyme substrate specificity from KEGG (n points) and re-trained on a screening set of several (n) BM3 mutants  binding and a library of FDA-approved drugs.
> Trained model predictions of binding activity towards mesotrione are used to virtually screen BM3 mutant sequences at scale and sequence space search algorithms are compared.
> Promising mutants are made and tested for predicted activity in the wet lab.

-------------------------

It's a bit of lab work and a bit of computer work. Who knows, it might even work.

-------------------------

## repo

- [**write-up**](write-up): writing
- [**evo**](evo): structure-based design for bm3
- [**screening-fist**](https://github.com/jamesengleback/screening-fist): screening data and analysis
- [**rio**](rio): model of sequence:activity
- [**validation**](validation): testing mutants for predicted activity

# packages 

> todo: link to repos

- [**`enz`**](https://github.com/jamesengleback/enz): python module for protein structure structure and molecular docking. uses `pyrosetta` and `vina` with simple interface
- [**`plates`**](https://github.com/jamesengleback/plates): tools for plate data analysis
- [**`echo`**](https://github.com/jamesengleback/echo): tools for echo picklist design 
- [**`mxn`**](https://github.com/jamesengleback/mxn): tools for site-directed mutagenesis primer design 
- [**`cpds`**](cpds): tool for compound diversity sampling and generating quotes from molport using their api
- [**`ga`**](https://github.com/jamesengleback/ga): simple genetic algorithms for use in protein design
- [**`uv`**](https://github.com/jamesengleback/uv): tools for UV-Vis spectroscopy annalysis
- [**`kx`**](https://github.com/jamesengleback/kx): KEGG scraper
