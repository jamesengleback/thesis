# Methods and Development

## Assay Development

In order to generate a P450 BM3-specific dataset on which a model could
be re-trained to make binding likelihood predictions on drug-like
molecules, a high throughput P450 binding detection assay was developed.
The assay is based on traditional UV-Visible light spectroscopy-based
techniques for detection of P450-ligand binding, miniaturized into a 384
well format. It relies heavily on automation and a throughput of 980
compounds per day is demonstrated.

### Aim

The initial aims of this development work were:

-   Develop a high throughput P450-ligand binding assay based on
    established biophysical characterisation techniques.

-   Develop necessary software for design and analysis of each assay.

-   Compare the precision and accuracy of the assay to existing
    techniques.

### Basis: UV-Visible Spectroscopy for Monitoring Cytochrome P450-Ligand Binding

The assay is based on a technique for quantifying P450-ligand
interactions based on UV-visible photospectroscopy. The technique
consists of the purified Cytochrome P450 heme domain in question in a
neutral buffer at around 5-10 µM in a optically clear cuvette. Since
only the heme-containing domain of the P450 is used, no chemical
reactions are expected to take place which removes time-sensitivity from
the assay.

The UV-visible light absorbance of the sample is typically measured for
all wavelengths between 200 and 800 nm, which for a P450 without a
ligand bound in the active site should show a large and defined
absorbance peak at around 420 nm.

After an initial absorbance measurement of the ligind-free P450, the
compound of interest can be titrated into the sample. On binding to the
ligand, the absorbance profile of the P450 changes such that the
absorbance at 420 nm ($A_{420}$) decreases and absorbance at 390 nm
($A_{390}$) increases.

The change in $A_{420}$ and $A_{390}$ in response to change in ligand
concentration can be quantified and used to derive metrics that indicate
affinity between the ligand and P450 using Michaelis-Menten kinetics
models.

The original Michaelis-Menten model of enzyme kinetics states:

$$v = V_{max} \frac{[S]}{[S] + K_M}$$

where $v$ is the reaction velocity - the rate of an enzymatic reaction.
$V_{max}$ is the maximum possible $v$ for this particular
enzyme-substrate pair, $[S]$ is the concentration of the substrate and
$K_M$ is the $[S]$ at which $v = V_{max}$.

$V_{max}$ and $K_M$ are useful metrics for quantifying the binding
interaction between enzyme and substrate, where low $K_M$ indicates a
tight binding interaction and a high $V_{max}$ indicates a large
magnitude of response.

Important assumptions in the Michaelis-Menten model of kinetics are:

1.  The concentration of enzyme is $< K_d$

2.  The rate of reaction is directly proportional to the concentration
    of the substituents

3.  The reaction is at chemical equilibrium at the time of measurement

4.  The interaction is reversible

A variant of this model is applied to Cytochrome P450 photospectroscopy
assays, where the response to a ligand is detectable in the 390-420 nm
region. Ligand binding to a P450 alters the electron environment in the
heme, which changes the UV-Visible light absorbance profile.
Specifically, absorbance at 420 nm is reduced and absorbance at 390 nm
increases.

In this case, $v$ is substituted for $\Delta A_{390} - \Delta A_{420}$ -
the magnitude of the P450 response and $K_M$ is substituted for $K_d$ -
the dissociation constant between the enzyme and ligand. This yields the
formula:

$$Response = \Delta A_{390} - \Delta A_{420} = V_{max} \frac{[S]}{[S] + K_d}$$

An example of this is shown in **figure
[2.3](#arachadionictitration){reference-type="ref"
reference="arachadionictitration"}**, where the fatty acid arachadionic
acid was titrated into a sample of P450 BM3 wild-type.

Response of P450 BM3 to Arachadionic Acid
from a titration experiment, from which steady-state Michaelis-Menten
kinetics can be derived. The legend shows the concentration of
arachadionic acid in
µM.
![](img/ArachadionicAcid.png)

### Development

This style of assay was miniaturized into a 384-well format for the
purpose of this project. The 384-well format permits high throughput
screening of compounds for binding with a given P450 provided it is
sufficiently stable to last the duration of the experiment without
degrading and interfering with measurement.

At micro-scales, precision dispensing of both compound and protein is
critical for overall assay precision. To achieve sufficient precision,
compounds were dispensed using an *Echo 550* acoustic liquid handling
device, which uses ultrasound to move liquid from a source plate to a
destination plate. In order to achieve the desired dispensing pattern, a
custom python package, `echo`, was developed. `echo` facilitates
dispensing of compounds in the gradients required by output of a
picklist `csv` file that can be used directly in the *Echo*. A critical
function of this package is that it tracks the volume of compounds in
the source plate, which is important in the common case that one
compound must be spread over multiple wells. The package was
indispensable in this work.

