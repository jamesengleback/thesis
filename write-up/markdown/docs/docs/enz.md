# enz

## Contents
- [Motivation](#)
- [Implementation](#)
- [API](#)
- [Benchmarking](#)

# Overview

`enz` is a `python` package developed for this work to wrap both protein structure prediction and ligand docking with a simple interface. 

# Motivation

The proposed virtual directed evolution method requires structure prediction and docking ... 

# Implementation

Backends: 
- `nwalign` - for sequence alignment
- `pyrosetta` - for template-based structure prediction. Only side chain repacking `ref` is used
- `openbabel` - for `pdbqt` file generation for `vina`
- `vina` - for docking
- `pandas` & `biopandas` - for `pdb` file cleaning and data output


# API

**Motivation:** simple

**Objects**

**Examples**


Test pull request
# Benchmarking

