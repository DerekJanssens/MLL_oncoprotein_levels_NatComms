#!/bin/bash

# Modules
module load BEDTools
module load Kent_tools

# File paths and variables
filename=$1
# Path to hg38 chromosome lengths file
chr_lens_file="/path/to//hg38.chr_lens.txt"
# Path to directory to for bed graph and bigwig files. 
output_dir="/path/to/directory/for/bedgraphs/and/bigwigs/"

# Calculations
base=$(basename "$filename")
sum=$(awk '{s+=($3-$2)} END {print s}' $filename)
scale=$(awk -v c=$sum 'BEGIN {print (1/c)*10^10}')

# Job execution
JOBID=$(sbatch --wrap="genomeCoverageBed -bg -i $filename -g $chr_lens_file -scale $scale > $output_dir/${base%.bed}.bedgraph" | cut -f 4 -d' ')
sbatch --dependency=afterok:$JOBID --wrap="bedGraphToBigWig $output_dir/${base%.bed}.bedgraph $chr_lens_file $output_dir/${base%.bed}.bw"

