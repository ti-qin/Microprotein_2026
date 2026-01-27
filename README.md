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

To predict the stability of microproteins, we developed a machine learning model based on their sequence features. Microproteins were labeled as stable or unstable based on predefined stability scores, and sequence embeddings were extracted using the ESM-2 model (specifically the 33rd layer representations). These embeddings were then pooled and fed into a Multilayer Perceptron (MLP) for classification. The model was optimized using Optuna for hyperparameter tuning and trained using a weighted random sampler to address class imbalance. 

### Layout

`stability_model/model_data.csv : ` Contains the labeled microprotein sequences and their corresponding stability scores used for model training. <br>
`stability_model/stability_model.ipynb : ` Jupyter notebook for training the MLP model using the extracted sequence features and stability labels. <br>
`stability_model/data_predict.ipynb : ` Jupyter notebook for predicting the stability of unseen microproteins using the trained model. <br>
`stability_model/best_mlp.pth` The saved weights of the trained MLP model, which can be loaded for making stability predictions.<br>
`stability_model/microprotein_db_seq.csv : ` Contains the names and sequences of all the microproteins included in the study. <br>
`stability_model/microprotein_db_predicted_stability.csv : ` Contains the predicted stability values for all microproteins using the model. 


