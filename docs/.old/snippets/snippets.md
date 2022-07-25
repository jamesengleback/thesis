The system was designed to be configurable to other enzyme engineering projects, so an abstraction layer for protein structure-prediction and molecular docking - `enz` was constructed for this work.


<h2 id="vde"> Virtual Directed Evolution </h2>
[`evo`](#evo) is the main repository for this work. It contains the Scripts used to run the virtual directed evolution experiments on a *Linode* cloud computing instance.

The main function, `evo.sh` was used to run the experiment, which calls `main.py` in a number of independent processes and specified parameters.
`main.py` uses a genetic algorithm built using [`ga`](ga) to mutate sequences based on the promiscuous BM3 mutant A82F/F87V.
Structures are predicted from the crystal structure 4KEY `\ref` and docked with mesotrione using [`enz`](#enz).

The main loop of `bm3/main.py` uses [`ga`](ga) to initialise a mutant population of $n$ with random single mutants of the template A82F/F87V sequence. Throughout the process, mutations are constrained to hand selected active site residues.

Protein structure prediction and docking are handled by `enz` - a simple python abstraction layer between the user and both PyRosetta and VINA.

Then, in each iteration the mutant structure is predicted and mesotrione is docked to the active site using [`enz`](#enz).
Poses are scored based on proximity of the mesotrione C<sub>5</sub> to the heme iron and the VINA score, see [Fitness function](sfxn).
The top $N%$ fittest mutants repopulate the mutant pool via random crossover between random pairs of sequences and a random point mutation.


