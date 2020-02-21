### PREPARE 10X FILES ###
file="F6_S3"
file1=$file"_L001"
file2=$file"_L002"
file3=$file"_L003"
file4=$file"_L004"
file5=$file"_L005"
file6=$file"_L006"
file7=$file"_L007"
wd=/illumina/scratch/deep_learning/lsundaram/cardiomyogenesis/fastq/F6
od=/illumina/scratch/deep_learning/lsundaram/cardiomyogenesis/fastq/F6/snap_output



#demux 
#snaptools dex-fastq --input=$wd/$file1"_R1_001.fastq.gz" --output-fastq=$od"/"$file1"_R1.dex.fastq.gz" --index-fastq-list=$wd/$file1"_R2_001.fastq.gz"
#snaptools dex-fastq --input=$wd/$file1"_R3_001.fastq.gz" --output-fastq=$od"/"$file1"_R3.dex.fastq.gz" --index-fastq-list=$wd/$file1"_R2_001.fastq.gz"

#snaptools dex-fastq --input=$wd/$file2"_R1_001.fastq.gz" --output-fastq=$od"/"$file2"_R1.dex.fastq.gz" --index-fastq-list=$wd/$file2"_R2_001.fastq.gz"
#snaptools dex-fastq --input=$wd/$file2"_R3_001.fastq.gz" --output-fastq=$od"/"$file2"_R3.dex.fastq.gz" --index-fastq-list=$wd/$file2"_R2_001.fastq.gz"

#snaptools dex-fastq --input=$wd/$file3"_R1_001.fastq.gz" --output-fastq=$od"/"$file3"_R1.dex.fastq.gz" --index-fastq-list=$wd/$file3"_R2_001.fastq.gz"
#snaptools dex-fastq --input=$wd/$file3"_R3_001.fastq.gz" --output-fastq=$od"/"$file3"_R3.dex.fastq.gz" --index-fastq-list=$wd/$file3"_R2_001.fastq.gz"

snaptools dex-fastq --input=$wd/$file4"_R1_001.fastq.gz" --output-fastq=$od"/"$file4"_R1.dex.fastq.gz" --index-fastq-list=$wd/$file4"_R2_001.fastq.gz"
snaptools dex-fastq --input=$wd/$file4"_R3_001.fastq.gz" --output-fastq=$od"/"$file4"_R3.dex.fastq.gz" --index-fastq-list=$wd/$file4"_R2_001.fastq.gz"

snaptools dex-fastq --input=$wd/$file5"_R1_001.fastq.gz" --output-fastq=$od"/"$file5"_R1.dex.fastq.gz" --index-fastq-list=$wd/$file5"_R2_001.fastq.gz"
snaptools dex-fastq --input=$wd/$file5"_R3_001.fastq.gz" --output-fastq=$od"/"$file5"_R3.dex.fastq.gz" --index-fastq-list=$wd/$file5"_R2_001.fastq.gz"

snaptools dex-fastq --input=$wd/$file6"_R1_001.fastq.gz" --output-fastq=$od"/"$file6"_R1.dex.fastq.gz" --index-fastq-list=$wd/$file6"_R2_001.fastq.gz"
snaptools dex-fastq --input=$wd/$file6"_R3_001.fastq.gz" --output-fastq=$od"/"$file6"_R3.dex.fastq.gz" --index-fastq-list=$wd/$file6"_R2_001.fastq.gz"

#snaptools dex-fastq --input=$wd/$file7"_R1_001.fastq.gz" --output-fastq=$od"/"$file7"_R1.dex.fastq.gz" --index-fastq-list=$wd/$file7"_R2_001.fastq.gz"
#snaptools dex-fastq --input=$wd/$file7"_R3_001.fastq.gz" --output-fastq=$od"/"$file7"_R3.dex.fastq.gz" --index-fastq-list=$wd/$file7"_R2_001.fastq.gz"




#cat $od/$file1"_R1.dex.fastq.gz" $od/$file2"_R1.dex.fastq.gz" $od/$file3"_R1.dex.fastq.gz" $od/$file4"_R1.dex.fastq.gz" $od/$file5"_R1.dex.fastq.gz" $od/$file6"_R1.dex.fastq.gz" $od/$file7"_R1.dex.fastq.gz" > $od/$file"_R1.dex.fastq.gz"
#cat $od/$file1"_R3.dex.fastq.gz" $od/$file2"_R3.dex.fastq.gz" $od/$file3"_R3.dex.fastq.gz" $od/$file4"_R3.dex.fastq.gz" $od/$file5"_R3.dex.fastq.gz" $od/$file6"_R3.dex.fastq.gz" $od/$file7"_R3.dex.fastq.gz" > $od/$file"_R3.dex.fastq.gz"

cat $od/$file4"_R1.dex.fastq.gz" $od/$file5"_R1.dex.fastq.gz" $od/$file6"_R1.dex.fastq.gz"  > $od/$file"_R1.dex.fastq.gz"
cat $od/$file4"_R3.dex.fastq.gz" $od/$file5"_R3.dex.fastq.gz" $od/$file6"_R3.dex.fastq.gz"  > $od/$file"_R3.dex.fastq.gz"



## ALIGNMENT
genome_ref=/illumina/scratch/deep_learning/lsundaram/cardiomyogenesis/GRCh38.p3.genome.fa
aligner_name=bwa
aligner_path=~/anaconda2/envs/new/bin/
snaptools align-paired-end --input-reference=$genome_ref --input-fastq1=$od/$file"_R1.dex.fastq.gz" --input-fastq2=$od/$file"_R3.dex.fastq.gz" --output-bam=$od/$file".bam" --aligner=$aligner_name --path-to-aligner=$aligner_path --read-fastq-command=zcat --min-cov=0 --num-threads=40 --if-sort=True --tmp-folder=./ --overwrite=TRUE


#preprocess
genome_dir=/illumina/scratch/deep_learning/lsundaram/cardiomyogenesis
snaptools snap-pre  --input-file=$od/$file.bam  --output-snap=$od/${file}_new.snap  --genome-name=hg38  --genome-size=$genome_dir/hg38.chrom.sizes  \
    --min-mapq=30  --min-flen=25  --max-flen=1000  --keep-chrm=TRUE  --keep-single=TRUE  --keep-secondary=False  \
    --overwrite=True  --max-num=1000000  --min-cov=10  --verbose=True



#binning 
snaptools snap-add-bmat --snap-file=$od/${file}_new.snap --bin-size-list 50 1000 2000 5000 10000 --verbose=True 


#python code snap to scanpy 