During early stages of development, an automated bulk liquid dispensing
device - a *ThermodropMulti* was available. The device uses precise
peristaltic pumps to dispense a single liquid into a plate at a single
volume very quickly. Precision in the bulk fluid volume in the plate is
helpful in downstream analysis due to the consistent path lengths and
concentrations in each well, something that was found to be less
consistent when using a multichannel pipette to achieve the same task.
**Figure [2.4](#assaydevarachadionic){reference-type="ref"
reference="assaydevarachadionic"}** shows an example of both the
*ThermodropMulti* and *Echo* being used to capture $K_d$ and $V_{max}$
for the binding interaction between P450 BM3 wild-type and arachadionic
acid.

Michaelis-Menten steady-state kinetics of
arachadionic acid and wild-type P450 BM3 captured during assay
development. Notably, in this experiment both an *Echo* and
*ThermodropMulti* were used in dispensing compound and protein
respectively, which accounts for the neatness. The traces were smoothed
using a Gaussian kernel to account for
noise.
![](img/assay-dev-arachadionic.png)

## Assay Protocol {#protocol}

This is a assay protocol for detecting binding interactions between a
Cytochrome P450 and multiple small molecule compounds. The assay has
demonstrated scale to a library of 980 compounds and five P450 mutants
and with some small adjustments could be improved in scale and
precision.

It works in 384 well microplates and uses a microplate reader to capture
absorbance profiles from 220-800 nm wavelengths, from which a pattern
associated with a P450-small molecule binding interactions can be
detected and quantified.

It was designed for profiling and modelling the effect of mutations on a
P450's substrate binding preferences. This was tested with five P450
mutants against 980 drug-like compounds. It requires purified P450
protein which limits the rate of data generation, though can scale to
more compounds.

### Requirements

**Essential:**

-   **Hardware:**

    -   **Microplate reader:** Able to read absorbance for all
        wavelengths between 220 and 800 nm. Used here: *BMG ClarioStar
        and FluoStar* microplate readers.

    -   **Labcyte Echo \[500 550\]:** Acoustic liquid handlers for
        precise compound dispensing.

    -   **Consumables:** In absence of a high precision liquid handling
        machine, serial dilution of compounds would probably be fine.

    -   **Enzyme:** A purified Cytochrome P450 - used here were mutants
        of P450 BM3 at  800 µM. Note that BM3 is fairly stable at room
        temperature which facilitates queuing large batches of plates to
        the plate reader. You could run the assay at a low temperature
        if you use a solvent other than DMSO, which freezes at 19ºC,
        which interferes with measurement.

    -   **Compound Library:** A large number of compounds in solvent
        (e.g. DMSO) in a microplate format. Used here was a 980 compound
        library, dissolved at 10 mM in DMSO in 96 well format.

    -   **Buffer:** must be optically clear the protein must be stable
        in it. Must not contain potential ligands. Used here was 100 mM
        Potassium Phosphate at pH 7.0 - chosen based on traditional
        wisdom.

    -   **384 well microplates - clear bottom:** Assay plates with at
        least 30 µl working volume. Some treated surfaces may be more
        suitable for unstable proteins. Ideally have minimal absorbance
        in the 390-420 nm region, but this can be corrected for with
        controls. Used here: *ThermoFisher Nunc 384 Well Plates*

    -   **384 well *Labcyte Echo* source plates:** for dispensing
        compounds to assay plates. Used here were the *Low Dead Volume
        (LDV)* variety, which have a working volumne of 2.5-12.5 µl,
        which limits compound waste compared to the standard *Echo*
        plates (12-65 µl).

**Optional:**

-   **Hardware:**

    -   **Bulk liquid dispensing:** can be far more accurate than a
        multichannel pipette when dispensing protein or buffer into
        wells. During development, both a *ThermodropMulti* peristaltic
        dispenser and a *Hamilton Star* liquid handling robot. Both work
        well, though use of a bulk liquid dispensing machine is
        recommended given their speed, lower unit cost and lack of
        requirement for pipette tips.

    -   **Microplate reader plate loader:** Autoloading plates into the
        reader increases throughput capacity significantly. I used a
        **BMG ClarioStar** plate reader with a stacker module.

-   **Consumables:**

    -   **BSA:** in assay buffer may have a stabilizing effect on the
        enzyme - which would improve time stability and reduce errors.
        Time stability is important for scalability.

    -   **384 well Labcyte Echo DMSO Trays:** for control for DMSO
        concentration in assay wells by topping up each assay plate to a
        fixed concentration. Around 5% is ok with BM3.

### Procedure

**Summary:**

