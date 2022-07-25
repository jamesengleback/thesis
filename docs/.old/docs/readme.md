hosted @ [`jamesengleback.xyz`](jamesengleback.xyz)
# Introduction 

## Contents

- [Project Overview](#projectoverview)
	- [Aim](#aim)
	- [Virtual Directed Evolution](#vde)
	- [Machine Learning-Based Design](#mldesign)
- [Herbicide Resistance Engineering](#herbicideresistanceengineering)
	- [Metabolic Bypassing](#metabolicbypass)
	- [Metabolic Deactivation](#metabolicdeactivation)
	- [Mesotrione: The Target Herbicide ](#mesotrione) 
		- [Mechanism of Action](#mesotrionemoa)
		- [Crop/Weed Selectivity](#mesotrioneselectivity)
		- [Mechanisms of Natural Resistance](#mesotrionereesistance)
		- [Metabolic Deactivation Engineering](#mesotrioneengineering)
- [P450s and BM3: The Design Template](#p450s) 
	- [P450s Function, Structure, Evolution](#p450sfn) 
	- [P450 Analytical Techniques](#p450analytical) 
- [Enzyme Design Strategies](#enzymedesign) 
	- [Directed Evolution](#directedevolution) 
	- [Virtual Directed Evolution ](#vde) 
	- [Machine Learning-Based Design ](#mldesign)
- [Open Source and `git`](#git)

-------------

### notes
- the herbicide-related sections are currently pasted from my first year lit review, so will need cleaning, referencing etc


------------

<a name="projectoverview" ></a>

## Project Overview 


This project has two peices of work both with the aim to engineer a P450 BM3 mutant with some sort of metabolic activity towards the herbicide mesotrione, ideally hydroxylation at carbon 5. 

One approach uses classical structure prediction and docking combined with a genetic algorithm to generate mutantions with predicted activity. 
Prediction of BM3-mutant binding will be used as a fitness metric in virtual directed evolution experiments. The resulting mutants will be made and tested for predicted activity in the lab. 

The other uses a deep learning model trained on screening data of BM3 mutant binding with herbicide-like compounds, with the aim of being able to predict the activity of any BM3 mutant with any herbicide.
This work involves high-throughput screening of BM3 mutants against herbicide-like compounds.
Mutants resulting from virtual directed evolution experiments using the deep learning model for fitness estimation will be made in the lab and tested for predicted activity. 

<a name="aim" ></a>

### Aim


Mesotrione is an important herbicide whose metabolism in plants is initiated by hydroxylation of carbon 5 by a P450. Given the promiscuity of glutathione-S transferases that help sequester a hydroxylated xenobiotic, alternative hydroxylation sites may be sufficient to initiate herbicide metabolism in plants.
A BM3 mutant that hydroxylates mesotrione at any position may be suitable for engineering mesotrione resistance into a crop. 

<a name="vde"></a>

### Virtual Directed Evolution 

The two approaches developed here are based on traditional structure-based methods and one based on machine learning. 
Both approaches will produce a pool of BM3 variants with predicted binding activity towards mesotrione, for whom $K_d$, $K_{cat}$, $K_M$ and product formation will be measured. 
In this document, this project is referred to as `enz`. 

<a name="mldesign"></a>
  
### Machine Learning-Based Design 

An artificial intelligence-based approach uses a deep neural network to predict the likelihood of binding between input amino acid sequences and chemical smiles and design lab experiments.
The network is trained on data of $K_d$ between 5-10 BM3 mutants and around 100 herbicide-like compounds, and will be used to make $K_d$ predictions for pairs of amino acid sequences and compound. 

The screening data is generated in the lab using a high-throughput UV-Vis assay for measuring $K_d$.

The trained model can estimate $K_d$ rapidly and at scale, and is used for large-scale virtual directed evolution experiments selecting for mesotrione affinity to generate pools of new BM3 mutants to be made in the lab and tested for predicted activity.

Both approaches generate pools of BM3 mutant sequences with predicted binding activity for mesotrione. The lab validation process is:

-  Preparation of expression plasmids will be done using site-directed mutagenesis. Several BM3 mutant plasmids are in stock and can serve as starting points. The search depth of the models will be limited to reduce the number of mutagenesis steps. 
-  Expression of BM3 mutants in E. coli is fairly robust. Two mutants per shaker should yeild sufficient protein for testing. The full length protien will be expressed.
-  Purification by a single Nickel-affinity chromatography step is sufficient to reliably yeild BM3 mutants at a purity suitable for measuring $K_{cat}$, $K_d$, $K_m$ and product formation.
-  Measurement:
	- $K_d$ will be measured by titration of compound into BM3 with UV-Vis measurements. This experiment typically lasts 20 minutes.
	- $K_m$ and $K_{cat}$ will be measured by monitoring NADPH consumption at 340 nm.
	- Product formation will be detected my LCMS of a turnover reaction. Indication of any mesotrione metabolite is the target. Further elucidation is future work.


<a name="herbicideresistanceengineering"></a>

## Herbicide Resistance Engineering

Herbicide resistance can be engineered into crops by introduction of sets of genes that confer metabolic tolerance to a given herbicide. Resistance mechanisms can generally be classed as **1)** A metobolic bybass: the inhibition target of the herbicide is replaced or complemented with a variant that tolerates the herbicide. **2)** Metabolic deactivation: genes are introduced that aid in metabolism and detoxification of the herbicide.

<a name="metabolicbypass"></a>

#### Metabolic Bypassing

An example of a metabolic bypass in engineered crops is glyphosate resistance conferred by introduction of a glyphosate-tolerant EPSP synthase. Glyphosate is a ubiquitous herbicide that targets X_PATHWAY by EPSP inhibition, leading to accumulation of toxic precursors and plant death after 2-3 weeks. XBACTERIA growing near a glyphosate production facility were found in 1995(?) to express an EPSP synthase variant tolerant to glyphosate present in the soil [ref](ref), which was developed into a crop resistance gene by scientists at Monsanto and commercialized under the brand name *Roundup Ready*. *Roundup Ready* crops were the first commercially available herbicide resistant crops and the fastest-adopted technology in the history of agriculture [ref](ref). Since its release, *Roundup Ready* has been introduced into Maize (*Zea mays*), Soy (*Glycine max*), ... , and has cumulative sales worth $X since 1994.

<a name="metabolicdeactivation"></a>

#### Metabolic Deactivation

An example of metobolic deactivation in engineered crops is 2, 4 D

<a name="mesotrione"></a>

### Mesotrione: The Target Herbicide 

4-Hydroxyphenylpyruvate Dioxygenase (HPPD) is an important herbicide target and an area of interest for generating herbicide resistant crops. 
HPPD inhibitors are commonly deployed in cereal crops, which tolerate HPPD inhibitors better than broadleaf weeds and therefore allows preferential toxicity towards weeds. 
HPPD inhibitors are the last class of herbicides to have been discovered and are popular because of the broad spectrum of weeds that they are toxic to and because they can synergise with other herbicides, leading to the development of herbicide mixtures that allow greater application flexibility and minimise the chance of weeds developing herbicide resistance (Krämer, 2012).  

<a name="mesotrionemoa"></a>

#### Mechanism of Action

##### HPPD

HPPD is a critical node in the metabolic network of plants, inhibition of which leads to plant death with a characteristic leaf bleaching as a result of carotenoid loss and photosynthesis disruption.

HPPD is ubiquitous to aerobic organisms and catalyses the transformation of 4-Hydroxyphenylpyruvate to homogentisate, an important step in tyrosine catabolism (Moran, 2005). 
In plants, homogentisate is a precursor to both plastoquinone and α tocopherol (Soll et al., 1980).  

- Plastoquinone is an essential cofactor for the synthesis of carotenoids and in the coupling of photosystem I and II. 
- Carotenoids are accessory light harvesting pigments that prevent generation of reactive oxygen species (ROS) by quenching high energy triplet-state chlorophyll b. 

Additionally, β-carotene is a structural element of the photosystem II core, depletion of β-carotene causes the release of chlorophyll which is phototoxic in its free state (Hawkes and Krämer, 2012). 
Damage from HPPD-inhibition is exacerbated by depletion of α tocopherol, an important amphipathic antioxidant that quenches reactive oxygen species generated during uncoupled photosynthesis and scavenges lipid peroxyl radicals (Munné-Bosch, 2005).  

##### HPPD Inhibitors

All known potent HPPD inhibitors contain a 1,3 diketone moiety (Krämer, 2012). 
The crystal structure of tobacco (​nt​) HPPD with an experimental diketone inhibitor (DAS869) bound revealed that octahedral coordination of the catalytic Fe​2+ was required for tight binding (Yang et al., 
2004). 
Binding is also mediated by π-stacking of the benzoyl moiety of the inhibitor between two phenylalanine residues in the binding pocket.  
HPPD inhibitors can be identified by i​ n vitro high throughput screens, such as that described by Yang et al. 
(2004) who used a partially purified homogentisate dioxygenase from A ​ chromobacter xylosoxidans to couple homogentisate production to maleylacetoacetate. 
Production of maleylacetoacetate results in an increased absorbance at 300 nm, allowing the assay to be carried out in a microtiter plate and tracked by a plate reader.  

<a name="mesotrioneselectivity"></a>

#### Crop/Weed Selectivity

Maize can rapidly metabolize HPPD inhibitors like mesotrione which allows farmers to use this class of inhibitor as a selective herbicide (Mitchell et al., 
2001). 
The essential role of cytochrome P450s in herbicide metabolism was elucidated by co-application of mesotrione with the P450 inhibitor malathion, and the subsequent discovery of the 4-hydroxy-mesotrione metabolite (Hawkes et al., 

<a name="mesotrionereesistance"></a>

#### Mechanisms of Natural Resistance

Outbreaks of mesotrione-resistant weeds (​Aramanthus spp.​) have appeared in continuous corn seed production fields which have received repeated low doses of the herbicide (Hausman et al., 2011).  Like corn, the mesotrione-resistant A ​ ramanthus spp.  tolerated high doses of the herbicide via metabolic inactivation by 4-hydroxylation of mesotrione, which suggests that a P450 may be responsible (Kaundun et al., 2017).  

<a name="mesotrioneengineering"></a>

#### Metabolic Deactivation Engineering

HPPD-inhibitor Resistant Crops In 2013 Syngenta and Bayer submitted a transgenic soybean (​Glycine max L.​
) dubbed the ‘MGI Soybean’ with engineered HPPD-inhibitor tolerance for regulatory review (Syngenta, 2013)​. ​ 
This represents an important technology for farmers, since in the major maize-growing areas of the United States (the ‘Corn Belt’) maize crops are immediately followed by Soybean in 75% of cases due to crop rotation programs (Syngenta AG, 2007).  
Soybean is extremely sensitive to residual HPPD-inhibitors that may persist in the soil, so it is important to produce a variety of soybean that can tolerate this class of herbicide to allow safe crop rotation and herbicide application flexibility.  
In 2007, Tim Hawkes’ team at Syngenta filed patents in the US, Europe and China for several genes that were capable of conferring HPPD-inhibitor resistance to otherwise susceptible crops (Syngenta AG, 2007).  
One of the patented genes was an HPPD variant cloned from wild oats (​Avena fatua​) which is mildly tolerant towards HPPD-inhibiting herbicides.  
The gene was subject to a combination of site-directed mutagenesis, random mutagenesis and gene shuffling.  
The resultant mutants were screened by transformation into ​E.  
coli cells plated on media supplemented with tyrosine and an HPPD-inhibiting herbicide in similar stead to the aforementioned bacterial bioassay for HPPD inhibitors (Rocaboy-Faquet et al., 
2014).  
Colonies that accumulated a melanin-like pigment in the presence of the herbicide were considered to be herbicide-tolerant.  
To increase herbicide tolerance in the proposed line of Soybean, Hawkes’ team identified several putative P450s capable of metabolising herbicides by comparing quantitative trait loci (QTLs) from inbred lines of maize that had differing levels of tolerance to HPPD-inhibitor mesotrione and acetolactate-synthase inhibitor nicosulfuron.  
Expression and analysis of bacterial artificial chromosomes generated from the QTLs yielded a P450 with activity towards nicosulfuron (‘Maize NSFL’) and one with activity towards mesotrione (CYP72A1).  
The CYP72A family of P450 monooxygenases have a broad range of biological functions in plants, though a phylogenetic analysis by Prall et al.  
(2016) revealed insights into the functional regions of the enzyme 4 family such as the substrate recognition regions.  
They also found that enzymes in this family can be modelled onto the human CYP3A4 structure with a relatively high predicted accuracy, which may be a useful tool for producing mutants of this enzyme.  
The patent also covers CYP81A6 from rice (​Oryza sativa L.​
), which had been previously discovered to confer tolerance to benzaton (a photosystem II inhibitor) and to the sulfonylurea class of acetolactate synthase inhibitors (Zhang et al., 
2006).  
The product has not yet reached the market.  
Monooxygenation of herbicides by P450s is an important mechanism by which crops tolerate herbicides (Siminszky, 2006).  
P450-mediated degradation of herbicides can be enhanced in crops by the application of chemical ‘safeners’ to the seed coat or as a foliar spray.  
Safeners like naphthalic anhydride act by inducing expression of certain gene clusters that tend to include P450s capable of herbicide metabolism, leading to increased herbicide tolerance in the crop (Davies et al., 
1998).  
Insertion of an oxygen atom into a herbicide catalysed by the P450s can be sufficient to detoxify it in itself, as in the case of mesotrione (Kaundun et al., 
2017).  
In other cases, hydroxylation of the herbicide is followed by conjugation with a bulky, hydrophilic molecule, such as glutathione and its subsequent export from the cytosol into the vacuole or periplasm via an ATP binding cassette transporter (Yuan, Tranel and Stewart, 2007).  
In addition to the aforementioned MGI soybeans, exogenous P450s have been used to confer herbicide tolerance to rice (​O.  
sativa​) (Kawahigashi et al., 
2005, 2008), potatoes (​Solanum tuberosum​, Inui and Ohkawa, 2005), tobacco (​N. tabacum​) and ​A. thaliana​ (Didierjean, 2002).  

<a name="p450s"></a>

## P450s and BM3: The Design Template

cytochrome p450s are a ubiquitous class of enzymes involved in xenobiotic metabolism and can intitiate metobolism of herbicides. bacterial p450s are practical to engineer towards herbicide metabolism and are engineered to metabolise the herbicide ... here. directed evolution is simulated using a genetic algorithm, protein structure prediction and molecular docking. the engineered mutant is confirmed to have target activity towards ... 

<a name="p450sfn"></a>

### P450s Function, Structure, Evolution

<a name="p450analytical"></a>

### P450 Analytical Techniques

<a name="enzymedesign"></a>

## Enzyme Design Strategies

<a name="directedevolution"></a>

### Directed Evolution

<a name="vde"></a>

### Virtual Directed Evolution 

<a name="mldesign"></a>

### Machine Learning-Based Design 


<a name="git"></a>

## Open Source and `git`

------------------------------------
