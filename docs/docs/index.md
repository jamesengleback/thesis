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
        %%axisFormat %Y/%m/%d
        %%axisFormat  %Y-%m-%d
	section General
	Herbicides 			: g1, after v2, 2d
	P450s   			: g2, after g1, 2d
	Enzyme Engineering 		: g3, after g2, 2d
	Protein Structure Prediction 	: g4, after g3, 2d
	Docking 		 	: g5, after g4, 2d
	section Screening Fist
	Results 			: s1, 2022-07-26, 2d
	Discussion 			: s2, after s1, 2d
	section VDE
	Results 			: v1, after s2, 2d
	Discussion 			: v2, after v1, 2d
```

---

\bib
