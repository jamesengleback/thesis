# Outline

## Contents

- **Overview**
- **Protein Structure Prediction Approach**
- **Ligand Docking Approach**
- **Sequence Optimization**
- **Mutant Design**
- **Lab Testing**
-----------
## Overview
In order to engineer a mutant of the P450 BM3 capable of 5-hydroxylation of the herbicide mesotrione, a virtual directed evoltion program was built and deployed.
The program consists of a Darwinian genetic algorithm that iteratively generates a pool of BM3 mutant sequences, predicts their structure based on an experimentally determined structure and evaluates their binding efficacy towards mesotrion by molecular docking. 
In each iteration, the $n$ fittest mutants are used to generate the next mutant pool.
Over several generations BM3 mutants with improved predicted mesotrione binding properties are generated, which are maded and tested for predicted activity in the lab.

## Protein Structure Prediction Approach
## Ligand Docking Approach
## Sequence Optimization
```python
# psuedocode
def evaluate_mutant(mutant):
	...

population_size = ... 
wild_type = 'MTIKEM...'
mutant_pool = [random_point_mutation(wild_type) for _ in population_size]
for _ in range(n_generations):
	scores = map(evaluate_mutant, mutant_pool)
	best_mutants = n_best(scores, n)

```
## Mutant Design
## Lab Testing
