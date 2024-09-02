#!/bin/bash

# Full path to the directory containing the bedgraph files
DIR="/path/to/target/bedgraphs/"

# Full path to your SEACR script
SEACR_SCRIPT_PATH="/path/to/SEACR_1.3.sh"

# Loop through each bedgraph file in the specified directory
for FILE in "$DIR"/*.bedgraph; do
    # Extract the base filename without the .bedgraph extension
    BASENAME=$(basename "$FILE" .bedgraph)

    # Form the output filename by appending .01 to the BASENAME
    OUTPUT="$DIR"/"$BASENAME".01

    # Call SEACR on the file using "non" mode and FDR threshold of 0.01 with bash directly
    bash "$SEACR_SCRIPT_PATH" "$FILE" 0.01 non stringent "$OUTPUT"

    # Adjust the SEACR command as necessary depending on its arguments and options for your specific version.
done
