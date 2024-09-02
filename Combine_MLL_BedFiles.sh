#!/bin/bash

input_dir=/path/to/individual/MLL_CUTnRUN/replicate/bedfiles/formatted_N1_and_N2_or_C1_and_C2
output_dir=/path/to/output/combined/MLL_CUTnRUN_Data/bedfile

mkdir -p $output_dir

# N1 code block
for N1 in $input_dir*_N1_*.bed; do
# Skip files with "unique" in their name
    if [[ $N1 == *unique* ]]; then
        continue
    fi
   
 base=$(basename "$N1" .bed)     
base=${base%_N1_*}              
outfile="${base}_Nterm_${N1##*_N1_}"  
  N2=${N1%%_N1_*}_N2_${N1##*_N1_}

    # Create temporary files for the unique lines in N1 and N2
    temp_N1=$(mktemp -p $output_dir)
    temp_N2=$(mktemp -p $output_dir)

    sort -k1,1 -k2,2n -k3,3n $N1 | awk '!seen[$1,$2,$3]++' > $temp_N1
    sort -k1,1 -k2,2n -k3,3n $N2 | awk '!seen[$1,$2,$3]++' > $temp_N2


    JOBID1=$(sbatch --wrap="cat $temp_N1 $temp_N2 | sort -k1,1 -k2,2n | awk '{print \$1\"\t\"\$2\"\t\"\$3}' > $output_dir/${outfile}" | cut -f 4 -d' ')
    sbatch --dependency=afterok:$JOBID1 /path/to/GenerateBedGraphsBigWigs.sh "$output_dir/${outfile}"

    # Remove temporary files after all tasks are done
    sbatch --dependency=afterok:$JOBID1 --wrap="rm -f $temp_N1 $temp_N2"
done

# C1 code block
for C1 in $input_dir*_C1_*.bed; do
# Skip files with "unique" in their name
    if [[ $C1 == *unique* ]]; then
        continue
    fi
    
base=$(basename "$C1" .bed)     
base=${base%_C1_*}              
outfile="${base}_Cterm_${C1##*_C1_}"  
    C2=${C1%%_C1_*}_C2_${C1##*_C1_}

    # Create temporary files for the unique lines in C1 and C2
    temp_C1=$(mktemp -p $output_dir)
    temp_C2=$(mktemp -p $output_dir)

    sort -k1,1 -k2,2n -k3,3n $C1 | awk '!seen[$1,$2,$3]++' > $temp_C1
    sort -k1,1 -k2,2n -k3,3n $C2 | awk '!seen[$1,$2,$3]++' > $temp_C2


    JOBID2=$(sbatch --wrap="cat $temp_C1 $temp_C2 | sort -k1,1 -k2,2n | awk '{print \$1\"\t\"\$2\"\t\"\$3}' > $output_dir/${outfile}" | cut -f 4 -d' ')
    sbatch --dependency=afterok:$JOBID2 /path/to/GenerateBedGraphsBigWigs.sh "$output_dir/${outfile}"

    # Remove temporary files after all tasks are done
    sbatch --dependency=afterok:$JOBID2 --wrap="rm -f $temp_C1 $temp_C2"
done
