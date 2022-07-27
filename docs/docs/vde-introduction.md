# Introduction

### Background

#### Herbicide Resistant Crops

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
metabolic enzymes from naturally resistant species like *Avena fatua*,
which employs cytochrome P450 Cyp72A1 to initiate metabolism of
mesotrione by ring hydroxylation at $C_5$. In this case, the $C_5$
hydroxylation acts as a target site for glutathione-S-transferases which
conjugate glutathione to xenobiotics. The glutathione conjugate tags the
xenobiotic for sequestration in the cell vacuole, which neutralises the
threat.

Engineered Cyp72A1 has been explored as a means of HPPD herbicide in
soybean, which is an important target recipient for HPPD resistance
traits.

The HPPD inhibiting herbicide mesotrione and its primary metabolite 5-hydroxy-mesotrione in resistant strains of *A. fatua*.
![](img/mesotrione+metabolite.png)

#### Cytochrome P450s

Cytochrome P450s are a ubiquitous class of heme-dependent
oxido-reductases that are frequently involved in xenobiotic metabolism.
Bacterial P450s have been engineered to catalyse a range of xenobiotic
biotransformations. The bacterial P450 BM3 from *Bacillus megaterium* is
one such bacterial P450 whose structure has been studied extensively.
The A82F/F87V mutant has a broad substrate specificity, however it has
no activity towards the HPPD herbicide mesotrione.

#### Virtual Directed Evolution

Enzymes can be designed computationally using a genetic algorithm that
evaluates the fitness of mutants by simulating the interaction between a
target substrate and the predicted structure of the mutant.

The structure of a mutant can be predicted based on a template using
techniques such as side-chain repacking by stochastic sampling from
rotamer libraries and loop remodelling by cyclic coordinate descent.

Binding site interaction can be predicted using molecular docking, which
attempts to predict likely protein-ligand binding conformations. A
combination of the energy score and the conformation of docked molecules
can be used to estimate likelihood of desirable reaction and therefore
the fitness of a mutant. In rounds of selection within a genetic
algorithm, the fitness of a batch of mutants is evaluated by scoring
desirability of protein-ligand binding, the fittest mutants are selected
for breeding, in which mutants have elements of their genes recombined
are further mutated, then the cycle repeats.

### Technologies Used

#### Directed Evolution

#### Structure-Based Design

#### Protein Structure Prediction

#### Docking

#### Sequence Optimization Algorithms

#### Overview of this work

#### Engineering Problem

### Overview of this Work

Here, in attempt to engineer a mutant of the Cytochrome P450 BM3 to
hydroxylate mesotrione at the $C_5$ position is made by developing a
*VDE* system, deploying it at scale on cloud infrastructure and
identification on clusters of putatively active mutants.

\bib
