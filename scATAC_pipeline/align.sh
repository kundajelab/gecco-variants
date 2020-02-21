### PREPARE 10X FILES ###

## ALIGNMENT
bwa_index=/mnt/data/annotations/by_release/hg38/bwa_index/GRCh38_no_alt_analysis_set_GCA_000001405.15.fasta
aligner_name=bwa
aligner_path=/software/bwa/bwa-0.7.17
sample=$1
input_dir=$2
output_dir=$3

snaptools align-paired-end --input-reference=$bwa_index --input-fastq1=$input_dir/$sample"_R1.dex.fastq.gz" --input-fastq2=$input_dir/$sample"_R3.dex.fastq.gz" --output-bam=$output_dir/$sample".bam" --aligner=$aligner_name --path-to-aligner=$aligner_path --read-fastq-command=zcat --min-cov=0 --num-threads=40 --if-sort=True --tmp-folder=./ --overwrite=TRUE

