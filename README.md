# Detect differentially expressed genes from bulk RNA-seq data

This workflow starts from Illumina sequencing data (fastq files). 
The goal is to produce lists of genes that are differentially expressed (DE) 
between two experimental groups, and identify gene ontology (GO) terms enriched for DE genes.

**Course: 467713-HS2026: RNA-sequencing** <br>
**Author: Malena Voss** <br>
**Tissue Analyzed: Lung**

Group definitions:

- Case = Infected
- Control = Uninfected
- WT = Wildtype
- DKO = Double-Knockout

| Genotype | Condition | Number of samples |
|---|---|---:|
| WT | Case | 5 |
| WT | Control | 3 |
| DKO | Case | 4 |
| DKO | Control | 2 |
| **Total**  | | **14** |

## Workflow and tools used 
| Step | Description | Tool |  
|---|---|---|
| 1 | Quality control of raw reads | FastQC 0.12.1 | 
| 2 | Download reference genome + annotation, verify checksums | Ensembl FTP |  
| 3 | Build genome index | HISAT2 <version> |  
| 4 | Map reads (⁠ --rna-strandness RF ⁠), convert, sort, index BAM | HISAT2, Samtools <version> |  
| 5 | Count reads per gene (⁠ -s 2 ⁠, paired-end) | featureCounts (Subread 2.0.6) | 
| 6 | Exploratory data analysis (VST, PCA) | DESeq2 <version> |  
| 7 | Differential expression analysis | DESeq2 <version> |  
| 8 | GO overrepresentation analysis | clusterProfiler <version>, org.Mm.eg.db |
