# write-up - markdown
initial write up in markdown before writing `tex`.

# abstract

> Herbicide resistance can be engineered into crops by inserting resistance genes.
> Resistance genes can be enzymes that initiate metabolism of the herbicide.
> Here, mutant variants of the cytochrome P450 BM3 are engineered to ring-hydroxylate the 4-hydroxyphenylpyruvate (HPPD) inhibitor mesotrione using two computational methods: **1)** virtual directed evolution using protein structure prediction, molecular docking and a genetic algorithm. **2)** machine learning guided design using a model designed to predict ligand binding based on sequence and smiles alone. This method uses a transformer and a graph neural network pretrained on enzyme substrate specificity from KEGG (n points) and re-trained on a screening set of several (n) BM3 mutants  binding and a library of FDA-approved drugs. Trained model predictions of binding activity towards mesotrione are used to virtually screen BM3 mutant sequences at scale and sequence space search algorithms are compared. Promising mutants are made and tested for predicted activity in the wet lab.

----------------------------

# contents
1. [**introduction**](introduction)
2. [**methods**](methods)
3. [**results and discussion**](results)
4. [**conclusion**](conclusion)
