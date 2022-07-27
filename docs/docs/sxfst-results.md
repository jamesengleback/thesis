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

Below is a table showing the hits from the manual annotation approach, including their molecular scaffolds as determined by *Murcko Decomposition*[@bemis1996properties].

| Experiment   | Protein       | Chem Id   | Item Name                                 | Structure                            | Scaffold                            |
|:-------------|:--------------|:---------|:------------------------------------------|:-------------------------------|:----------------------------------------|
| 03.0/        | BM3 Heme A82F | S1884    | Sparfloxacin                              | ![](img/screen/hits-S1884.png) | ![](img/screen/hits-S1884-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S3172    | Anagrelide HCl                            | ![](img/screen/hits-S3172.png) | ![](img/screen/hits-S3172-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S1488    | Naratriptan HCl                           | ![](img/screen/hits-S1488.png) | ![](img/screen/hits-S1488-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4114    | Triclabendazole                           | ![](img/screen/hits-S4114.png) | ![](img/screen/hits-S4114-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S1465    | Moxifloxacin hydrochloride                | ![](img/screen/hits-S1465.png) | ![](img/screen/hits-S1465-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2409    | 10-Deacetylbaccatin-III                   | ![](img/screen/hits-S2409.png) | ![](img/screen/hits-S2409-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2067    | Ozagrel HCl                               | ![](img/screen/hits-S2067.png) | ![](img/screen/hits-S2067-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4274    | Rotigotine                                | ![](img/screen/hits-S4274.png) | ![](img/screen/hits-S4274-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2020    | Formoterol hemifumarate                   | ![](img/screen/hits-S2020.png) | ![](img/screen/hits-S2020-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S1890    | Nizatidine                                | ![](img/screen/hits-S1890.png) | ![](img/screen/hits-S1890-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2052    | Oxytetracycline dihydrate                 | ![](img/screen/hits-S2052.png) | ![](img/screen/hits-S2052-scaffold.png) |
| 04.0/        | BM3 Heme 1YQP | S1883    | Idoxuridine                               | ![](img/screen/hits-S1883.png) | ![](img/screen/hits-S1883-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2456    | Chlorpromazine (Sonazine)                 | ![](img/screen/hits-S2456.png) | ![](img/screen/hits-S2456-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2116    | Conivaptan HCl (Vaprisol)                 | ![](img/screen/hits-S2116.png) | ![](img/screen/hits-S2116-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4178    | Climbazole                                | ![](img/screen/hits-S4178.png) | ![](img/screen/hits-S4178-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4349    | Procyclidine HCl                          | ![](img/screen/hits-S4349.png) | ![](img/screen/hits-S4349-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S1705    | Progesterone (Prometrium)                 | ![](img/screen/hits-S1705.png) | ![](img/screen/hits-S1705-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4074    | Sodium nitrite                            | ![](img/screen/hits-S4074.png) | ![](img/screen/hits-S4074-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2381    | D-Mannitol (Osmitrol)                     | ![](img/screen/hits-S2381.png) | ![](img/screen/hits-S2381-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4219    | Azaperone                                 | ![](img/screen/hits-S4219.png) | ![](img/screen/hits-S4219-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S1390    | Ondansetron hydrochloride (Zofran)        | ![](img/screen/hits-S1390.png) | ![](img/screen/hits-S1390-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4169    | Teriflunomide                             | ![](img/screen/hits-S4169.png) | ![](img/screen/hits-S4169-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S1490    | Ponatinib (AP24534)                       | ![](img/screen/hits-S1490.png) | ![](img/screen/hits-S1490-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4213    | Dirithromycin                             | ![](img/screen/hits-S4213.png) | ![](img/screen/hits-S4213-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S1635    | Erythromycin (E-Mycin)                    | ![](img/screen/hits-S1635.png) | ![](img/screen/hits-S1635-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4151    | Penfluridol                               | ![](img/screen/hits-S4151.png) | ![](img/screen/hits-S4151-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2593    | Tolvaptan (OPC-41061)                     | ![](img/screen/hits-S2593.png) | ![](img/screen/hits-S2593-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4205    | Dibenzothiophene                          | ![](img/screen/hits-S4205.png) | ![](img/screen/hits-S4205-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S1576    | Sulfasalazine (Azulfidine)                | ![](img/screen/hits-S1576.png) | ![](img/screen/hits-S1576-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S1880    | Roxatidine acetate HCl                    | ![](img/screen/hits-S1880.png) | ![](img/screen/hits-S1880-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S1547    | Febuxostat (Uloric)                       | ![](img/screen/hits-S1547.png) | ![](img/screen/hits-S1547-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S1897    | Potassium iodide                          | ![](img/screen/hits-S1897.png) | ![](img/screen/hits-S1897-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2451    | Amantadine hydrochloride (Symmetrel)      | ![](img/screen/hits-S2451.png) | ![](img/screen/hits-S2451-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2097    | Ambrisentan                               | ![](img/screen/hits-S2097.png) | ![](img/screen/hits-S2097-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S3170    | Ampicillin sodium                         | ![](img/screen/hits-S3170.png) | ![](img/screen/hits-S3170-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4195    | Broxyquinoline                            | ![](img/screen/hits-S4195.png) | ![](img/screen/hits-S4195-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2502    | Quinine hydrochloride dihydrate           | ![](img/screen/hits-S2502.png) | ![](img/screen/hits-S2502-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4086    | Loxapine Succinate                        | ![](img/screen/hits-S4086.png) | ![](img/screen/hits-S4086-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S1630    | Allopurinol (Zyloprim)                    | ![](img/screen/hits-S1630.png) | ![](img/screen/hits-S1630-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2556    | Rosiglitazone (Avandia)                   | ![](img/screen/hits-S2556.png) | ![](img/screen/hits-S2556-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4095    | Difluprednate                             | ![](img/screen/hits-S4095.png) | ![](img/screen/hits-S4095-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4197    | Bemegride                                 | ![](img/screen/hits-S4197.png) | ![](img/screen/hits-S4197-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4058    | Ropivacaine HCl                           | ![](img/screen/hits-S4058.png) | ![](img/screen/hits-S4058-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S1500    | Betamethasone (Celestone)                 | ![](img/screen/hits-S1500.png) | ![](img/screen/hits-S1500-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4171    | Choline Chloride                          | ![](img/screen/hits-S4171.png) | ![](img/screen/hits-S4171-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2091    | Betaxolol (Betoptic)                      | ![](img/screen/hits-S2091.png) | ![](img/screen/hits-S2091-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4372    | Triflupromazine HCl                       | ![](img/screen/hits-S4372.png) | ![](img/screen/hits-S4372-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S1379    | Isotretinoin                              | ![](img/screen/hits-S1379.png) | ![](img/screen/hits-S1379-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2461    | Domperidone (Motilium)                    | ![](img/screen/hits-S2461.png) | ![](img/screen/hits-S2461-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S1357    | Lidocaine (Alphacaine)                    | ![](img/screen/hits-S1357.png) | ![](img/screen/hits-S1357-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S1408    | Linezolid (Zyvox)                         | ![](img/screen/hits-S1408.png) | ![](img/screen/hits-S1408-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4368    | Carbenoxolone Sodium                      | ![](img/screen/hits-S4368.png) | ![](img/screen/hits-S4368-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4148    | Ampicillin Trihydrate                     | ![](img/screen/hits-S4148.png) | ![](img/screen/hits-S4148-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2529    | Dopamine hydrochloride (Inotropin)        | ![](img/screen/hits-S2529.png) | ![](img/screen/hits-S2529-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4233    | Zoxazolamine                              | ![](img/screen/hits-S4233.png) | ![](img/screen/hits-S4233-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S1894    | Valsartan (Diovan)                        | ![](img/screen/hits-S1894.png) | ![](img/screen/hits-S1894-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S1322    | Dexamethasone                             | ![](img/screen/hits-S1322.png) | ![](img/screen/hits-S1322-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S1304    | Megestrol Acetate                         | ![](img/screen/hits-S1304.png) | ![](img/screen/hits-S1304-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4057    | Methyclothiazide                          | ![](img/screen/hits-S4057.png) | ![](img/screen/hits-S4057-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S1441    | Venlafaxine                               | ![](img/screen/hits-S1441.png) | ![](img/screen/hits-S1441-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2114    | Dronedarone HCl (Multaq)                  | ![](img/screen/hits-S2114.png) | ![](img/screen/hits-S2114-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2104    | Levosulpiride (Levogastrol)               | ![](img/screen/hits-S2104.png) | ![](img/screen/hits-S2104-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4207    | Clofibric acid                            | ![](img/screen/hits-S4207.png) | ![](img/screen/hits-S4207-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S3176    | Betahistine 2HCl                          | ![](img/screen/hits-S3176.png) | ![](img/screen/hits-S3176-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4200    | Tolperisone HCl                           | ![](img/screen/hits-S4200.png) | ![](img/screen/hits-S4200-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4107    | Clofazimine                               | ![](img/screen/hits-S4107.png) | ![](img/screen/hits-S4107-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2506    | Roxithromycin (Roxl-150)                  | ![](img/screen/hits-S2506.png) | ![](img/screen/hits-S2506-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4120    | Sulconazole Nitrate                       | ![](img/screen/hits-S4120.png) | ![](img/screen/hits-S4120-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2111    | Lapatinib                                 | ![](img/screen/hits-S2111.png) | ![](img/screen/hits-S2111-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2460    | Pramipexole (Mirapex)                     | ![](img/screen/hits-S2460.png) | ![](img/screen/hits-S2460-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S3175    | Atomoxetine HCl                           | ![](img/screen/hits-S3175.png) | ![](img/screen/hits-S3175-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4099    | Dexlansoprazole                           | ![](img/screen/hits-S4099.png) | ![](img/screen/hits-S4099-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S1326    | Edaravone (MCI-186)                       | ![](img/screen/hits-S1326.png) | ![](img/screen/hits-S1326-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2452    | Amfebutamone (Bupropion)                  | ![](img/screen/hits-S2452.png) | ![](img/screen/hits-S2452-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2061    | Lovastatin (Mevacor)                      | ![](img/screen/hits-S2061.png) | ![](img/screen/hits-S2061-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2078    | Famotidine (Pepcid)                       | ![](img/screen/hits-S2078.png) | ![](img/screen/hits-S2078-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S1885    | Felodipine (Plendil)                      | ![](img/screen/hits-S1885.png) | ![](img/screen/hits-S1885-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4179    | Mezlocillin Sodium                        | ![](img/screen/hits-S4179.png) | ![](img/screen/hits-S4179-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4364    | Phenothrin                                | ![](img/screen/hits-S4364.png) | ![](img/screen/hits-S4364-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4333    | Mepiroxol                                 | ![](img/screen/hits-S4333.png) | ![](img/screen/hits-S4333-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4192    | Chlorquinaldol                            | ![](img/screen/hits-S4192.png) | ![](img/screen/hits-S4192-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4084    | Lomerizine HCl                            | ![](img/screen/hits-S4084.png) | ![](img/screen/hits-S4084-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2527    | Methacycline hydrochloride (Physiomycine) | ![](img/screen/hits-S2527.png) | ![](img/screen/hits-S2527-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2199    | Aliskiren hemifumarate                    | ![](img/screen/hits-S2199.png) | ![](img/screen/hits-S2199-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4390    | Brucine                                   | ![](img/screen/hits-S4390.png) | ![](img/screen/hits-S4390-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2459    | Clozapine (Clozaril)                      | ![](img/screen/hits-S2459.png) | ![](img/screen/hits-S2459-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S1407    | Bimatoprost                               | ![](img/screen/hits-S1407.png) | ![](img/screen/hits-S1407-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S1443    | Zileuton                                  | ![](img/screen/hits-S1443.png) | ![](img/screen/hits-S1443-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2057    | Cyclophosphamide monohydrate              | ![](img/screen/hits-S2057.png) | ![](img/screen/hits-S2057-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S1878    | Ganciclovir                               | ![](img/screen/hits-S1878.png) | ![](img/screen/hits-S1878-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4370    | Nicotine Ditartrate                       | ![](img/screen/hits-S4370.png) | ![](img/screen/hits-S4370-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2154    | BIBR-1048 (Dabigatran)                    | ![](img/screen/hits-S2154.png) | ![](img/screen/hits-S2154-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2065    | Lafutidine                                | ![](img/screen/hits-S2065.png) | ![](img/screen/hits-S2065-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S1657    | Enalaprilat dihydrate                     | ![](img/screen/hits-S1657.png) | ![](img/screen/hits-S1657-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4082    | Spiramycin                                | ![](img/screen/hits-S4082.png) | ![](img/screen/hits-S4082-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2585    | Brompheniramine                           | ![](img/screen/hits-S2585.png) | ![](img/screen/hits-S2585-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S3162    | Tylosin tartrate                          | ![](img/screen/hits-S3162.png) | ![](img/screen/hits-S3162-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2096    | Almotriptan malate (Axert)                | ![](img/screen/hits-S2096.png) | ![](img/screen/hits-S2096-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4152    | Ethamsylate                               | ![](img/screen/hits-S4152.png) | ![](img/screen/hits-S4152-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S1633    | Zafirlukast (Accolate)                    | ![](img/screen/hits-S1633.png) | ![](img/screen/hits-S1633-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4092    | Pramoxine HCl                             | ![](img/screen/hits-S4092.png) | ![](img/screen/hits-S4092-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S1376    | Gestodene                                 | ![](img/screen/hits-S1376.png) | ![](img/screen/hits-S1376-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S1881    | Protionamide (Prothionamide)              | ![](img/screen/hits-S1881.png) | ![](img/screen/hits-S1881-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4162    | Benzethonium chloride                     | ![](img/screen/hits-S4162.png) | ![](img/screen/hits-S4162-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2079    | Moexipril HCl                             | ![](img/screen/hits-S2079.png) | ![](img/screen/hits-S2079-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4303    | 9-Aminoacridine                           | ![](img/screen/hits-S4303.png) | ![](img/screen/hits-S4303-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2015    | Suplatast tosylate                        | ![](img/screen/hits-S2015.png) | ![](img/screen/hits-S2015-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2090    | Dexmedetomidine HCl (Precedex)            | ![](img/screen/hits-S2090.png) | ![](img/screen/hits-S2090-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S1618    | Sulfameter (Bayrena)                      | ![](img/screen/hits-S1618.png) | ![](img/screen/hits-S1618-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S1902    | Vitamin B12                               | ![](img/screen/hits-S1902.png) | ![](img/screen/hits-S1902-scaffold.png) |
| 05.0/        | BM3 Heme 1YQO | S3179    | Carbenicillin disodium                    | ![](img/screen/hits-S3179.png) | ![](img/screen/hits-S3179-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4056    | Retapamulin                               | ![](img/screen/hits-S4056.png) | ![](img/screen/hits-S4056-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2536    | Miconazole (Monistat)                     | ![](img/screen/hits-S2536.png) | ![](img/screen/hits-S2536-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2553    | 5-Aminolevulinic acid hydrochloride       | ![](img/screen/hits-S2553.png) | ![](img/screen/hits-S2553-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4101    | Voglibose                                 | ![](img/screen/hits-S4101.png) | ![](img/screen/hits-S4101-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S1381    | Meropenem                                 | ![](img/screen/hits-S1381.png) | ![](img/screen/hits-S1381-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4199    | Antazoline HCl                            | ![](img/screen/hits-S4199.png) | ![](img/screen/hits-S4199-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2410    | Paeoniflorin                              | ![](img/screen/hits-S2410.png) | ![](img/screen/hits-S2410-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4167    | Cyromazine                                | ![](img/screen/hits-S4167.png) | ![](img/screen/hits-S4167-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2101    | Gabexate mesylate                         | ![](img/screen/hits-S2101.png) | ![](img/screen/hits-S2101-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4342    | Nialamide                                 | ![](img/screen/hits-S4342.png) | ![](img/screen/hits-S4342-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2043    | Memantine HCl (Namenda)                   | ![](img/screen/hits-S2043.png) | ![](img/screen/hits-S2043-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2086    | Ivabradine HCl (Procoralan)               | ![](img/screen/hits-S2086.png) | ![](img/screen/hits-S2086-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2060    | Bromhexine HCl                            | ![](img/screen/hits-S2060.png) | ![](img/screen/hits-S2060-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S1677    | Chloramphenicol (Chloromycetin)           | ![](img/screen/hits-S1677.png) | ![](img/screen/hits-S1677-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S1351    | Ivermectin                                | ![](img/screen/hits-S1351.png) | ![](img/screen/hits-S1351-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2092    | Detomidine HCl                            | ![](img/screen/hits-S2092.png) | ![](img/screen/hits-S2092-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4240    | Doxylamine Succinate                      | ![](img/screen/hits-S4240.png) | ![](img/screen/hits-S4240-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4382    | Pyrilamine Maleate                        | ![](img/screen/hits-S4382.png) | ![](img/screen/hits-S4382-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S1468    | Alfacalcidol                              | ![](img/screen/hits-S1468.png) | ![](img/screen/hits-S1468-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2376    | Ammonium Glycyrrhizinate                  | ![](img/screen/hits-S2376.png) | ![](img/screen/hits-S2376-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4078    | Mefenamic acid                            | ![](img/screen/hits-S4078.png) | ![](img/screen/hits-S4078-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2130    | Atropine sulfate monohydrate              | ![](img/screen/hits-S2130.png) | ![](img/screen/hits-S2130-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4046    | Estradiol Cypionate                       | ![](img/screen/hits-S4046.png) | ![](img/screen/hits-S4046-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4343    | Oxethazaine                               | ![](img/screen/hits-S4343.png) | ![](img/screen/hits-S4343-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2533    | Ritodrine hydrochloride (Yutopar)         | ![](img/screen/hits-S2533.png) | ![](img/screen/hits-S2533-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4173    | 1-Hexadecanol                             | ![](img/screen/hits-S4173.png) | ![](img/screen/hits-S4173-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2103    | Naltrexone HCl                            | ![](img/screen/hits-S2103.png) | ![](img/screen/hits-S2103-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2443    | Tolbutamide                               | ![](img/screen/hits-S2443.png) | ![](img/screen/hits-S2443-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4204    | Isosorbide                                | ![](img/screen/hits-S4204.png) | ![](img/screen/hits-S4204-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4159    | Bezafibrate                               | ![](img/screen/hits-S4159.png) | ![](img/screen/hits-S4159-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S1692    | Busulfan (Myleran, Busulfex)              | ![](img/screen/hits-S1692.png) | ![](img/screen/hits-S1692-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S2123    | Dextrose (D-glucose)                      | ![](img/screen/hits-S2123.png) | ![](img/screen/hits-S2123-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4365    | Phthalylsulfacetamide                     | ![](img/screen/hits-S4365.png) | ![](img/screen/hits-S4365-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4116    | Isovaleramide                             | ![](img/screen/hits-S4116.png) | ![](img/screen/hits-S4116-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4371    | Pridinol Methanesulfonate                 | ![](img/screen/hits-S4371.png) | ![](img/screen/hits-S4371-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S1680    | Disulfiram (Antabuse)                     | ![](img/screen/hits-S1680.png) | ![](img/screen/hits-S1680-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S1397    | Rocuronium bromide                        | ![](img/screen/hits-S1397.png) | ![](img/screen/hits-S1397-scaffold.png) |
| 03.0/        | BM3 Heme A82F | S4085    | Levobetaxolol HCl                         | ![](img/screen/hits-S4085.png) | ![](img/screen/hits-S4085-scaffold.png) |

### Data Description

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

