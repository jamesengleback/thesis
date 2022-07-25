# Methods

The project was operated as a `git` repository which can be found at:

<https://github.com/jamesengleback/vde>. The structure of the directory
is:

-   **docs/:** write up for this document and markdown documentation

-   **nb/:** jupyter notebooks used for data analysis

-   **scripts/:** scripts to create and configure cloud machines to run
    algorithm on

-   **vde/:** the vde algorithm configured to optimize BM3 for desirable
    mesotrione binding

This section details the implementation of this project:

-   The project is dependent on a `python` package `enz`, developed here
    for protein structure prediction and molecular docking to predict
    the behaviour of mutants; described in `enz`

-   A score function that attempts to predict the likelihood of a $C_5$
    hydroxylation of mesotrione is described in section **Score**

Given the aim of engineering a BM3 mutant capable of $C_5$ hydroxylation
of mesotrione, and given that likelihood of electron transfer is
proportional to $\frac{1}{d^6}$ [@moser2008distance], the objective of
the score function is to select for mutants that promote a mesotrione
binding conformation where $C_5$ is close to the heme iron with a high
affinity. The $C_5$-heme iron distance is noted as $d$ measured in Å.
Poses with a low $d$ should also be stably held with a low $\Delta G$,
which is estimated for each pose by *VINA*.

For a set of mutant-bound poses of mesotrione, their collective score
could be:

$$score = \frac{1}{n} \sum^{n}_{i\in n} \Delta G_{i} \times d_i$$

