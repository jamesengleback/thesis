# Thesis


- General:
    - [Overview](general-overview.md)
    - [AI](general-ai.md)
    - [Directed Evolution](general-directed-evolution.md)
    - [Docking](general-docking.md)
    - [HPPD Herbicides](general-hppds.md)
    - [Cytochrome P450s](general-p450s.md)
    - [Protein Structure Prediction](general-protein-structure-prediction.md)
- Screening Fist:
    - [Introduction](sxfst-introduction.md)
    - [Methods](sxfst-methods.md)
    - [Results](sxfst-results.md)
    - [Discussion](sxfst-discussion.md)
- Virtual Directed Evolution:
    - [Introduction](vde-introduction.md)
    - [Methods](vde-methods.md)
    - [Results](vde-results.md)
    - [Discussion](vde-discussion.md)

---

## todo

- [ ] **General :**
	- [ ] **HPPD Herbicides :**
		- [ ] **Scaffold :**
		- [ ] **Dock to ntHPPD :**
		- [ ] **Dock to Cyp72A1 :**
	- [ ] **P450s :**
	- [ ] **Enzyme Engineering :**
	- [ ] **Protein Structure Prediction :**
	- [ ] **Docking :**
- [ ] **Screening Fist:**
	- [ ] **Results:**
		- [ ] **Screening Data:** Describe
		- [ ] **Model Training:** Describe
		- [ ] **Generated Proteins:** Do, Describe
	- [ ] **Discussion:**
		- [ ] **Issues:**
		- [ ] **Improvements:**
- [ ] **VDE:**
	- [ ] **Results:**
	- [ ] **Discussion:**
		- [ ] **Issues:**
		- [ ] **Improvements:**


```mermaid
gantt
        title Thesis Schedule
        %dateFormat YYYY-MM-DD
	%axisFormat  %Y-%m-%d

	section General
	Herbicides 			: g1, after v2, 1d
	P450s   			: g2, after g1, 2d
	Enzyme Engineering 		: g3, after g2, 2d
	Protein Structure Prediction 	: g4, after g3, 1d
	Docking 		 	: g5, after g4, 1d
	section Screening Fist
	Introduction 			: s1, after s3, 1d
	Results 			: s2, 2022-07-26, 3d
	Discussion 			: s3, after s2, 1d
	section VDE
	Results 			: v1, after s3, 2d
	Discussion 			: v2, after v1, 2d
	section Viva
	Viva 				:crit, q1, 2022-08-10, 1d
```
---

\bib

