#!/bin/bash
#SBATCH --account=class-467713-ws-2026
#SBATCH --partition=pibu_el8
#SBATCH --job-name=fastqc
#SBATCH --cpus-per-task=4
#SBATCH --mem=2000M
#SBATCH --time=02:00:00
#SBATCH --output=logs/fastqc_%j.out
#SBATCH --error=logs/fastqc_%j.err

# Tool: FastQC 0.12.1
apptainer exec --bind /data:/data /containers/apptainer/fastqc-0.12.1.sif \
    fastqc -t 4 -o results/01_fastqc raw_data/*.f*q.gz
