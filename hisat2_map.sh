#!/bin/bash
#SBATCH --account=class-467713-ws-2026
#SBATCH --partition=pibu_el8
#SBATCH --job-name=hisat2_map
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --time=04:00:00
#SBATCH --array=1-N
#SBATCH --output=logs/hisat2_%A_%a.out
#SBATCH --error=logs/hisat2_%A_%a.err

SIF=/containers/apptainer/hisat2_samtools_408dfd02f175cd88.sif
SAMPLE=$(sed -n "${SLURM_ARRAY_TASK_ID}p" samples.txt)
mkdir -p results/04_mapping

apptainer exec --bind /data/ $SIF /bin/bash -c "
set -o pipefail
hisat2 -p 8 -x reference/hisat2_index/genome \
    -1 results/02_trimmed/${SAMPLE}_1_paired.fastq.gz \
    -2 results/02_trimmed/${SAMPLE}_2_paired.fastq.gz \
    --rna-strandness RF \
| samtools sort -m 1G -@ 4 -T ${SCRATCH}/${SAMPLE} \
    -o results/04_mapping/${SAMPLE}.sorted.bam##idx##results/04_mapping/${SAMPLE}.sorted.bam.bai \
    --write-index
"
