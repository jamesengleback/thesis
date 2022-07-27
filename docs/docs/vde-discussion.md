# Discussion


Here, a working *Virtual Directed Evolution* system was developed,
including the simulation back end `enz`. The system used a genetic
algorithm to optimize a set of mutation points in the Cytochrome P450
BM3 for a mesotrione binding metric that aimed to select for mutants
that dock mesotrione with the $C_5$ carbon of mesotrione held stably
near the BM3 heme iron. It was run on cloud infrastructure at a scale of
64,000 mutants over a three day period. From the output of the algorithm
a set of mutations with potentially desirable effects were identified,
given the aim of engineering a BM3 mutant capable of mesotrione
5-hydroxylation. Additionally, mutant clusters were found amongst the
results of the algorithm, for the most active of which sets of
degenerate codons were designed.

The system was designed to be modular enough so that components can be
modified independently of one another. As such it is important to review
these components with a view to fixing and upgrading them.

The most critical uncertainty and potential shortcoming of this
implementation of *Virtual Directed Evolution* is whether the simulation
evaluation used is a meaningful metric to optimize for. The accuracy of
the simulation in portraying relevant aspects of the enzyme-ligand
interaction is critical to be applicable to the world outside the
simulation. So too is the meaningfulness of the score function which is
to be optimized for, which in this case is only designed as a proxy to
desired chemical activity.

Less critical, though with operational significance is the efficacy and
efficiency of the sequence optimization algorithm used. Large gene pools
improve the performance of genetic algorithms, so scale is important.
Slightly out of scope of *Virtual Directed Evolution* is codon design,
which must yield libraries that are small enough to screening and rich
enough in activity to offset the high cost of making and testing the
mutants.

These key parts of the project are dissected further for potential
improvements:

#### Simulation Accuracy

In as far as a simulation is a time series approximation of a real world
situation, the simulation here is a misnomer for referring to prediction
of mutant structures and likely binding poses between them and
mesotrione before being subject to some score function. That said, the
simulation used in this work is crude owing to its lack of protein
backbone movement during structure prediction and lack of interaction
dynamics between protein and ligand. These two functions, protein
structure prediction and docking were contained by `enz`, which
abstracts these two functions in its *API* and therefore the scope of
improvements to simulation accuracy are within `enz`.

There are several aspects of `enz` that can be improved over different
time scales. One short and simple improvement is unit testing of all
code in the module to ensure that the code behaves as expected. There is
currently no unit testing in `enz` which limits the ability to diagnose
problems with it.

Since `enz` itself is a simple wrapper around protein structure
prediction and docking programs, those programs can be replaced or
modified. *PyRosetta* proved problematic in deployment owing to its
licensing and package size, which necessitates distribution of
*PyRosetta* to target machines via direct file transfer as opposed to
download directly from the world wide web. This was done here by storage
of a copy in a *Linode* bucket storage in Hamburg which itself required
authentication with the `linode-cli` interface, a step that would
require careful planning were it to be fully automated given that access
tokens would be in play.

*PyRosetta* contains lots of functionality, but only a single function -
side chain repacking [@dunbrack1993backbone] is used. Cyclic coordinate
descent as a means of predicting loop structure [@canutescu2003cyclic]
was investigated but subsequently dropped owing to the difficulty of the
software implementation, which would often result in *Segmentation
Faults* that crash the process by attempting to access out of bounds
memory, something inherent to *PyRosetta* itself. *Segmentation Faults*
were commonplace in investigating other folding methods, which combined
with sparse documentation coverage and a license which incurs an annual
cost to non-academic users raises a case for exploring other protein
folding methods.

Recent advances in the use of machine learning in protein structure
prediction [@jumper2021highly] have outperformed their non-learning
counterparts. Though the *de-novo* structure prediction of *Alphafold*
[@jumper2021highly] outperforms all known structure prediction methods
to date, since it is such a large model it requires GPU or TPU cores to
function and may take some hours on a single prediction. *De-novo*
protein structure prediction may be unnecessary for this application,
since the protein backbone chain may be similar among mutants.

Template-based protein structure prediction using machine learning
methods may on the other hand be more viable, given the shorter
prediction times involved. An additional advantage of using a
lightweight machine learning-based method is the prospect that inference
can be accelerated significantly using a GPU or TPU. One candidate for
replacement of the *PyRosetta* back end is `torchmd`
[@doerr2021torchmd]: an open-source *PyTorch*-based molecular dynamics
package which would allow side chain replacement and subsequent
repacking via either energy minimization using a force field such as
*Amber*[@wang2004development]. Being based on *PyTorch*, there is scope
for accelerated calculations using GPUs, and it also offers
compatibility with other *PyTorch*-implemented protein structure machine
learning methods.