1.  **Design *Echo* picklists:**

    -   An *Echo* can accept a `csv` file with column headers:
        `Transfer Volume`, `Volume`, `Destination Well`, `Source Well`
        and optionally: `Destination Plate Name` and
        `Source Plate Name`. The Volume must be in nano litres and a
        multiple of 2.5 and the Source and Destination wells must be in
        the format `[A-Z][0-9]+` and exist in the plate layout specified
        to the *Echo* client at runtime.

    -   The picklist(s) can be generated in a spreadsheet exported to
        `.csv` or programmatically. Documentation for the `python` tools
        used are \[documented here.\](picklists.md)

2.  **Dispense compounds into *Echo* source plates** This can be done
    with a multichannel pipette, and requires one tip per compound. If
    the total volume of each compound required is greater than 60 µl
    then a standard polypropylene *Echo* plate should be used, otherwise
    a low dead volume plate may be economical If not, or for valuable
    compounds, Low Dead Volume *Echo* may plates should be used. These
    have a working volume of 2.5-12.5 µl, outside of which the *Echo*
    will refuse to dispense. You may need to dispense the same compounds
    into multiple source wells and the picklists must be designed
    accordingly.

3.  **Dispense compounds from *Echo* source plates to empty assay
    plates**

    1.  Transfer the picklist `.csv` to the *Echo* host computer.

    2.  Launch the *Echo Plate Reformat* client there:

    3.  Create New Protocol

    4.  Select Custom Region Definitions

    5.  `File` \> `Import Regions` and select your picklist `.csv`

    6.  **Optional:** Specify the log output in `Options`, simulate with
        `Run` \> `Simulate`

    7.  Save and run, optionally simulating the run first. Multiple
        copies of a set of destination plates can be specified if the
        source plates contain sufficient compound volume.

4.  **Stopping point:** Length of pause depends on rate of DMSO
    evaporation from destination/assay plates and the stability of the
    compounds at the plate storage conditions. Plates stored in a stack
    should limit evaporation rate to an extent, though specialised lids
    for *Echo* plates that limit DMSO evaporation are available. Up to
    24 hours seems ok.

5.  **Thaw purified P450, make stock of   10 µM in a neutral buffer,
    enough for 15.36+ ml per plate (40 µl per well)** I heard that
    thawing fast limits ice crystal formation, which could destroy some
    protein. Optionally, in a microcetrifuge, pre-cooled to 4C, spin the
    protein at 14,000 rpm and carefully transferr to fresh tubes to
    remove unfolded protein.

    1.  Measure the stock concentration of the protein in a UV-Vis
        spectrometer by taking an absorbance trace from 200-800 nm,
        diluted in the destination buffer. There should be a peak at 420
        nm, the height of which can be used to calculate the protein
        concentration with the following equation:

        $$ [P450] = a e l$$

        where $a$ is absorbance and $e$ is the extiction coefficient -
        95 for P450 BM3 heme domain. $l$ is the path length in cm and
        for the cuvettes used was 1. Use the measured stock
        concentration of P450 to create a working stock of around 10 µM.
        10µM was chosen because it yeilds a reasonably strong signal
        when in plates. Varying the protein concentration doesn't have a
        big effect on measurements, so err towards using more.

    2.  Dilute in neutral buffer to the target working concentration.
        Filtration through a 22 µm syringe filter can remove some
        precipitates. Vacuum filtration can work too but in practice,
        the protein can pick up binding partners from the filtration
        equipment contaminants, which can ruin downstream measurements.

6.  **Dispense the diluted protein into the assay plates, centrifuge**

    An electric multichannel pipette works but accuracy is more limited
    than with automated dispensing. 38 µl of protein working stock needs
    to be dispensed into each well, which brings the total well volume
    to 40 µl in cases where the volume of compounds in DMSO in each well
    is 2 ul. If the volume of DMSO in destination wells is not a
    constant 2 ul, then default to 38 µl of the protein stock. The
    variation in total volume can be corrected for in compound
    concentration calculations, though the path lenght will vary which
    affects precision.

    Better than that is a precise bulk liquid handling device. I used a
    *ThermodropMulti* for a while which was fast and accurate.
    Occasionally a nozzle would become blocked either with DMSO ice or
    precipitates, though the protein still dispensed into the correct
    well. Blockages can be cleared by disassembling the pump head,
    coupling a syringe of water to the nozzle and flushing.

    It may be necessary to dispense some control plates, with everything
    but protein. This is useful to correct for the intrinsic absorbance
    of the plate and buffer, as well as the compounds themselves which
    sometimes have absorbance at the measurement wavelengths. A control
    set of plates for every protein screen may be unnecessary and
    expensive. One good one should be ok.

    Centrifuge the plates for 2-5 mins at around 2000 rpm to push the
    well contents to the bottom. This step can also ensure that
    meniscuses are flat and uniform and remove bubbles. If possible,
    centrifuge at room temperature to avoid DMSO ice formation.

