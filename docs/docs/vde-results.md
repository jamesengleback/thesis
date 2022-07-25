# Results

### Exploratory Analysis for Experiments $A$ and $B$

Each experiment $A$ and $B$ yielded near to 32,000 unique mutants. The
overall distributions for metrics, amino acids at each site and a set of
dimensionality reduction techniques for data generated in experiments
$A$ and $B$ are shown here. These metric distributions are compared in
figure [3.5](#abdistr), where
the recorded metrics were:

-   $\Delta G$: The mean binding energy for docked mesotrione poses as
    calculated by *VINA* and given in kcal/mol.

-   $H$: The Hamming Distance, or number of mutations relative to the
    wild type.

-   $d$: The distance between mesotrione carbon $C_5$ and the heme iron,
    given in Å.

-   $score_{\in {a, b}}$: The score function $a$ or $b$ for experiments
    $A$ and $B$ respectively. Score $a$ is described in
    [\[scorefn\]](#scorefn)
    and $b$ in [\[scorefn\]](#scorefn).

The progression of these metrics with generation for each experiment are
shown in [\[violin\]](#violin).
**note:** columns mislabelled in $B$, need suptitle. Viewing the
progression of the objective score shows that for $A$ and $B$ the score
distributions changed by very little, suggesting that the sequence
optimization algorithm used here is a poor choice for this type of
problem. On the other hand, $\Delta G$ did increase in both, which could
mean that both score functions tended to sacrifice $\Delta G$ for $H$ or
$d$, or more worryingly that $\Delta G$ is prioritized and that the
optimizer was unintentionally reversed. Despite this, the algorithm did
produce a large volume of data which can still be dissected to identify
active mutants and gain insight.

Progression of $\Delta G$, $d$ and $score_a$ with generation for experiment
$A$.
![](img/generation-global-dist_mean-a.png)

$\Delta G$, $d$ and $score_b$
with generation for experiment
$B$.
![](img/generation-global-dist_mean-b.png)

The histograms in figure [3.5](#abdistr) shows that for both $A$ and $B$, there are many
mutants for whom $d < 8$ which may be suitable for the project aim.
Between the two experiments, the distance $d$ between carbon $C_5$ and
the heme iron is largely similar, so too are the calculated affinities
($\Delta G$) and Hamming distance to the wild type, $h$. Hamming
distance $h$ rarely exceeded 8, likely due to the constraint on $h$
incorporated into both score functions. Docking binding energy estimates
$\Delta G$ cluster at a set of values for both experiments which may
indicate the same number of pose clusters with similar energies. For
both, distance $d$ was a skewed distribution that leans towards lower
values, each with a small shoulder at around 15 Å, which may reflect
either a cluster of binding poses or a cluster of mutants for which
binding of mesotrione to the active site is blocked.

Histograms showing the
distributions of each recorded metric across the entire experiment for
both experiments $A$ and $B$.

![](img/exp-a-b-compr-dists.png)

Figure [3.6](#logot) is a
sequence logo which shows the amino acids at each mutation site for the
template sequence BM3 A82F/F87V, whilst
[3.7](#logoa) and
[3.8](#logob) represent the
overall frequencies of different amino acids across experiments $A$ and
$B$ respectively. They show that the repeats of each experiment tended
towards the template amino acid at each position, likely because of the
constraint on $h$ in both score functions, resulting in few mutants that
are more than six mutations from the template. Ignoring the template
amino acids yields the sequences logos
[3.9](#logonotpa) and
[3.10](#logonotpb), neither
of which show a clear preference at any particular site.

Sequence logo showing the original
amino acids at mutation positions in experiments $A$ and
$B$.
![](img/template-logo.png)

Sequence logo showing the overall
amino acid frequencies in mutants in $A$.
![](img/exp-a-logo.png)

Sequence logo showing the overall
amino acid frequencies in mutants in $B$.
![](img/exp-b-logo.png)

Sequence logo showing
the bulk average mutation preference in experiment $A$, ignoring the
template amino acids ([3.6](#logot)).
![](img/expa-logo-notemplate.png)

Sequence logo showing
the bulk average mutation preference in experiment $B$, ignoring the
template amino acids ([3.6](#logot)).
![](img/expb-logo-notemplate.png)

From this we can see that the sequence optimizer has not worked, but has
generated mutants predicted to have desirable mesotrione binding
properties given the project aim. Unanswered questions that remain are:

-   Are there clusters of sequences or regions of sequence space where
    desirable properties are prevalent? And is there a pattern in
    mutation preference for these clusters?

-   How noisy is the evaluation function?

### Clustering

Although there was no global consensus on a set of mutations that
improve binding, clusters of sequences showed improved binding
properties. Clusters of mutants were identified using dimensionality
reduction and clustering algorithms. Mutant sequences were reduced in
dimensionality using both the *t-SNE* [@van2008visualizing] and *UMAP*
[@mcinnes2018umap] algorithms to decompose an input of the binary
encoded amino acids at each mutation position. The reduced sequence
information is mapped to scores in figure
[3.11](#dimredplt).

Two different
dimensionality reduction techniques were applied to the integer encoded
sequences data from $A$ and $B$. The coordinates are mapped to their
respective scores. **note: viridis -\> inferno, umap point size
smaller**
![](img/dimred-plt.png)

The same
dimensionality-reduction coordinates as in figure
[3.11](#dimredplt) colored
by cluster mapping generated by the *DBSCAN* algorithm acting directly
on the reduced coordinates. Color codes to clusters are not shown for
the sake of space.
![](img/dimred-plt-clusters.png)

Clusters of dimensionality-reduced mutants
as in figure [3.12](#dimredclusters) mapped to the mean score of that cluster. In
the t-SNE plots, clusters with high and low scores are visible in both

![$A$ and $B$.](img/dimred-clust-meanscores.png)

Despite no global consensus, clusters of mutants were identified with
the aim of identifying regions of sequence space with their overall
favourable properties. The hypothesis here was that some regions of
sequence space would largely have similar characteristics save for
extreme loss of function mutants. Activity distributions within clusters
would be different from the global distribution in this case which can
be quantified using Kubrik-Leibler divergence [@kldiver] $D_{KL}$ in
equation [\[kldiv\]](#kldiv).

$$\label{kldiv}
    D_{KL}(p||q) = \sum_{x \in X} p(x) \log{\frac{p(x)}{q(x)}}$$ $KL$
divergence between two distributions $q$ and $p$ which are approximated
with the function $q(x)$ and $p(x)$ where $x \in X \in \mathbb{R}$.

Rather than clustering directly from the sequences, clusters were made
directly from the reduced dimensions using the *DBSCAN* algorithm,
exemplified in figure [3.12](#dimredclusters). This was because the dimensionality
reduction methods used here group spatially with similarity, so
clustering spatially clusters sequences with some similar properties.
The benefits of this order of operations include performance
improvements for the clustering algorithm given the lower dimensionality
of the data and coherence with the sequence dimensionality reduction
which makes it useful as a *fitness map*.

For each dimensionality reduction technique, *DBSCAN* was used to
identify clusters from the coordinates, shown in figure
[3.12](#dimredclusters).

### Codon Design

From these clusters, the best scoring eight were selected, their amino
acid frequencies calculated and degenerate codons designed to reflect
that frequency using the *Codon Genie API*. Reports for each were
generated and an example is shown in figure
[3.14](#cdxreport) and the
codons designed for exemplary cluster 314 are in table
3.4.

| **Position**  |**Codon**  |**Expansion**       | **Number of Encoded Variants** |**Amino Acids**  |
| --------------|-----------|--------------------|--------------------------------|-----------------|
| 47            |CGT        |CGT                 |               1                |R                |
| 49            |ACC        |ACC                 |               1                |T                |
| 51            |TAT        |TAT                 |               1                |Y                |
| 75            |CTG        |CTG                 |               1                |L                |
| 78            |GTT        |GTT                 |               1                |V                |
| 88            |WSG        |ACG, AGG, TCG, TGG  |               4                |T, W, R, S       |
| 94            |AAA        |AAA                 |               1                |K                |
| 138           |CAT        |CAT                 |               1                |H                |
| 142           |GGT        |GGT                 |               1                |G                |
| 175           |ACC        |ACC                 |               1                |T                |
| 178           |GTT        |GTT                 |               1                |V                |
| 184           |KMT        |GAT, GCT, TAT, TCT  |               4                |A, Y, D, S       |
| 188           |CTG        |CTG                 |               1                |L                |
| 205           |TTT        |TTT                 |               1                |F                |
| 226           |AGC        |AGC                 |               1                |S                |
| 252           |GAA        |GAA                 |               1                |E                |
| 255           |CAG        |CAG                 |               1                |Q                |
| 260           |ACC        |ACC                 |               1                |T                |
| 263           |MRT        |AAT, AGT, CAT, CGT  |               4                |N, R, H, S       |
| 290           |RMT        |AAT, ACT, GAT, GCT  |               4                |A, N, D, T       |
| 295           |GCA        |GCA                 |               1                |A                |
| 328           |GCA        |GCA                 |               1                |A                |
| 330           |RMA        |AAA, ACA, GAA, GCA  |               4                |A, K, E, T       |
| 350           |GGT        |GGT                 |               1                |G                |
| 353           |CTG        |CTG                 |               1                |L                |

An example of the codons auto-generated for mutant cluster 314, which encodes few variants. 
A total of 1024 variants are encoded by this set of codons.

This way, codons were designed for clusters in experiments $A$ and $B$,
the data and reports for which are stored in `nb/codons/` of the project
`git` repository. The total size of each library yielded by the codon
design varies from four to several thousand, the latter of which are not
suitable for use owing to the extreme numbers of potential variants.
Some libraries also inadvertently encode a *Stop* codon, which should
also be avoided.

A codon report for cluster 314 derived from a *UMAP* of the sequences in experiment $A$.
Shown are the cluster distributions of each recorded metric relative to
the global distribution. The sequence logo represents the mutation
frequency at each position. 
![](img/clus_314.png)

The amino acid coverage of the degenerate codons designed for cluster
314, which include off-target amino acids at several
sites.
![](img/clus_314-codon-coverage.png)


