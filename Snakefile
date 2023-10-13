import glob 
import re

# ---------------- CHANGE these variables to match the project -------------

# input vcf file
vcf_infile = '/nfs/team282/projects/pops2/genotyping/data/pops2_genotyping_initial.vcf.gz' 

# input file directory - where bam files exist in this structure project_dirrectory/sample_1/sample_1.bam
bam_dir = '/lustre/scratch123/hgi/projects/pops2/rnaseq_runSept2023/results/star_pass2_2ndpass/' #include / at the end for directory
#bam_dir = '/lustre/scratch123/hgi/projects/pops2/genotyping/qc/mbv/test_bams/'

# cram suffix - where samples are named like sample_1.Aligned.sortedByCoord.out.bamm
bam_suffix = '.Aligned.sortedByCoord.out.bam'

# crosscheckFingerprint metric output file - should be in an existing directory (mkdir crosscheck_metrics)
outfile_path = '/lustre/scratch123/hgi/projects/pops2/genotyping/qc/mbv/mbv_output_files/'

# ---------------------------------------------------------------------------

# generate strings used later in the script
bam_infile = bam_dir + "{smp}/{smp}" + bam_suffix
outfile_mbvs = outfile_path + "{smp}.mbv.out"

# get list of sample names
samps=os.listdir(bam_dir)

# specify outputs
rule all: 
  input: 
    expand(outfile_mbvs, smp=samps)

# run mbv on each cram file
rule run_mbv:
  input:
    bam_input = bam_infile,
    vcf_input = vcf_infile,
    outfiles = outfile_path
  output:
    outfile_mbvs
  shell:
    "bam_infile_com={input.bam_input};"
    "vcf_infile_com={input.vcf_input};"
    "outfile={input.outfiles}{wildcards.smp}.mbv.out;"  
    "/software/team282/kb21/bin/QTLtools_1.2_Ubuntu16.04_x86_64/QTLtools_1.2_Ubuntu16.04_x86_64 mbv --bam $bam_infile_com --vcf $vcf_infile_com --filter-mapping-quality 150 --out $outfile;"  
