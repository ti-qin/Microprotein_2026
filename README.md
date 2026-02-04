# Intrinsic Bias of the Genetic Code Shapes the Folding and Stability Landscapes of Microprotein

This repository contains Python code, Jupyter Notebooks, and data to reproduce the results presented in the manuscript “Intrinsic Bias of the Genetic Code Shapes the Folding and Stability Landscapes of Microprotein” The code is organized into two main sections:

## 1. Long-Range Interactions Calculation

### Layout

`long_interactions/pdb_to_cm.py : ` Simple Python script for computing protein contact maps from PDB files as described in Godzik and Skolnick, (1994). An edge is added between all non-adjacent pairs of amino acids where the euclidean distance between their alpha carbons are less then some threshold. <br>
`long_interactions/batch_calculate_cm.sh : ` This shell script automates batch processing of PDB files, executing `pdb_to_cm.py` to calculate the proportion of residues with long-range interactions in each protein structure.

### Usage

Compute the contact map for 1BPI with a threshold of 7.5 ångström.

```
python pdb_to_cm.py 1bpi.pdb 1bpi.cm -t 7.5
```

The batch calculation can be executed by modifying the protein structure folder path in batch_calculate.sh, followed by running the script.

```
sh batch_calculate_cm.sh
```

### Reference

> Godzik A, Skolnick J. Flexible algorithm for direct multiple alignment of protein structures and sequences. Computer applications in the biosciences: CABIOS. 1994 Dec 1;10(6):587-96

## 2. Microprotein Stability Model

### Overview

This repository provides two ESM-2–based models to predict microprotein stability from amino-acid sequence. Residue-level embeddings are extracted from pretrained ESM-2 (esm2_t33_650M_UR50D; layer 33, 1280D) with the backbone frozen. One model performs extreme-label classification (stable >0.8 vs unstable <0.2) using mean-pooled embeddings and an MLP. The other model predicts continuous stability scores (0–1) using global + C-terminal attention pooling and is trained with a combined MSE + pairwise ranking objective (model selection by Spearman correlation in 5-fold CV).

### Layout

`stability_model/Classification_model.ipynb : ` Train/evaluate the stability classifier (Optuna tuning, weighted sampling, ROC evaluation). <br>
`stability_model/Classification_train_data.csv : `Training data for classification (sequences + stability labels). <br>
`stability_model/Regression_model.ipynb : ` Train/evaluate the regression/ranking model (5-fold CV, Spearman-based selection). <br>
`stability_model/Regression_train_data.csv :`Training data for regression (sequences + continuous stability scores).<br>


