#!/bin/bash

# Project directory (parent of scripts)
PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

LOG_DIR="$PROJECT_DIR/logs"
output="$PROJECT_DIR/hisat2_summary.csv"

# CSV header
echo "Sample,Total_reads,Concordant_0_count,Concordant_0_percent,Concordant_1_count,Concordant_1_percent,Concordant_multiple_count,Concordant_multiple_percent,Overall_alignment_rate" > "$output"

# Process all HISAT2 error logs
for file in $(find "$LOG_DIR" -maxdepth 1 -name "hisat2_*.err" | sort -V); do

    sample=$(basename "$file" .err | sed 's/hisat2_//')

    total=$(awk '/reads; of these:/{print $1; exit}' "$file")

    zero=$(awk '/aligned concordantly 0 times/{print $1, $2; exit}' "$file")
    one=$(awk '/aligned concordantly exactly 1 time/{print $1, $2; exit}' "$file")
    multi=$(awk '/aligned concordantly >1 times/{print $1, $2; exit}' "$file")

    rate=$(awk '/overall alignment rate/{print $1; exit}' "$file")

    # Extract counts and percentages
    zero_count=$(echo "$zero" | awk '{print $1}')
    zero_pct=$(echo "$zero" | awk '{gsub(/[()%]/,"",$2); print $2}')

    one_count=$(echo "$one" | awk '{print $1}')
    one_pct=$(echo "$one" | awk '{gsub(/[()%]/,"",$2); print $2}')

    multi_count=$(echo "$multi" | awk '{print $1}')
    multi_pct=$(echo "$multi" | awk '{gsub(/[()%]/,"",$2); print $2}')

    echo "$sample,$total,$zero_count,$zero_pct,$one_count,$one_pct,$multi_count,$multi_pct,$rate" >> "$output"

done

echo "Summary saved to $output"