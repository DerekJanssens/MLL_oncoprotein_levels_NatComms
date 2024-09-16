# MLL_oncoprotein_levels_NatComms
This README provides instructions for reproducing all of the figures in the manuscript "MLL oncoprotein levels influence binding sites and leukemia lineage identity." by Janssens et al. 2024. Nature Communications.

The code for figure generation is all provided in the Jupyter Notbook "MLL_Oncoprotein_Levels.ipynb"

To run python in this notebook the module bedtools must be loaded when the jupyter notebook is initiated. 
The original jupyter notebook used bedtools-2.30.0

These are the specific versions of the python packages used in the original notebook:
os version: posix
pandas version: 1.5.3
numpy version: 1.25.2
matplotlib version: 3.9.2
seaborn version: 0.13.2
scipy version: 1.14.1
statsmodels version: statsmodels: 1.5.3
scikit-learn version: sklearn: 1.25.2
umap-learn version: umap: 1.5.3
matplotlib-venn version: matplotlib_venn: 1.25.2

Because of the large file size the raw MLL/KMT2A N and C terminal CUT&RUN data and the DOT1L, ENL, Menin and H3K4me3 CUT&Tag Data must be downloaded from GEO under the accession codes GSE252378 and GSE159608
The MLL/KMT2A N and C terminal CUT&RUN data can be combined using the Combine_MLL_BedFiles.sh and GenerateBedGraphsBigWigs.sh bash scripts
The CUT&Tag replicates can be combined using the Combine_CnT_Replicate_BedFiles.sh and GenerateBedGraphsBigWigs.sh bash script 

Whenever possible the processed data files are available on this GitHub so that the raw data processing can be skipped. 
