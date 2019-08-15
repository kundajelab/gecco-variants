#!/bin/bash
RUN_ROOT=/oak/stanford/groups/akundaje/projects/GECCO/scacheri_46_h3k27ac_chipseq/output_hg19
LOG_DIR=/oak/stanford/groups/akundaje/projects/GECCO/scacheri_46_h3k27ac_chipseq/logs_hg19
mkdir -p $LOG_DIR

SH_SCRIPT=/scratch/PI/akundaje/annashch/gecco-variants/encode_pipeline/template_submission.sh


#for sample in `ls $RUN_ROOT`
#for sample in 589N 176T 175T 651T 755N 644T 703N 651N 697N 858N 
for sample in 175N 176N 235N 235T 260N 260T 389N 391N 402N 402T 492N 505N 620T 626N 644N 697T 703T 704N 747N 
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
	-t 2-0 \
	--cpus-per-task=4 \
	$SH_SCRIPT $sample.json
done

