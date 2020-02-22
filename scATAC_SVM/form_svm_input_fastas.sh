task=$1
ref=$2
python form_svm_input_fastas.py --outf $task/svm.inputs.$task.test.0 $task/svm.inputs.$task.test.1 $task/svm.inputs.$task.test.2 $task/svm.inputs.$task.test.3 $task/svm.inputs.$task.test.4 $task/svm.inputs.$task.test.5 $task/svm.inputs.$task.test.6 $task/svm.inputs.$task.test.7 $task/svm.inputs.$task.test.8 $task/svm.inputs.$task.test.9 $task/svm.inputs.$task.train.0 $task/svm.inputs.$task.train.1 $task/svm.inputs.$task.train.2 $task/svm.inputs.$task.train.3 $task/svm.inputs.$task.train.4 $task/svm.inputs.$task.train.5 $task/svm.inputs.$task.train.6 $task/svm.inputs.$task.train.7 $task/svm.inputs.$task.train.8 $task/svm.inputs.$task.train.9 \
       --neg_pickle $task/$task.candidate.negatives.gc.p \
       --overwrite_outf \
       --ref_fasta $ref \
       --peaks $task/svm.peaks.$task.test.0.gc.seq $task/svm.peaks.$task.test.1.gc.seq $task/svm.peaks.$task.test.2.gc.seq $task/svm.peaks.$task.test.3.gc.seq $task/svm.peaks.$task.test.4.gc.seq $task/svm.peaks.$task.test.5.gc.seq $task/svm.peaks.$task.test.6.gc.seq $task/svm.peaks.$task.test.7.gc.seq $task/svm.peaks.$task.test.8.gc.seq $task/svm.peaks.$task.test.9.gc.seq $task/svm.peaks.$task.train.0.gc.seq $task/svm.peaks.$task.train.1.gc.seq $task/svm.peaks.$task.train.2.gc.seq $task/svm.peaks.$task.train.3.gc.seq $task/svm.peaks.$task.train.4.gc.seq $task/svm.peaks.$task.train.5.gc.seq $task/svm.peaks.$task.train.6.gc.seq $task/svm.peaks.$task.train.7.gc.seq $task/svm.peaks.$task.train.8.gc.seq $task/svm.peaks.$task.train.9.gc.seq
