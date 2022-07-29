# Results


## Screening Data Analysis

The data gathered for the screening experiments was saved in the `git`
repository `https://github.com/jamesengleback/screening-fist` in the
`lab` directory. Within the `lab` directory are directories for each
screening experiment. These include a `config.yml` file which maps data
files to experiments for analysis.

The script `sxfst/scripts/data_proc2.py` was used to process the data
into a large `csv` file containing each raw trace and its metadata. By
consolidating the data into a single file, fewer time-consuming
operating system calls are made in downstream analysis which decreases
the time cost of those tasks.

The script attempted to use the *Echo* logs from each run to calculate
the actual volume of each compound dispensed, since towards the end of
the screening program shortages of compound made it impossible to fully
dispense some experiments. In retrospective this function did not
perform properly, since all experiments are later annotated as having
the target volumes of each compound. This cannot be the case since it
was casually observed that some compounds were completely depleted by
the end of the screening program. This issue is significant, leading to
false negatives where a lack of response cannot be attributed to either
a lack of compound or a true negative response. This coding issue can be
solved, but was not due to time constraints.

The downstream analysis in question was done using the script
`sxfst/scripts/data_analysis.py` which normalizes the traces, subtracts
the control traces from them and calculates the P450 response to each
compound, creating a plot in the process. An example of one such plot is
in **figure [2.6]**.

The traditional response calculation method using
$\Delta A_{390} - \Delta A_{420}$ proved ineffective for analysis of
this data due to the noise, which would often result in scattering that
increased the absorbance at the short wavelengths in ways that were
occasionally unpredictable.

Instead, the gradient of each trace was taken by convolution of the
kernel $\begin{bmatrix} -1 & 0 & 1 \end{bmatrix}$ across the smoothed
and normalized traces. The gradients were invariant to total absorbance,
which was often perturbed by what appeared to be light scattering, but
achieved a similar effect to calculation of
$\Delta A_{390} - \Delta A_{420}$. From the gradients, response was
calculated as
$|{\frac{\delta y}{\delta x_{390}}}| + |{\frac{\delta y}{\delta x_{420}}}|$.


Below are some examples of reports generated for each screening experiment, showcasing hits, misses and the undecidable.

![](img/BM3-Heme-A82F:S1608.png) 
> A positive result or *hit* between BM3 A82F and *pyridostigmine bromide (mestinon)*.

![](img/BM3-Heme-A82F:S3176.png) 
> A positive result or *hit* between BM3 A82F and *Betahistine*.

![](img/BM3-Heme-1YQO:S1881.png)
> An example of a negative result between BM3 1YQO and *Protionamide*.

![](img/BM3-Heme-1YQO:S1185.png)
> An example of an undecidable result between BM3 1YQO and *Ritonavir*.
> Here the optical properties of the screening compound have interfered with measurement, evidenced by the similarity between the control and test traces in which the absorbance is very high.


![](img/BM3-Heme-1YQO:S2040.png)
> Another example of an undecidable result between 1YQO and *Nimesulide*.
> *Nimesulide* has a large absorbance peak in to 300-500 nm range that could not be corrected for with the data.
> Correction may have been possible if the total liquid volume in the wells was more consistent, though a multichannel pipette offers limited precision.

---

At the time, curve-fitting *en-masse* proved difficult and unreliable.
**more**


The alternative solution was manual annotation of the plots output by
the script. Though crude, this method did yield a list of ostensible
*hits* as well as a list of anomalous results that were to be ignored.

Using this approach, 149 hits of the total 4900 compounds were
identified, listed in the file `lab/hits.txt` in the repository. These
were used to create a `csv` file containing the full sequence and SMILES
code for each enzyme compound pair and a boolean value that was true if
that experiment was annotated as a *hit*. There are several drawbacks to
this that should be noted:

-   **Human Error:** Although several passes over the data were done,
    the order was never randomized and there was only one annotator.
    Since there are 4900 experiments, even if the annotator averages 1
    second per annotation the runtime of an annotation run is 81
    minutes, which will likely cause fatigue and subsequent errors.
    Since the order was not randomized, fatigue-induced error is more
    likely to occur in the same regions of the dataset in each pass.

-   **False Negatives** due to a lack of properly functional compound
    concentration calculation, which would yield results that appear
    negative due to a lack of compound without being properly labelled
    as such. Another source of false negatives is the obfuscation of
    hits by noise in the traces due to scattering or compound absorbance
    that in some cases proved hard to correct for.

