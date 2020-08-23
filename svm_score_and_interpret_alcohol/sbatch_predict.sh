fasta_prefix=/oak/stanford/groups/akundaje/projects/GECCO/alcohol/fasta
model_prefix=/oak/stanford/groups/akundaje/projects/GECCO/alcohol/models
out_prefix_ref=/oak/stanford/groups/akundaje/projects/GECCO/alcohol/pred_ref
out_prefix_alt=/oak/stanford/groups/akundaje/projects/GECCO/alcohol/pred_alt
for cell_line in dnase_c dnase_v hct116 colo205 sw480
do    
    for split in `seq 0 9`
    do
	sbatch --mincpus 16  -J $cell_line.$split.ref -o logs_predict/$cell_line.$split.ref.o -e logs_predict/$cell_line.$split.ref.e -p akundaje,euan,owners,normal -t 1-0 predict.sh $fasta_prefix/alcohol.$split.ref.fa $model_prefix/model.$cell_line.$split.model.txt $out_prefix_ref/ref.pred.$split.$cell_line.txt
    done
    for split in `seq 0 9`
    do
	sbatch --mincpus 16  -J $cell_line.$split.alt -o logs_predict/$cell_line.$split.alt.o -e logs_predict/$cell_line.$split.alt.e -p akundaje,euan,owners,normal -t 1-0 predict.sh $fasta_prefix/alcohol.$split.alt.fa $model_prefix/model.$cell_line.$split.model.txt $out_prefix_alt/alt.pred.$split.$cell_line.txt
    done
done