7.  **Capture UV-Visible light absorbance data between 220 and 800 nm
    from plates in a microplate reader at room temperature within 3
    hours:**

    The protein is fairly stable over the course of 3 hours. On a BMG
    platereader, measurements take about 15 minutes per plate including
    the data transfer from device to host machine. Using an automated
    plate loader is recommended, for example a BMG Stacker module. In
    that case, put an empty or waste plate on the top of the stack to
    limit evaporation from the top assay plate. The BMG ClarioStar can
    be instructed not to read the last plate.

    The stacker occasionally jams due to a solenoid error, which can be
    due to a misaligned stack of plates. It is advisable to un-stack and
    re-stack the plates using the stacker to check for this kind of
    issue prior to measurement.

8.  **Data analysis overview**

    1.  Export the plate measurement data to a workable format, like
        `.csv`. In the BMG Mars software, the operation is simple but on
        all host machines I've tried it on have been unreasonably slow
        to open the data files prior to export.

    2.  Index the files to their experiments. I used a `config.yml` file
        to track this.

    3.  **Analysis**

        1.  Match compounds to plate well data.

        2.  Match the *Echo* exceptions report to wells to find the
            actual compound volume in each well.

        3.  From each trace, subtract its own absorbance $A_{800}$ at
            800 nm. This accounts for baseline drift which can be caused
            by light scattering from precipitates.

        4.  If correcting for compound absorbance with control plates,
            then subtract the absorbance of each test well from each
            control well. If the actual compound volumes of the test and
            control don't match up, it can be an issue if the compound
            interferes with the absorbance in the 390-420 nm region. If
            the compound absorbance changes predictably then it can be
            interpolated.

        5.  Curves can be smoothed with Gaussian smoothing using
            `scipy.ndimage.gaussian_filter1d` if necessary. Sources of a
            jagged curve can be precipitates, which can interfere with
            downstream analysis.

        6.  At this point, changes in the P450 absorbance trace can be
            identified. Common categories of trace are:

            -   Clean absorbance trace, no shift.

            -   Clean absorbance trace, peak shift from 420 to 390 nm.

            -   Clean absorbance trace, peak shift from 420 to 424 nm.

            -   Compound interference in absorbance trace.

            -   Light scattering in absorbance trace.

        7.  For clean traces with a peak shift from 420 to 390 or 424
            nm, biding response can be calculated using the
            $|\Delta A{390}| - |\Delta A_{420}|$ or
            $|\Delta A{420}| - |\Delta A_{420}|$ for each compound
            concentration. With a set of concentration-response data
            points, the binding dissociation constant $K_d$ can be
            calculated using the Michaelis-Menten equation for enzyme
            kinetics:

            $$Response = \frac{V_{max} \times [S]}{K_{d} + [S]}$$

            $$Response = |\Delta A_{390}| - |\Delta A_{420}|$$

            Where $[S]$ is a given substrate concentration and $V_{max}$
            is the maximum response magnitude possible from the P450
            being tested from this compound. The metrics $K_d$ and
            $V_{max}$ can be derived by fitting
            $|\Delta A{390}| - |\Delta A_{420}|= \frac{V_{max} \times [S]}{K_{d} + [S]}$
            can be fit to the P450 substrate concentration-response data
            points using a curve fit algorithm like
            `scipy.optimize.curve_fit`.

            Useful additional metrics for each compound are $R^2$ score
            of the curve fit, a data quality metric.

            An ideal end output of this analysis as a table of
            compounds, P450s and a qualification or quantification of
            their binding interactions.

## Enzyme Production

### Summary

This page contains the methods for producing the enzymes used in this
screening program. The enzymes are variants of the Cytochrome P450 BM3:

| **ID**  |**Mutations**  |**PDB** |
| --------|---------------|--------|
| WT      |               |1BU7    |
| A82F    |A82F           |4KEW    |
| DM      |A82F/F87V      |4KEY    |
| 1YQO    |T268A          |1YQO    |
| 1YQP    |T268N          |1YQP    |

BM3 mutants used in screening.

The page shows the method used to create the mutant BM3 expression
plasmid DNA, expression of the mutants in *E. coli* and their
purification.

### Aims

-   Create expression plasmids containing the target mutants from an
    in-house starting point - `bm3-wt.gb`.

-   Sequence the plasmids to confirm they carry the mutations

-   Express the mutants in *E. coli* using those plasmids.

-   Purify the mutant protein from the *E. coli* harvest.

### DNA

