#for task in dnase_c dnase_v colo205 sw480 hct116
for task in dnase_c dnase_v
do
    for fold in 0 1 2 3 4 5 8 9
    do
	python get_auprc.py $task $fold  >> /srv/scratch/annashch/5_cell_lines_bias_correction/svm/perf.svm.svmtrainset.genometestset/perf.txt
    done
done
