import glob 
import re

# ---------------- CHANGE these variables to match the project -------------

# input vcf file
vcf_infile = '/path/to/file.vcf' 

# input file directory - where bam files exist in this structure project_dirrectory/sample_1/sample_1.bam
bam_dir = '/path/to/bams/project_directory/' #include / at the end for directory


# cram suffix - where samples are named like sample_1.Aligned.sortedByCoord.out.bamm
bam_suffix = '.Aligned.sortedByCoord.out.bam'

# output directory - should be in an existing directory (mkdir mbv_output_files)
outfile_path = '/path/to/mbv_output_files/'

# path to where QTLtools was downloaded to on your machine 
qtltools_path = '/path/to/QTLtools' 

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
    outfiles = outfile_path,
    qtlpath = qtltools_path
  output:
    outfile_mbvs
  shell:
    "bam_infile_com={input.bam_input};"
    "vcf_infile_com={input.vcf_input};"
    "outfile={input.outfiles}{wildcards.smp}.mbv.out;" 
    "qtl_path={input.qtlpath};"
    "$qtl_path mbv --bam $bam_infile_com --vcf $vcf_infile_com --filter-mapping-quality 150 --out $outfile;"  
