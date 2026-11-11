#!/bin/bash
#SBATCH --job-name=trimming
#SBATCH --account=class-467713-ws-2026
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=4
#SBATCH --mem=4G
#SBATCH --time=02:00:00
#SBATCH --output=logs/trim_%A_%a.out
#SBATCH --error=logs/trim_%A_%a.err

# Load Trimmomatic
module load Trimmomatic/0.39-Java-11

# Directories
INPUT="raw_data"
OUTPUT="results/02_trimmed"

mkdir -p "$OUTPUT"

# Get sample name for this array task
SAMPLE=$(sed -n "$((SLURM_ARRAY_TASK_ID + 1))p" samples.txt)

# Input files
R1="${INPUT}/${SAMPLE}_1.fastq.gz"
R2="${INPUT}/${SAMPLE}_2.fastq.gz"

# Check that both files exist
if [[ ! -f "$R1" || ! -f "$R2" ]]; then
    echo "ERROR: Missing input file for sample ${SAMPLE}"
    exit 1
fi

echo "Processing sample: $SAMPLE"

# Run Trimmomatic
java -jar "$EBROOTTRIMMOMATIC/trimmomatic-0.39.jar" PE \
    -threads "$SLURM_CPUS_PER_TASK" \
    -phred33 \
    "$R1" "$R2" \
    "$OUTPUT/${SAMPLE}_1_paired.fastq.gz" \
    "$OUTPUT/${SAMPLE}_1_unpaired.fastq.gz" \
    "$OUTPUT/${SAMPLE}_2_paired.fastq.gz" \
    "$OUTPUT/${SAMPLE}_2_unpaired.fastq.gz" \
    ILLUMINACLIP:"$EBROOTTRIMMOMATIC/adapters/TruSeq3-PE.fa":2:30:10 \
    LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

echo "Finished sample: $SAMPLE"
