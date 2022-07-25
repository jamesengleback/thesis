# Methods

- [**Overview**](#overview)
- [**Virtual Directed Evolution **](#vde)
	- [**Fitness Function **](#sfxn)
	- [**Run Time **](#run)
- [**Scaling to Cloud Infrastructure **](#k8)
- [**enz **](#enz)
- [**ga **](#ga)
- [**Codon Design **](#codons)
	- [**mxn **](#mxn)
- [**Lab Testing **](#lab)
	- [**Lab Techniques**](#labtech)
	- [**Data Analysis **](#analysis)

---------

<h2 id="overview"> Overview </h2>
A system for *in silico* enzyme design which simulates lab-based directed enzyme evolution was devised.
In the system, a genetic algorithm optimises a pool of enzyme sequences towards a pre-defined fitness score based on the outcome of a simulation that tests desired target activity.
The result is a large pool of enzyme mutant sequences, their predicted structure, interaction with the target ligand and assosciated fitness metrics, which can be used to inform downstream nucleotide design for construction.

The simulation is based on protein structure prediction of the mutant and estimation of substrate binding poses via molecular docking.
Simulations are scored by a pre-defined function that relates to desired target activity, which are used by the genetic algorithm to generate a new set of mutants in each iteration. Described in [Virtual Directed Evolution](#vde).


``` mermaid
graph TD
	a[Template sequence] -->|Single sequence| b[Repopulate and mutate] ; 
	b -->|mutant sequences| c[Predict structure] ; 
	c -->|structures| d[Dock ligand] ;
	d -->|poses| e[Score fitness] ; 
	e -->|sequence scores| f[Select fittest] ;
	f -->|mutant sequences| b ;

```

In this project, the system was configured to optimize the BM3 active site to accommodate a desirable binding interaction with mesotrione - `\ref figure`.
The desired pose places the ring carbon C<sub>5</sub> of mesotrione adjacent to the active site heme iron, which was hypothesized to displace the heme coordinated, heme distal water, and initiate the hydroxylation reaction cycle, with carbon C<sub>5</sub> as the hydroxylation target.

!!! figure
	desired binding


### The algorithm
The algorithm proceeded in a of the following steps:

1. Generate initial gene pool of size $n$ from template gene 
2. Loop for $g$ generations:

	2.1 Predict structures for each gene

	2.2 Dock ligand to predicted structure and score 

	2.3 Pick $\frac{n}{4}$ best mutants

	2.4 Randomly cross best mutants to fill population size  and point mutate each

3. Return remaining population.

Below is python-like pseudocode for the process:

```python
def evaluation_fn(gene):
	...
	def predict_structure(gene):
		... 
		return structure
	def dock_and_score(structure):
		...
		return score
	return dock_and_score(predict_structure(gene))

def mutate(pop):
	...
	return mutant_pop

def crossover(pop):
	...
	return mutant_pop

def ga(pop): # list of genes
	for _ in range(N_GENERATIONS):
		scores = map(evaluation_fn, pop)
		best_genes = ... # top scoring
		pop = best_genes.sample(POP_SIZE)
		pop = crossover(pop)
		pop = mutate(pop)
	return pop

pop = ... # list of genes based on template
pop =  ga(pop)

```

The program was was configured to use the P450 BM3 mutant A82F/F87V and its crystal structure `4KEY.pdb` as a template structure and sequence. 
The evaluation function comprised the following steps:

1. Predict structure based on template using side chain repacking via `enz`
2. Dock mesotrione to predicted structure active site using `\ref vina`
3. Score docking results. The score function was based on distance ... 

The score was a function of the C<sub>5</sub> - Heme iron distance of the docked ligand poses and the binding energy score estimated by `vina`.
Two score functions were established for comparison.
The score function $A$ was:

$$
fn(poses) = mean(poses_{affinities} \times log(abs(poses_{distances})))
$$

And score function $B$ was:

$$
fn(poses) = mean(softmax(|poses_{affinities}|) \times poses_{distances})
$$

Which was expressed in python as:

```python
def score_a(distances, affinities):
	# distances  = np.array([...])
	# affinities = np.array([...])
	score = np.mean(distances * affinities)
	return score

def score_b(distances, affinities):
	def softmax(arr):
		e = np.exp(arr - arr.max())
		return e / sum(e)
	score = np.mean(distances * softmax(|affinities|))
	return score
```

Paramaters available to the program were:

- $p$ - Population size
- $n$ - Number of generations
- $s$ - Survival fractrion in each generation,
- $e$ - Exhaustiveness of `vina` docking

For each score function, $A$ and $B$, a linode cloud instance was provisioned (`g6-dedicated-50` - `x86 --` 50 CPU cores and 120GB RAM) to run the program in 8 simultaneous processes with the following parameters:

- $p:$  128
- $n:$  32
- $s:$  $\frac{1}{4}$
- $e:$  16

The processes ran for around 72 hours each yielding 32,786 unique mutants and a cost of 105 GBP.
Experiment $A$ was run with commit hash `bf69d6d8cc077a6f19960845c036d0e65f00fb57` and $B$ with `c47b9ae7573cb22f41aa2deb6e65376a4e9d9833`.

The output data was compressed and uploaded to a linode object storage bucket before the machine was terminated.

For analysis, a seperate cloud instance was provisioned to remotely host a jupyter notebook.
The notebook is [`evo-a-b.ipynb`](evo-a-b.md) and discussed in the [results](results-evo.md) section.

!!! todo
	one more run!!

# Software Development

Several software tools were developed for this work:

- [`enz`](#enz): a python package that provides a simple interface to protein structure-prediction, molecular docking and scoring protein-ligand interactions, using *pyrosetta* `\ref` and *autodock VINA* `\ref` for template-based protein structure prediction and molecular docking respectively. 
- [`ga`](#ga): a python package for composition of custom genetic algorithms.
- [`mxn`](#mxn): a python package that automates primer design for site-directed mutantgenesis.


<h2 id="codons"> Codon Design </h2>
