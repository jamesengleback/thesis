# To Do

## Overview
To do lists and schedules

## Gantt Chart 

```mermaid
gantt
title Thesis Schedule
dateFormat YYY-MM-DD

section VDE
VDE Run      : 		des1, 	2021-11-08, 1d
VDE Analysis : 		des2, after des1, 1d
VDE primers  : 		des3, after des2, 1d
VDE PCR      :		des4, after des3, 3d
VDE PCR Sequencing   :  des5, after des4, 3d
VDE Expression   :  des6, after des5, 4d
VDE Purificaiton   :  des7, after des6, 4d

section Rio/Screening-Fist
Design Echo Scripts 			: rio1, 2021-11-09, 1d
Dump Screen FDA w/ WT, A82F 		: rio2, after rio1, 3d
Dump Screen FDA w/ 1YQO, 1YQP 		: rio3, after rio1, 3d
Dump screen FDA w/ A264E, 1JME(P393H) 	: rio4, after rio1, 3d
Dump Screen FDA w/ 1YQO, 1YQP 		: rio5, after rio1, 3d
Screen analysis 			: rio6, after rio5, 2d

Model Assembly 				: rio7, 2021-11-09, 7d
Pre-training data assembly 		: rio8, 2021-11-09, 7d
Model Pre-training 			: rio9, after rio7, 4d
Model Training 				: rio10, after rio9, 4d
Test Model Mutant Design 		: rio11, after rio10, 4d
Model Screen Design 			: rio12, after rio10, 4d

Primer Design 				: rio13, after rio12, 2d
PCR  					: rio14, after rio13, 2d
Sequencing 				: rio15, after rio14, 4d
Expression 				: rio16, after rio15, 4d
Purificaiton 				: rio17, after rio16, 4d
Dump Screen 				: rio18, after rio17, 4d
Analysis 				: rio19, after rio18, 4d
Propose new mutants 			: rio20, after rio19, 4d

section Writing
VDE Methods 				: wr1, 2021-11-08, 14d
VDE Results 				: wr2, after des2, 14d

Rio Methods 				: wr3, 2021-11-08, 14d
Rio Analysis 				: wr4, after rio6, 28d
```

## Tasks
- **Model:** 
	- :warning: **Rotation:**
	- **Training:** 
	- [ ] **hyperopt:**
		- [x]  **Sweep** `cuda:0 | cuda:1`
			- [ ] script should save the data as it goes
		- [ ] choose parameter set
			- `lr`: `1e-5` (small)
			- `batch_size`: `128` (large)
			- :warning: recycles don't seem important
			- downsamples 4 (few)
			- `epochs` - more(?)
		- [ ] **Regression** - best params
		- [ ] **Train & Validate**
			- [ ] Dataset - update
			- [ ] Dataset - validate CA mapping
			- [ ] Dataset - embeddings
			- [ ] Dataset - **Rotation** :warning:
			- [ ] Dataset - validation set
	- [ ] **Rotation:**

---
### VDE
- [ ] Check heme is in set
- [ ] Check on DM run
- [ ] Factor DM mutations into nn dataset
- [ ] rotation augmentations
