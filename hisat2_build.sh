#!/bin/bash
#SBATCH --account=class-467713-ws-2026
#SBATCH --partition=pibu_el8
#SBATCH --job-name=hisat2_build
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --time=02:00:00
#SBATCH --output=logs/hisat2_build_%j.out
#SBATCH --error=logs/hisat2_build_%j.err

SIF=/containers/apptainer/hisat2_samtools_408dfd02f175cd88.sif
mkdir -p reference/hisat2_index
gunzip -k reference/Mus_musculus.GRCm39.dna.primary_assembly.fa.gz

apptainer exec --bind /data/ $SIF \
    hisat2-build -p 8 \
    reference/Mus_musculus.GRCm39.dna.primary_assembly.fa \
    reference/hisat2_index/genome
