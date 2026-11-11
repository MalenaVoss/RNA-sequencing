#!/bin/bash
#SBATCH --account=class-467713-ws-2026
#SBATCH --partition=pibu_el8
#SBATCH --job-name=fastqc_trim
#SBATCH --cpus-per-task=2
#SBATCH --mem=2000M
#SBATCH --time=01:00:00
#SBATCH --array=1-15
#SBATCH --output=logs/fastqc_trim_%A_%a.out
#SBATCH --error=logs/fastqc_trim_%A_%a.err

# Tool: FastQC 0.12.1
SAMPLE=$(sed -n "${SLURM_ARRAY_TASK_ID}p" samples.txt)

apptainer exec --bind /data:/data /containers/apptainer/fastqc-0.12.1.sif \
    fastqc -t 2 -o results/03_fastqc_trimmed \
    results/02_trimmed/${SAMPLE}_1_paired.fastq.gz \
    results/02_trimmed/${SAMPLE}_2_paired.fastq.gz