### Starting Material

An heirloom BM3 Wild-type (heme domain) expression plasmid, `bm3-wt.gb`,
was inherited and used as the basis for DNA work in this project. The
plasmid is a pET14 expression vector where the BM3 gene has a 6xHis
purification tag at the N-terminus, flanked by a T7 promoter and
terminator which leads to high yields in strains of *E. coli* containing
the T7 RNA polymerase. The plasmid also encodes ampicillin resistance
and a *ColE1* replication origin which leads to a low copy number.

### Primer Design and Acquisition

Mutations were introduced to the wild-type sequence via Polymerase Chain
Reaction (PCR)-based site-directed mutagenesis. Two methods were
considered for this task based on commercially available kits, where
each imposes different constraints on primer design. Efforts were made
to automate primer design as far as possible with scalability in mind.

The PCR kits used were:

1.  *New England Biolabs (NEB) Q5 mutagenesis kit* - which requires that
    primers facilitate cloning of a linear DNA strand from the circular
    template plasmid and mutation payloads are carried in the tail of
    one primer. The kit includes a cocktail of the DNAse *DPN1*, which
    disassembles template plasmid methylated in *E. coli* and a kinase
    and ligase that work to join the ends of the linear DNA into a
    circular plasmid. The reaction is restricted to one payload.

2.  *Agilent Quickchange mutagenesis kit* - which requires a pair of
    overlapping primers that carry the mutation payload in the
    mid-section. This cloning method produces circular DNA carrying the
    targeted changes. It has the advantage of allowing multiple payloads
    carried by multiple primer sets.

Two important considerations based on the template sequence are:

1.  Adenine-Thymine (AT) richness of the template sequence. Compared to
    cytosine and guanine (C and G), A and T bind to their complimentary
    bases weakly. This results in weak primer binding to the template
    sequence, measurable by a low primer *melting temperature* $T_m$. To
    compensate, primers must be longer than they otherwise would be for
    a sequence richer in CG, which increases their cost and their chance
    of self-binding. The template sequence used here is AT-rich - at
    42%.

2.  Repetitions and palindromic regions of the template sequence. If the
    sequence surrounding a mutation target area contains these features,
    then the likelihood of *mis-priming* by binding to an off-target
    sequence area is high, so too is the likelihood of a non-functional,
    self-binding primer.

**note: talk about `mxn`**

### PCR and Work Up

### Sequencing

Purified plasmid DNA ostensibly conataining the target mutations, having
been harvested and purified from DH5a *E. coli* cells, was shipped to
*Eurofins Genomics* for sequencing using their *TubeSeq* service, which
uses a variant of Sanger Sequencing. Sequencing primers for this matched
the T7 promoter and terminator and provided coverage of the targetted
region.

**note: include sequencing, flesh out**

## Protein Expression

Having been sequenced and confirmed to carry the target mutations, the
mutant plasmids were used to produce the mutant protein *en masse* via a
*BL21 DE3 E. coli* strain, which contains a T7 RNA polymerase under the
control of a *lac* promoter.

BM3 mutants were expressed in *NEB* BL21 (DE3) *E. coli* cells grown in
*Formedium* auto-induction TB media at 25°C for 24 hours with shaking at
180 rpm. Cells were harvested by centrifugation in a *Beckman* JA16
rotor at 6000 rpm for 10 minutes and stored at -20 °C. Variants were
purified from the cells by nickel-affinity chromatography, dialysis into
buffer 1, concentration to 500-1000 µM and storage at -80 °C.

### Materials

-   Expression plasmid encoding mutant P450 BM3

-   *BL21 DE3 E. coli* - NEB. This domesticated *E.coli* strain is
    shipped in a transformation buffer.

-   Auto-induction *Terrific Broth* (TB) media, which contains glucose
    and a lactose analog. The lactose analog triggers expression of T7
    RNA-polymerase in *BL21 DE3 E. coli* and the subsequent expression
    of the target protein between the T7 promoter and terminator
    regions. The glucose inhibits this until it is consumed by the
    cells, which allows them to multiply to sufficient numbers before
    diverting energy to production of the target protein.

-   Ampicillin - the antibiotic for which resistance is encoded in the
    target plasmid, ensuring that all cells in the growth media contain
    this resistance. Assuming no ampicillin-resistant contaminants, all
    cells should be *BL21 DE3 E. coli* containing the target plasmid.

-   $\Delta$ Amino-Levulnic acid ($\Delta$-ALA) - a precursor to heme,
    ensuring heme availability for the large amount of BM3.

### Method

### Purification

## Screening