Another important factor in the score function is the *Hamming Distance*
$h$ between the sequence of the mutant being scored and the template
sequence. Low $h$ can make DNA synthesis by a set of site directed
mutagenesis reactions possible, or reduce the size of degenerate codon
libraries by reducing the number of mutation sites. A low $h$ is also
important here because the structure prediction is purely template-based
and a high $h$ could result in a very different structure in actuality.
So $h$ was added to the score function, which became score function $A$
to be used in experiment $A$ (equation
[\[scorea\]](#scorea)).

$$score = \frac{1}{n} \sum^{n}_{i\in n} d - \log{|\Delta G_{i}|} - h$$

Low $\Delta G$ poses represent those more likely to occur, so their $d$
should be weighted according to $\Delta G$.

The heuristic currently employed to estimate the desirability of each
set of $m$ docking results is described in equation
[\[scoreeqn\]](#scoreeqn):
$$\label{scoreeqn}
    score = \frac{1}{n}\sum^{n}_{i\in m} \Delta G_{i} \times d_{i}$$
where $\Delta G$ is a free energy estimation of the interaction
calculated by *Autodock VINA* (given in *kcal/mol*) and $d$ is the
distance between the heme iron and the $C_{5}$ of mesotrione for each of
$m$ binding poses **(figure [3.2](#score))**.

Distance $d$ between carbon $C_5$
of mesotrione and the heme iron of BM3, used in the fitness score (Å)
marked by a yellow dashed line.
![](img/score.png)

### Genetic Algorithm 

A simple genetic algorithm *(GA)* was used for sequence optimization
during *VDE*. The *GA* was implemented in pure `python` and its built-in
modules.

In this case, the *GA* repeated the following steps in each iteration:

1.  **Initialize mutant population:** From the template sequence,
    generate $p$ mutants each with one random point mutation.

2.  **For $n$ Iterations:**

    1.  **Evaluate *fitness* of each mutant:[\[gaeval\]]{#gaeval
        label="gaeval"}** Using multiprocessing, evaluate the score for
        each mutant in parallel, returning a mapping of sequences to
        respective scores.

    2.  **Select for best $\frac{1}{m}$ mutants:** where $\frac{1}{m}$
        is the survival rate in each iteration.

    3.  **Repopulate gene pool by crossover and point mutation of
        selected mutants:** where two random members of the surviving
        mutants $a$ and $b$ are crossed by recombining sequences at a
        random cut point and introducing additional random point
        mutation. Repeat $p$ times.

 

$genePool_i := mutate(sequence)$ $fitness_j := fn(mutant_j)$
$genePool := nlargest(fitness,  n_{survivors}))$
$newGenePool_i := mutate(crossover(genePool_{random}, genePool_{random}))$
$genePool := newGenePool$

Algorithm [\[pseudocode\]](#pseudocode) is implemented in `python` in the file
`vde/ga.py` and makes use of multiprocessing to parallelise evaluations
of a function.

### Main Function 

The program in `vde/main.py` executes the main functionality of *VDE*.
It executes iterations of the genetic algorithm
[\[ga\]](#ga) where the evaluation
function for a $sequence$ is:

structure = map\_refold(sequence, pdb=`4KEY.pdb`) docking poses =
dock(structure, mesotrione) fitness = score(docking poses) **Return**
fitness

Two instances of the *VDE* program were run, each with a different score
function and labeled $A$ and $B$. The score function for $A$ was as in
equation [\[scorea\]](#scorea):

$$\label{scorea}
    fn_A(a, d, h) = d - \log{|a|} - h$$

Where variables as in section
[\[scorefn\]](#scorefn). The
score function for $B$ is described in equation
[\[scoreb\]](#scoreb):

$$\label{scoreb}
    fn_B(a, d, h) = (\frac{1}{n} \sum_{n}^{i} softmax(\log{|a|}_i)\times d_i) -  h$$

Asides from the differing score functions, the two experiments were set
up to be run with the configuration in table
[3.1](#config):

| **Parameter**           |**Value** 														|
|------------------------|---------------------------------------------------------------------------------------------------------------------|
| Template Structure      |*4KEY* [@butler2013key]                                                                                              |
| Mutation Sites          |47, 49, 51, 75, 78, 88, 94, 138, 142, 175, 178, 184, 188, 205, 226, 252, 255, 260, 263, 290, 295, 328, 330, 350, 353 |
| Population Size         |128                                                                                                                  |
| Survival Rate           |$\frac{1}{4}$                                                                                                        |
| Docking Exhaustiveness  |16                                                                                                                   |
| Number of Generations   |32                                                                                                                   |
| Number of Repeats       |8                                                                                                                    |


-   The *Mutation Sites* were chosen manually from the crystal structure
    of P450 BM3 A82F/F87V mutant `4KEY` [@butler2013key], the template
    structure for these experiments.

-   *Docking Exhaustiveness* is 16: the maximum value allowed by *VINA*,
    which is computationally intensive but yields results with lower
    variability.

-   *Population Size* is 128, this was chosen because monitoring CPU
    usage was observed to be low in instances run with large *Population
    Sizes* in a single process, so to maximize CPU usage, eight
    replicates were executed in separate parallel processes instead.

-   *Survival Rate* is $\frac{1}{4}$, where the top scoring fraction
    survive to repopulate the gene pool.

Experiment $A$ was run using code in the `git` branch `x2` on commit
`????`, and experiment $B$ was run on branch `x3` and commit
`e7af345fba8b8be36bea25982af0b978df8267e8`.

Each was run in eight parallel instances using the script `vde/vde.sh`,
which launched `vde/main.py` with the command
`python main.py -fn b -p 128 -e 16 -n 32 -s 0.25 &`, which invokes the
parameters in table [3.1](#config).

### Cloud Deployment 

Each `g6-dedicated-50` was provisioned with `evo/cloud/build-linode.sh`
and the configuration scripts in `evo/scripts/config`. The *Linode*
instance had the virtual hardware specifications showing in table
[3.2](#linode).

| **Item**       |**Specifications** |
| ---------------|-------------------|
| CPU cores      |50                 |
| RAM            |128 GB             |
| Disk           |250 GB             |
| Cost per hour  |\$1.44             |

Virtual hardware specifications of the `g6-dedicated-50` server hired for experiments $A$ and $B$.

Each experiment lasted about 3 days and cost \$103 at a rate of \$1.44
per hour. Data generated was structures, docking poses and scores for
each mutant and was compressed into a `.tar.gz` archive and uploaded to
a *Linode* bucket, code changes were committed and pushed with `git` and
the machines were terminated. The eight replicates were run in parallel,
generating 32,000 mutants for each experiment. Data was pulled down from
the bucket storage onto a separate server for analysis with

| **Item**       |**Specifications**  |
| ---------------|--------------------|
| CPU cores      |8                   |
| RAM            |16 GB               |
| Disk           |325 GB              |
| Cost per hour  |\$0.18              |

Virtual hardware specifications of the `g6-dedicated-8` server hired for analysis of experiments $A$ and $B$.