Docking using *VINA* is CPU-bound and the most time-consuming step of
each round of the *Virtual Directed Evolution*. This can be accelerated
with more CPU cores, or employment of a GPU-based docking program like
*Autodock GPU*[@santos2021accelerating], which is free and open source.
Alternatively, emerging docking methods based on machine learning may be
worth consideration given their performance [@doerr2021torchmd]; should
these methods be implemented in *PyTorch* then the entire protein
structure prediction and docking pipeline could be carried out on a GPU
without writing to disk or converting file formants.

The structure of the `enz` wrapper allows for drop in replacements of
each component, whilst also providing a coherent data structure for user
interaction and analysis which is essential for scoring. The key
priorities for improvements to `enz` are:

-   **Accuracy:** To assess accuracy, a task-relevant baseline needs to
    be established. In the context of an enzyme engineering project,
    this could be the results of a lab screen of the mutants generated
    here. In that case, correlation between simulation predictions and
    lab metrics can be quantified using an appropriate metric like
    Pearson's correlation coefficient. With a metric to optimize
    towards, changes can be made to the underlying simulation mechanisms
    of `enz`. An alternative, cheaper source of baseline data is the
    *PDBBind*[@liu2015pdb] dataset - a collection of ligand bound
    protein structures for which the task would be to replicate these
    bound configurations using docking. Differences between poses
    generated by docking and those in the *PDBBind* dataset can be
    quantified using a metric like root mean squared difference (RMSD)
    between each atom.

-   **Performance:** Both *PyRosetta* and *VINA* are CPU-bound, which
    limits the speed at which mutants can be evaluated because of the
    inherently linear nature of CPU processing. Should alternatives for
    both be found they would ideally run with GPU acceleration, which is
    inherently parallel. *Autodock GPU*[@santos2021accelerating] is an
    attractive short-term replacement for *VINA* given its performance.
    Beyond short term changes, structure prediction and docking
    algorithms implemented in *PyTorch* are attractive because of the
    prospective GPU acceleration and compatibility with machine learning
    algorithms.

-   **Portability:** Installing the required environment on the target
    machine with minimal intervention is important for scaling to
    multiple machines. Therefore, the *portability* of the
    requirements - in terms of ease of data automated data transfer and
    setup is important. *PyRosetta* is not free for non-academic users,
    which makes it more difficult to find on the clear web and is a
    reason to not use it in a commercial setting. It also relies on
    distribution of compiled binaries that may not be suitable for a
    particular CPU architecture or operating system. It is also large -
    with the compressed release reaching 1.3 GB, which is uncomfortably
    large given that only a small subset of its functionality are
    employed.

#### Score Relevance

The score function optimized towards during runtime is critical for
output of mutants with the desired activity in the real world. It uses a
set of assumptions as a proxy metric for likelihood of $C_5$ mesotrione
hydroxylation:

1.  That the $C_5$-heme iron distance $d$ must be minimized in order to
    maximize the likelihood of the desired reaction. This is based on
    the assumption that $C_5$-heme iron proximity will drive the target
    reaction. It also assumes that the chemical potential between the
    two atoms is sufficient to drive electron transfer from the BM3
    reductase domain to $C_5$.

2.  That the estimated binding $\Delta G$ energy of a pose to BM3
    relates to the likelihood of that pose occurring.

3.  That a low Hamming distance $h$ between a mutant sequence and the
    template indicates that the mutant structure would not be so
    different from the template that the protein structure prediction
    methods used are sufficiently accurate.

If these assumptions hold, then the score function may be sufficient as
is in experiments $A$ and $B$. The ideal scenario for evaluating the
efficacy of the score function is to compare it to lab data containing
BM3 mutants and data on the products formed on reaction with mesotrione,
if any and the rate at which they are formed.

Since the score is only a simple proxy in its current states, in future
design iterations in conjunction with lab data to mimic it will likely
grow in complexity.

#### Sequence Optimization

Though a genetic algorithm was used as a sequence optimizer in this
work, others can be used and the genetic algorithm itself stands to be
modified to improve efficiency. A genetic algorithm was implemented
because they are simple and inherently parallelisable, which suits
horizontal scaling of processes. Many evolutionary algorithms have been
studied in other work, which represents a rich field from which to
harvest upgrades.

Some changes that can be made include:

-   **Tournament Selection:** Rather than selection of the $n$ best
    performing mutants, random pairs are compared for score and the best
    performing survives. This introduces an element of randomness which
    can enhance diversity and avoid *local minima trapping*, where a
    good solution is found in a small subset of sequence space but is
    far from the global optimum for the given constraints.

-   **Randomness:** As with tournament selection, an element of
    randomness in the selection step can help avoid *local minima
    trapping* in a similar manner to tournament selection.

-   **Generation Persistence:** The implementation used here only
    carries the current generation in memory, so if a cluster of good
    mutants are found in an earlier round there is a risk of
    *forgetting* by evolutionary divergence from those sequences. A
    solution to this could be that the best performing mutants within
    and between experiments are cached and repopulation stems from this
    pool.

Again, a benchmark for performance of these algorithms must be
established to update and improve it. The benchmark must be task
relevant in that it approximates the type of fitness landscape expected
for protein sequence optimization, so it may be best done with the
current simulation method. In this case, the metric for improvement can
be some formulation of:

-   Rate of fitness improvement $\frac{\delta f}{\delta t}$, where the
    area under an curve interpolated through points of generation
    numbers against fitness scores can represent this rate.
    Alternatively, the initial gradient of the interpolated curve may
    also be a suitable metric for rate of fitness improvement.

-   Maximum fitness attained by the algorithm may be a good indicator of
    whether the algorithm is subject to *local minima trapping*, which
    itself may be a good proxy metric for sequence exploration.

-   Exploration of new sequences is important to avoid *local minima
    trapping* and to avoid re-visiting sequences. This can be quantified
    using a sequence diversity metric of all mutants tested over the
    course of an experiment, such as the sum of pairwise $h$ between all
    sequences.

Many improvements within the scope of the implemented genetic algorithm
stand to be investigated, other sequence optimization algorithms are
worth investigation. Namely, *Bayesian Optimization* is an attractive
candidate for this given its efficiency and applicability to sequence
optimization. *Bayesian Optimization* uses an internal *Bayesian* model
of response to action space input in order to generate new inputs based
on their expected fitness $\mathbb{E} f$ and expected information gain
$\mathbb{E}IG$.

#### Scale

Scale is important to evolutionary algorithms, where a large gene pool
in each generation leads to more diversity explored. Even using
*Bayesian Optimization*, a large batch of candidates evaluated in
parallel will likely yield a solution faster than sequential
evaluations. Therefore, scaling to a large number of parallel
evaluations is important. Using cloud resources is ideal for rapid and
elastic scaling, where instances are provisioned for the duration of the
experiment and then terminated, reducing costs massively compared to the
overhead cost of purchasing and maintaining the equivalent computing
hardware. It also allows immediate scale to $n$ machines with $m$
computing cores.

That said, in this work the algorithm was run on a single, large machine
which tool some semi manual setup using a set of scripts included in
this repository. Scripts were required because inclusion of *PyRosetta*
in the project would push the size of a disk image of the machine above
the upper limit of that allowed to be saved, stored and distributed
using *Linode*. Were this process able to boot directly from a disk
image, setup could be fast and automated.

To increase scale beyond that used in this project, each round of
evaluations may have to be distributed among multiple machines. This can
be done using a hub and spokes model where the sequence optimization
algorithm resides in the hub node and the more expensive evaluations are
sent to the spoke nodes. This can be coordinated using the *Kubernetes*
engine, which is designed to orchestrate and distribute jobs amongst an
array of virtual machines. *Kubernetes* can then be used for arbitrary
horizontal scaling and coordination of clusters of machines.

#### Codon Design

Though slightly out of scope of *Virtual Directed Evolution* itself,
efficient codon design is essential for downstream applications. Here
several sets of codons were designed for downstream experiments in the
lab, the results of which can be used to improve the algorithm. Codons
were designed as degenerates, each potentially encoding a selection of
amino acids.

An important consideration in codon design are the library size, which
can be calculated by taking the product of the number of amino acids
that each degenerate codon encodes. Library size constraints are
determined by the capacity of downstream screening or selection
processes. If screening based on colonies picked from the transformed
libraries is used then the cost of the screen scales with the number of
mutants, in which case a library size on the order of hundreds may be
advisable. On the other hand if the downstream process is a selection
screen, then constraint on library size may be imposed by the
transformation efficacy into the selection cells, which may be on the
order of 10^4^, though repeating transformations and subsequent
selection steps can be cheap, so a library size on the order of 10^5^
may be suitable.

Although the codons themselves are designed here, no additional designs
towards DNA assembly are made, for example primer design. Should this
functionality be improved, it represents project creep and will best be
compartmentalized within another project.

\bib
