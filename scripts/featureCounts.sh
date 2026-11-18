#!/bin/bash
#SBATCH --account=class-467713-ws-2026
#SBATCH --partition=pibu_el8
#SBATCH --job-name=featurecounts
#SBATCH --cpus-per-task=8
#SBATCH --mem=8G
#SBATCH --time=01:00:00
#SBATCH --output=logs/featurecounts_%j.out
#SBATCH --error=logs/featurecounts_%j.err

#get featureCounts
SIF=/containers/apptainer/subread_2.0.6.sif

#sorted BAM files
BAM_DIR=results/04_mapping

#get reference GTF file
gunzip -k reference/Mus_musculus.GRCm39.*.gtf.gz
GTF=$(ls reference/Mus_musculus.GRCm39.*.gtf)

#make output dir
mkdir -p results/05_counts

#run featureCounts
apptainer exec --bind /data/ $SIF \
    featureCounts -T 8 \
    -p --countReadPairs \
    -s 2 \
    -t exon -g gene_id \
    -a $GTF \
    -o results/05_counts/counts.txt \
    $BAM_DIR/*.bam