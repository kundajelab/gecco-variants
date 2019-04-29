#!/bin/bash
for genome in hg19 hg38
do

    RUN_ROOT=/oak/stanford/groups/akundaje/projects/GECCO/scacheri_46_h3k27ac_chipseq/output_$genome
    LOG_DIR=/oak/stanford/groups/akundaje/projects/GECCO/scacheri_46_h3k27ac_chipseq/logs_$genome
    TO_RERUN=/scratch/PI/akundaje/annashch/gecco-variants/encode_pipeline/resumer_files_$genome.txt
    SH_SCRIPT=/scratch/PI/akundaje/annashch/gecco-variants/encode_pipeline/template_submission.sh

    for file in `cat $TO_RERUN`; do
	WORK_DIR=$(dirname $file) 
	prefix=$(basename $WORK_DIR) 
	cd $WORK_DIR 
	echo $prefix
	sbatch --partition akundaje,euan,normal,owners --mem=50G \
	-o $LOG_DIR/$prefix.o -e $LOG_DIR/$prefix.e \
	-n 1 --ntasks-per-node=1  --job-name=$file.$genome --time=48:00:00 --cpus-per-task=4 \
	$SH_SCRIPT $file
    done
done
