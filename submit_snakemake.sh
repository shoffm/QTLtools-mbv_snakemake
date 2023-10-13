#!/bin/bash
#BSUB -o mbv_sn.stdout
#BSUB -e mbv_sn.stderr
#BSUB -J mbv_sn
#BSUB -q "long"
#BSUB -R "select[mem>2000] rusage[mem=2000] span[hosts=1]"
#BSUB -M2000

# Job commands
snakemake --latency-wait 90 --jobs 100 --cluster "bsub -o /path/to/logfiles/ -M2000 --jobname={rule}_{wildcards}" #/path/to/logfiles/ should be a path to an empty logfiles dir
