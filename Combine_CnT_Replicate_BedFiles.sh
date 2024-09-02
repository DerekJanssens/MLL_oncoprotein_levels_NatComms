#!/bin/bash

input_dir=/path/to/individual/CUTnTag/replicate/bedfiles/formatted_R1_and_R2
output_dir=/path/to/output/combined/CUTnTag_Data/bedfile

mkdir -p $output_dir

# Loop through each R1 file in the input directory
for R1_file in "${input_dir}"*_R1_*.bed; do
    # Skip files with "unique" in their name
    if [[ "$R1_file" == *unique* ]]; then
        continue
    fi

    # Derive the base name without the extension and suffix
    base=$(basename "$R1_file" .bed)     
    base=${base%_R1_*}

    # Construct the corresponding R2 file name
    R2_file="${R1_file%%_R1_*}_R2_${R1_file##*_R1_}"

    # Output file name construction
    outfile="${output_dir}/${base}_combined.bed"

    # Check if the R2 file exists
    if [ -f "$R2_file" ]; then
        # Concatenate, sort, and save to outfile
        cat "$R1_file" "$R2_file" | sort -k1,1 -k2,2n > "$outfile"
        
        # Directly submit the job to SLURM without using a job dependency
        sbatch /path/to/GenerateBedGraphsBigWigs.sh "$outfile"
    else
        echo "Corresponding R2 file for $R1_file does not exist."
    fi
done
