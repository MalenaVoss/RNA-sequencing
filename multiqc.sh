#!/bin/bash
#SBATCH --account=class-467713-ws-2026
#SBATCH --partition=pibu_el8
#SBATCH --job-name=multiqc
#SBATCH --cpus-per-task=1
#SBATCH --mem=2000M
#SBATCH --time=00:30:00
#SBATCH --output=logs/multiqc_%j.out
#SBATCH --error=logs/multiqc_%j.err


# Tool: MultiQC 1.33
apptainer exec --bind /data:/data /containers/apptainer/multiqc-1.33.sif \
    multiqc results/03_fastqc_trimmed -o results/03_fastqc_trimmed/multiqc
