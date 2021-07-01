# write-up - markdown
initial write up in markdown before writing `tex`.

# abstract

> Herbicide resistance can be engineered into crops by inserting resistance genes.
> Resistance genes can be enzymes that initiate metabolism of the herbicide.
> Here, mutant variants of the cytochrome P450 BM3 are engineered to ring-hydroxylate the 4-hydroxyphenylpyruvate (HPPD) inhibitor mesotrione using two computational methods: **1)** virtual directed evolution using protein structure prediction, molecular docking and a genetic algorithm. **2)** machine learning guided design using a model designed to predict ligand binding based on sequence and smiles alone. This method uses a transformer and a graph neural network pretrained on enzyme substrate specificity from KEGG (n points) and re-trained on a screening set of several (n) BM3 mutants  binding and a library of FDA-approved drugs. Trained model predictions of binding activity towards mesotrione are used to virtually screen BM3 mutant sequences at scale and sequence space search algorithms are compared. Promising mutants are made and tested for predicted activity in the wet lab.

----------------------------

# contents
1. **introduction**

- problem space
	- background on herbicide resistance crop engineering
	- key herbicide mesotrione, MOA and resistance 
	- mesotrione resistance engineering
	- motivation to use bm3
	- no starting activity
- background: enzyme engineering   
	- directed evolution  
	- classical computational design  
		- protein structure prediction
		- molecular docking
		- molecular dynamics
		- sequence optimizers
	- ai-guided design   
		- brief history of ai
		- ai in protein design
- background: p450s and bm3
- this work
	- classical computational design
		- 
		- refer to enz/evo section   
	- machine learning-guided design
		- refer to screening/rio section 

2. **methods**

	- design requirements
		- enz/evo  
		- screening/rio   
		- mutant validation  
	- `enz` design and implementation  
	- evo experimental design and data  
	- screen
		- assay (development?)   
		- `echo` design and `plate` analysis   
	- rio
		- design requirements  
		- design and pre-training  
		- screening data training   
		- mutant predictions        
	- protein expression and purification  
	- validation 
		- lcms screen  
		- kinetics  
  
3. **results and discussion**  

	-  `enz/evo`   
		-  enz benchmark   
		-  evolutionary experiment results  
		-  mutant design  
		-  mutant testing  
		-  design approach accuracy and limitations  
		-  design approach future work and improvements  
	-  `screen/rio`  
		-  screening results - data description  
		-  screening results - data processing with `plates`  
		-  screening results - clean dataset  
		-  data mining  
		-  model design and pretraining  
		-  training on screening data  
		-  accuracy and limitations  
		-  sequence design  
		-  mutant testing  
		-  design approach accuracy and limitations
		-  future work/improvements

4. **conclusion**