A table containing the structures and Murcko scaffolds [@bemis1996properties] of the manually annotated hits is in [appendix 1](sxfst-appendix.md).
Only BM3 A82F is assosciated with hits in this data, and none for A82F/F87V which is unexpected given the previous identification of binding interactions between this mutant and a number of FDA-approved compounds[@jeffreys2019novel].
On inspection of the A82F/F87V data, each experiment used protein in mixed spin - already bound to something, which obscures any binding interactions with the test compounds.

During screening, both A82F and A82F/F87V were thawed and measured to have mixed spin characteristics, which is ostensibly due to binding contaminants in the buffer.
Although this was identified prior to screening and attempts to clear the binding site using a *Lipidex 1000* hydrophobic column, the contaminant-binding effect persisted which renders the entire A82F/F87V experiment useless.
Figure **[a82f-f87v-post-lipidex.png]** shows the UV-Visible light absorbance trace of the BM3 A82F/F87V mutant after being treated with a *Lipidex 1000* column to clear the binding site. 
It shows a clear absorbance peak at 420 nm which indicates successful clearance of the binding site, yet the peak is consistently diminished in the plate data - likely a result of a contaminant in the assay buffer.

![](img/a82f-f87v-post-lipidex.png)
> UV-Visible light absorbance of P450 BM3 mutant A82F/F87V after treatment with *Lipidex 1000* resin.
> The trace chows a peak at 420 nm which indicates that the binding site was successfully cleared.

![](img/BM3-Heme-A82F_F87V:S1137.png)
> BM3 A82F/F87V and *Malotilate*, where the mutant is already bound to a contaminant, resulting in the lack of an absorbance peak at 420 nm even in absence of compound.




## Model 

### Model Description

### Pre-Training
### Pre-Training Data
#### Pre-Training

Given constraints on money towards computing resources, a
hyper-parameter sweep was not viable. Instead, a small selection of
models were trained and evaluated and the best of those was retrained on
the screening data. Model architecture and hyper-parameters were
directly configurable by supply of arguments to the training script
`model/train.py`, from which the best performing model was obtained
using the command
`./train.py -i data/o3f.train.csv –transformer –cuda –emb_size_head 2560 –n_layers_head 3 –emb_size_fp 512 –n_layers_fp 4 –num_conv_layers_pool 3 –kernel_size_pool 9 –stride_pool 3 –lstm_hs_pool 1024 –lr 1e-5 –batch_size 64 -e 32 `,
which is consolidated in **table
[2.6].

| **Parameter**            |**Value**             |
| -------------------------|----------------------|
| lr                       |$10^{-5}$             |
| esm                      |esm1\_t6\_43M\_UR50S  |
| cuda                     |True                  |
| load                     |None                  |
| test                     |False                 |
| input                    |data/o3f.train.csv    |
| epochs                   |320                   |
| batch\_size              |640                   |
| emb\_size\_fp            |512                   |
| n\_layers\_fp            |4                     |
| stride\_pool             |3                     |
| transformer              |True                  |
| lstm\_hs\_pool           |1024                  |
| emb\_size\_head          |25                    |
| n\_layers\_head          |3                     |
| kernel\_size\_pool       |9                     |
| num\_conv\_layers\_pool  |3                     |
| num\_lstm\_layers\_pool  |2                     |

> Parameters for the best performing model in pre-training, designated the identifier *frosty-breeze-83* by the *Weights and Biases* API.

![](img/frosty-breeze-83-eval.png)
> Model
> evaluation report after pre-training for the model designated
> *frosty-breeze-83*. Evaluation was on `o3f.test.csv` - a held-back
> partition of the pre-training dataset. Depicted are: mean binary cross
> entropy loss the course of training on `o3f.train.csv`, a confusion
> matrix, a receiver operator curve (ROC), a precision recall curve, a
> detection error trade-off (DET) curve and mean precision and mean binary
> cross-entropy loss over
> evaluation.

![](img/frosty-breeze-83-vivid-breeze-91-devout-thunder-90-eval.png)
> Model
> evaluation for another instance of *frosty-breeze-81*, this time
> designated *devout-thunder-90*, again retrained on the lab-based
> screening dataset `screening-data.train.csv` and evaluated on
> `screening-data.test.csv`. The report uses the same methods as in figure
> [2.7].

![](img/frosty-breeze-83-vivid-breeze-91-eval.png)
> Model evaluation
> report after pre-training for the model designated
> *vivid-breeze-91*.

## Model Application

\bib
