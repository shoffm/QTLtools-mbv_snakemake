# QTLtools mbv Snakemake Pipeline
Pipeline for scaling QTLtools mbv 

[mbv](https://qtltools.github.io/qtltools/pages/QTLtools-mbv.1.html) matches genotype to RNA-seq files from the same individual by matching geontypes in a VCF tfile to a BAM file. This snakemake pipeline includes all steps necessary to run mbv in parallel, comparing all rna-seq samples to all genotype samples from a study. 

Why snakemake?

- Parallelization of independent jobs (i.e. comparing each rna-seq sample BAM to all genotypes in one VCF file). 
- Snakemake is aware of which jobs have been run (read: if job output exists in the correct location) and will only run jobs that haven't been run before (read: don't have existing output in the correct location). For this project, we don't have all of our rna samples sequenced yet. In this case, we will be able to add bam files as samples are sequenced and rerun the snakemake pipeline. Snakemake will only do the jobs in the Snakefile (run mbv) for the new files without modifying our code.

Help getting started with snakemake [here](https://github.com/Snitkin-Lab-Umich/Snakemake_setup).

### For this pipeline you will need to: 
### 1. Make and activate a conda environment 
Make and activate the conda environment from the [qtltools_sn.yml](). Help getting started with conda [here](https://github.com/Snitkin-Lab-Umich/Snakemake_setup#conda).
```
conda env create -f qtltools_sn # do this only once, the first time
conda activate qtltools_sn # do this every time
```
### 2. Install QTLtools 
Using download & installation link [here](https://qtltools.github.io/qtltools/)

### 3. Edit Snakefile 
In the snakefile there is one step, running mbv. For this you will need: 
- One VCF file containing all genotype samples in the dataset
- Path to a directory of BAM files to compare to
- Empty output directory

**Edit** the [Snakefile](https://github.com/shoffm/QTLtools-mbv_snakemake/blob/main/Snakefile) to point to the correct directories.

Do a dry run to determine id snakemake can make sense of your input and output paths in the workflow. 
```
snakemake -n
```

### 4. Submit snakemake job 
Submission bash script can be found here [submit_snakemake.sh](https://github.com/shoffm/QTLtools-mbv_snakemake/blob/main/submit_snakemake.sh). 

**Edit** the script to add a path to logfiles. 
Remember to have activated your conda environment from step 1. 
```
bsub < submit_snakemake.sh
```

### 5. Compare output to expectation of matching files
**Work in progress, coming soon** 
