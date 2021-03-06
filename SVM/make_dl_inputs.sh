for split in `seq 0 9`
#test
#do
#    python make_dl_inputs.py --tasks dnase_c dnase_v sw480 hct116 colo205 \
#	   --positives svm.inputs.bed/svm.inputs.C_merged.test.$split.positives.bed svm.inputs.bed/svm.inputs.V_merged.test.$split.positives.bed svm.inputs.bed/svm.inputs.sw480.test.$split.positives.bed svm.inputs.bed/svm.inputs.hct116.test.$split.positives.bed svm.inputs.bed/svm.inputs.colo205.test.$split.positives.bed \
#	   --negatives svm.inputs.bed/svm.inputs.C_merged.test.$split.negatives.bed svm.inputs.bed/svm.inputs.V_merged.test.$split.negatives.bed svm.inputs.bed/svm.inputs.sw480.test.$split.negatives.bed svm.inputs.bed/svm.inputs.hct116.test.$split.negatives.bed svm.inputs.bed/svm.inputs.colo205.test.$split.negatives.bed \
#	   --store_gc \
#	   --out_prefix $split.test
#done
#train
do
    python make_dl_inputs.py --tasks dnase_c dnase_v sw480 hct116 colo205 \
	   --positives svm.inputs.bed/svm.inputs.C_merged.train.$split.positives.bed svm.inputs.bed/svm.inputs.V_merged.train.$split.positives.bed svm.inputs.bed/svm.inputs.sw480.train.$split.positives.bed svm.inputs.bed/svm.inputs.hct116.train.$split.positives.bed svm.inputs.bed/svm.inputs.colo205.train.$split.positives.bed \
	   --negatives svm.inputs.bed/svm.inputs.C_merged.train.$split.negatives.bed svm.inputs.bed/svm.inputs.V_merged.train.$split.negatives.bed svm.inputs.bed/svm.inputs.sw480.train.$split.negatives.bed svm.inputs.bed/svm.inputs.hct116.train.$split.negatives.bed svm.inputs.bed/svm.inputs.colo205.train.$split.negatives.bed \
	   --store_gc \
	   --out_prefix $split.train
done