Throughput the screening process, the protocol described in section
[2.3.2](#protocol){reference-type="ref" reference="protocol"} was
employed. Six concentrations of each target compound were dispensed with
the aim of determination of the $V_{max}$ and $K_d$: 0.0, 5.26, 55.61,
156.72, 306.74 and 500 µM. These values were generated from six linearly
spaced values between 0 and 1 squared, then scaled to the starting
concentration and final volume. This method saved some compound compared
to a straightforward linear spacing of values between 0 and 500 µM - the
maximum concentration possible given a 10 mM starting stock in DMSO
without exceeding a total of 5% v/v solvent.

During the first run, control experiments where compounds were present
in buffer only were included for downstream correction of the compounds
inherent UV-Visible light absorbance, though it was thought to be
unnecessary to repeat this for each subsequent screen, since it is
wasteful of resources, particularly the compounds themselves.

Each of the five enzymes was screened against all 980 compounds over the
course of a day each.

## Model Design and Construction

The model aims to predict the binding likelihood between a given protein
sequence and chemical structure, illustrated in equation

$$P_{binding} = fn(sequence, smiles)$$

This page describes the deep learning model constructed for this
project. The model is designed to estimate the likelihood of a binding
interaction between a given Cytochrome P450 sequence and a ligand SMILES
code. The intended end uses of the model are:

1.  Virtually screening sequences for potential activity with a given
    compound.

2.  Optimally design an enzyme-ligand screening experiment.

### Approach: Recommender Systems

Abstractly, the problem of predicting the binding likelihood between a
one of $m$ proteins and one of $n$ small molecules can be likened to
filling empty the values of an $n \times m$ matrix, where rows and
columns refer to proteins and small molecules and values are the
probability of a binding interaction between the two:

$\begin{matrix} 
     & compound_i & compound_{i+1} & ... & compound_{i+n} \\
    sequence_i  & P_{binding_{i,j}} &  &  & \\  
    sequence_{i+1} &  &  &  &  \\
     \vdots &  &  & \ddots &  \\
    sequence_{i+m} &  &  &  &   \\
\end{matrix}$

Some $P_{binding}$ values are known, which in the perspective of
$n \times m$ possible values where $n$ and $m$ approach infinity,
coverage is sparse.

This type of problem has been addressed in recommender systems, which in
the context of streaming services translates to a matrix of $n$ users
and $m$ paces of content. Known values are likes and engagement metrics
and are similarly sparse, and blanks can be filled with the probability
of a successful recommendation.

Machine learning models can be trained to predict the unknown values
based on a numerical representation of the user and content. The
prediction can be cast as a classification problem. To overcome the lack
of negative data points, presumed negative data can be generated by
sampling a random user: content pair, which should be treated with
caution.

In this work, a machine learning model classifies pairs of protein
sequence and small molecules as binding or not. Negative samples are
generated by randomly sampling a sequence and small molecule, which
given the vastness of sequence and chemical space may be reasonable in a
large number of cases, though this assumption is treated with caution. A
Binary Cross Entropy loss function is employed here where true positives
and synthesized negatives are weighted evenly.

### Data

Small molecules are represented as SMILES codes in the dataset, which
are parsed using `rdkit` and then into 2048 bit fingerprint vectors
using the `RdkitFingerprint`. Molecular fingerprints are generated by
hashing functions based on an input molecule such that similar molecules
are assigned similar fingerprints, which makes them useful in
featurizing small molecules for machine learning tasks. The fingerprints
are represented as a $b \times 2048$ tensor where $b$ is batch size.

Sequences are represented in the dataset as strings where each character
$c_i$ is a single letter amino acid code:

$$c_i \subset{ACDEFGHIKLMNPQRSTVWY}$$

Roughly, characters are encoded as tensors of the integers that index
their position in the list
$\begin{matrix} ACDEFGHIKLMNPQRSTVWY\end{matrix}$, with extra positions
to represent null values, start of frame and end of frame characters.

### Pre-Training Data

A dataset of around $10^6$ protein sequences and SMILES codes for their
corresponding binding partners are gathered here from several sources.

There are several sources of data containing protein sequences and
information on their binding partners.

-   [Uniprot](https://www.uniprot.org/) is a large, publicly available
    database containing protein sequences and a variety of functional
    annotations. *Uniprot* comprises three databases:

-   *UniProt Knowledgebase (UniprotKB)* contains protein sequences and
    their annotations. *UniprotKB* mainly comprises two collections:

-   *SProt:* - The SwissProt collection. Manually annotated and
    non-redundant protein sequences. Annotations can include *Enzyme
    Comission (EC)* classification numbers, which can be linked to
    substrates and products. At the time of collection (2022) the
    *SProt* collection contains 1,706,449 data points.

-   *Trembl:* - The TrEMBL collection. Automatic annotations, N data
    points.

-   *UniProt Archive (UniParc)* - an archive of sequences pooled from
    other public protein sequence databases. This collection does not
    contain annotations.

-   *UniProt Reference Clusters (UniRef)* - Three collections of
    clustered sequences from *UniprotKB* and *UniParc*. Each collection
    is clustered with the CD-HIT algorithm and a different similarity
    cutoff: *UniRef100*, *UniRef90* and *UniRef50* use 100, 90 and 50%
    respectively. In the case of UniRef100, similarity measurements are
    made against sequence fragments. The clusters do not contain
    annotations. Importantly: *Uniprot* files can be freely downloaded
    via an `ftp` server at
    <https://ftp.uniprot.org/pub/databases/uniprot/current_release/uniref/>

-   [KEGG](https://www.genome.jp/kegg/) is another large source of
    proteins and biological function annotations, though download of the
    full dataset is restricted to paying customers. *KEGG* does however
    have a *REST API* which can be used to query the database, though
    requests are handled somewhat slowly. Despite this limitation, it
    was useful to cross-reference *EC* numbers against substrate and
    product identities.

-   [BindingDB](https://www.bindingdb.org/bind/index.jsp) is a large
    collection of proteins and known small molecule binding partners
    mostly derived from high throughput drug screening datasets, which
    is reflected in the chemical diversity of the set.

-   [PDBBind](http://pdbbind.org.cn/) contains protein sequences and
    structures and their binding ligands derived from the *Protein
    DataBank (PDB)*.

-   [BRENDA](https://www.brenda-enzymes.org/) contains manual curations
    from primary literature for enzymes.

For this work, the Uniprot SProt and BindingDB collections were selected
because they met the necessary requirements of containing protein
sequences that can be matched to a chemical binding partner. For data
mining a cloud machine was hired (Linode `g6-dedicated-8`, 1TB Disk
space, 8 `x86_64` cpus, 16 GB RAM, Debian 10, New Jerse Scripts used
here are in `screening-fist/data/pretraining/scripts/`.

Large files and files in large numbers can prove slow to search, a
problem that databases address. For this work, a database was set up on
the hired machine for storage and retrieval of the mined data. MongoDB,
an unstructured database, was chosen.

MongoDB is unstructured in as far as it does not store tabular data,
instead opting for a `json`-like schema which uses attribute:value
arrays that themselves can contain more attribute:value arrays. This
offers considerable flexibility in data input from heterogeneous sources
with varying presence, absence and categories of annotation.

SProt was gathered as a compressed `.dat` file using
`screening-fist/data/pretraining/scripts/uniprot.sh`, which
decompresses, parses entries and uploads them to the local MongoDB in a
single UNIX pipe. Using a single pipe saves the need to store the
decompressed file on disk, which becomes significant in the case of the
`TrEMBL` collection which has an uncompressed size of around 700GB as
opposed to the 3.5GB of `sprot`.

BRENDA was used for its comprehensive list of EC numbers which would
later be used for reference. BindingDB was downloaded in full as a
`.tsv` file. Both the BRENDA and BindingDB sets were downloaded using
`curl` commands and BindingDB was uploaded to the MongoDB instance.

The EC numbers from BRENDA were used with the KEGG REST API to
collection compound identification numbers, which in turn were used to
retrieve SMILES codes from PubChem using the script `ec.py`
`mkdataset1.py` was used to assemble a `csv` containing protein
sequences and SMILES codes of their binding partners (1,587,674), which
was further filtered to exclude SMILES codes and sequences that could
not be parsed using RDKit and the tokenizer used in the sequence model.

Finally, an attempt to improve the chemical diversity of the
pre-training dataset was made. A diversity filter that aims to return a
subset of a compound set by maximizing the pairwise Tanimoto similarity
of the subset compound fingerprints was employed using the MaxMin
algorithm.

Unfortunately, MaxMin is $O(n^2)$ complexity, so is only feasible with
relatively small batches. 64 compounds are selected this way from each
batch of 512 from the filtered set, yielding `o3.csv` (1359834 data
points and 908M uncompressed size).

`o3.csv` was compressed with `gzip` and loaded to an area of *Linode*
object storage in Frankfurt, making it accessible to the *Linode*
instances that would be used for model training.

`o3.csv` contained at least one invalid SMILES or sequences which had
the costly effect of crashing the first model training run. A filter for
troublesome inputs was built and yeilded `o3f.csv` (826 MB). and For the
purposes of model training and evaluation, the `o3f.csv` dataset was
split 3:1 into a training and test datasets `o3f.train.csv` and
`o3f.test.csv` of sizes 907214 and 226804 respectively.

### Training Data

### Model Architecture

Given the model aims to predict: $$P_{binding} = fn(sequence, smiles)$$

A neural network was devised to generate a prediction of $P_{binding}$
from an input of a protein sequence and a chemical SMILES code. The
network can be split into three parts:

-   **Sequence Embedding:** For a given protein $sequence$, output a
    tensor encoding a neural embedding $z_{sequence}$.

-   **Chemical Embedding:** For a given chemical $smiles$ encoding,
    outputs an embedding $z_{smiles}$.

-   **Prediction Head:** For the embeddings $z_{smiles}$ and
    $z_{sequence}$, output a prediction $P_{binding}$.

The architecture is illustrated in
[2.5](#modelarch){reference-type="ref" reference="modelarch"}.

![[\[modelarch\]]{#modelarch label="modelarch"} Architecture of the
model constructed for this project](img/model.png){#modelarch
height="0.8\\textheight"}

### Sequence Embedding

Although this model is the smallest of the ESM collection, on the single
*NVIDIA Quadro RTX 6000* used it still occupied most of the 24 GB of
available memory and most of the processing capability, which lead to
long training times and difficulty in training more than one model in
parallel on the same machine.

This could be remedied, however since in the complete `o3f.csv` dataset
and the screening dataset there are 2947 unique sequences, so it was
economical to pre-compute the embeddings and save them to disk. This
resulted in a roughly 4$\times$ speedup in training time and massively
reduced the memory requirements, allowing several models to be trained
in parallel on a single GPU. This also saved costs significantly.

### Chemical Embedding

As mentioned, chemical SMILES were hashed into chemical fingerprints
using the `rdkit` `RDKFingerprint` method as a means of representation,
yielding a 2048-bit vector for each compoundagainThe vectors were
converted to tensors and served as an input to a residual neural network
that output an embedding that would later be used to form a combined
representation of both compound and sequence for binding likelihood
prediction.

### Prediction Head

The combined sequence and compound embeddings served as input to the
prediction head, which output a single number that indicated a binding
likelihood prediction for the two inputs.

Both residual neural networks and transformers were compared as
prediction head architectures. Each consisted of 2-6 stacked layers of
either residual or transformer layers with a fixed hidden layer size for
convenience of automated assembly. The final layer in both cases was a
single linear layer with a single output and a sigmoid function to
output a number between 0 and 1 representing binding probability.

### Pre-Training, Training and Evaluation

Training was done in two stages, each with a performance evaluation,
during which several models with varying architectures and
hyper-parameters were trained and compared. All training was done on a
*Linode* `g1-gpu-rtx6000-1` in New Jersey which cost \$1.50 per hour and
was equipped with hardware specifications described in **table
[2.5](#hardwaretable){reference-type="ref" reference="hardwaretable"}**.

| **Item**  |**Specifications**                        |**Number** | **Size**    |
|-----------|------------------------------------------|-----------|-------------|
| CPU       |Intel(R) Xeon(R) Gold 6148 CPU @ 2.40GHz  |8          |             |
| RAM       |?                                         |N/A        | 30 GB       |
| Disk      |?                                         |1          | 630 GB      |
| GPU       |NVIDIA Quadro RTX 6000                    |1          | 20 GB VRAM  |

Hardware specifications for machine used in model training.

1.  **Pre-Training:** This was done with the larger, more general `o3f`
    dataset, which was randomly split into training and validation
    partitions, the latter of which was used sparingly to avoid model
    bias. Pre-training lasted up to 64 epochs with a batch size up to
    64. For each sample, a random sequence and SMILES pair were sampled
    as a presumed negative sample. The loss function used was binary
    cross entropy used with an Adam (Adaptive momentum) optimizer. Loss
    was tracked live using the *Weights and Biases* API which was useful
    to evaluate models as they trained and terminate them where
    necessary. Model weights were saved in each epoch and after training
    the model was evaluated for precision and accuracy on a subset of
    the training data. The metrics gathered were:

    1.  Mean binary cross entropy loss over evaluation.

    2.  Mean precision

    3.  A confusion matrix

    4.  A receiver operator curve (ROC)

    5.  A precision recall curve

    6.  A detection error trade-off (DET) curve

2.  **Training:** This was done with the manually annotated screening
    dataset. An issue with the data was the class imbalance in that
    there were very few positive examples relative to negative. This was
    addressed by using *Synthetic Minority Oversampling* (SMOTE) whereby
    the rarer positive data were re-sampled until they number that of
    the negative data. The total size of the re-sampled data was 6666
    points, which were then split 3:1 into training and validation sets
    of size 4999 and 1667 respectively. A model pre-trained on the
    larger `o3f` dataset was re-trained on this set and evaluated for
    performance in the same manner as with the `o3f` data, visualised in
    the following section.

### Evaluation


