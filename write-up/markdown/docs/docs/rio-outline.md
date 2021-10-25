# Outline

This work attempts to build a machine learning model that maps protein sequence to substrate specificity.
The model is pre-trained on a large enzyme:substrate binding dataset before being re-trained on domain-specific P450 BM3:ligand screening data.
The model is used to optimally design subsequent screening rounds by estimating the expected information gain of an experiment.
The model is also used to propose BM3 variant sequences  with predicted binding activity towards mesotrione.
