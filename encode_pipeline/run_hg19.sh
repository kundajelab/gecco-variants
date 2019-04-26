#!/bin/bash
RUN_ROOT=/oak/stanford/groups/akundaje/projects/GECCO/scacheri_46_h3k27ac_chipseq/output_hg19
LOG_DIR=$RUN_ROOT/logs
mkdir -p $LOG_DIR

SH_SCRIPT=/scratch/PI/akundaje/annashch/gecco-variants/encode_pipeline/template_submission.sh


for sample in `ls $RUN_ROOT`
do
    echo $sample
    cd $RUN_ROOT/$sample
    sbatch --partition akundaje,owners,euan,normal \
	--mem=35G \
	-o $LOG_DIR/$sample.o \
	-e $LOG_DIR/$sample.e  \
	-n 1 \
	--ntasks-per-node=1 \
	--job-name=$sample \
	--time=24:00:00 \
	--cpus-per-task=4 \
	$SH_SCRIPT $PJECT_ROOT/$sample/$sample.json
done
