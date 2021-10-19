# Project Aims

## Contents
- [](#)

## Aim
The aim is to design variants of the cytochrome P450 BM3 (Cyp102A1) capable of a non site specific hydroxylation of the herbicide mesotrione.
### Context of Engineering Problem
Wild type BM3 has no detectable activity torwards mesotrione. 
BM3 is well structurally characterised and is a popular target for P450 engineering given its ease of production and tolerance to mutations. 
P450-ligand binding activity is detectable by changes to the P450's UV-visible light profile.
### Proposed Solutions
#### `evo`
Using BM3 structures in the PDB as templates, predict structures of BM3 mutants and dock the target ligand to the active site and score by some criteria. 
Using that process as a fitness function, use a genetic algorithm to optimize the amino acids in the active site. 
The pool of *fit* mutants generated this way informs codon design.
> Mutants care screened for mesotrione activity with LCMS
#### `rio` 
Using a high throughput P450:ligand binding assay, screen multiple BM3 mutants against a large compoud library.
That data can be used to train a sequence ligand specificity model.
That model can be used in design of a BM3 mutant with activity towards an arbitary compound

\bibliography
