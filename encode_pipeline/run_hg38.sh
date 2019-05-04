#!/bin/bash
RUN_ROOT=/oak/stanford/groups/akundaje/projects/GECCO/scacheri_46_h3k27ac_chipseq/output_hg38
LOG_DIR=/oak/stanford/groups/akundaje/projects/GECCO/scacheri_46_h3k27ac_chipseq/logs_hg38
mkdir -p $LOG_DIR

SH_SCRIPT=/scratch/PI/akundaje/annashch/gecco-variants/encode_pipeline/template_submission.sh

#for sample in 589N 175T 651T 755N 644T 703N 651N 697N 858N #`ls $RUN_ROOT`
for sample in 175N 176N 235N 260N 260T 389N 391N 402N 402T 492N 492T 505N 620T 626N 644N 697T 703T 704N 747N 
do
    echo $sample
    cd $RUN_ROOT/$sample
    sbatch --partition akundaje,owners,euan,normal \
	--mem=50G \
	-o $LOG_DIR/$sample.o \
	-e $LOG_DIR/$sample.e  \
	-n 1 \
	--ntasks-per-node=1 \
	--job-name=$sample \
	--time=48:00:00 \
	--cpus-per-task=4 \
	$SH_SCRIPT $RUN_ROOT/$sample/$sample.json
done
