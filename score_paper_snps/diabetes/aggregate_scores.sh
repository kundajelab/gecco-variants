for ancestry in EUR EAS
do
    python aggregate_scores.py --preds_ref_files $ancestry.pred.colo205.diabetes.3.ref.txt $ancestry.pred.dnase_c.diabetes.3.ref.txt $ancestry.pred.dnase_v.diabetes.3.ref.txt $ancestry.pred.hct116.diabetes.3.ref.txt $ancestry.pred.sw480.diabetes.3.ref.txt  \
	   --preds_alt_files $ancestry.pred.colo205.diabetes.3.alt.txt $ancestry.pred.dnase_c.diabetes.3.alt.txt $ancestry.pred.dnase_v.diabetes.3.alt.txt $ancestry.pred.hct116.diabetes.3.alt.txt $ancestry.pred.sw480.diabetes.3.alt.txt \
	   --preds_ref_names colo205.ref dnase_c.ref dnase_v.ref hct116.ref sw480.ref \
	   --preds_alt_names colo205.alt dnase_c.alt dnase_v.alt hct116.alt sw480.alt \
	   --outf $ancestry.diabetes.preds.summary.3.txt

    python aggregate_scores.py --preds_ref_files $ancestry.pred.colo205.diabetes.9.ref.txt $ancestry.pred.dnase_c.diabetes.9.ref.txt $ancestry.pred.dnase_v.diabetes.9.ref.txt $ancestry.pred.hct116.diabetes.9.ref.txt $ancestry.pred.sw480.diabetes.9.ref.txt  \
	   --preds_alt_files $ancestry.pred.colo205.diabetes.9.alt.txt $ancestry.pred.dnase_c.diabetes.9.alt.txt $ancestry.pred.dnase_v.diabetes.9.alt.txt $ancestry.pred.hct116.diabetes.9.alt.txt $ancestry.pred.sw480.diabetes.9.alt.txt \
	   --preds_ref_names colo205.ref dnase_c.ref dnase_v.ref hct116.ref sw480.ref \
	   --preds_alt_names colo205.alt dnase_c.alt dnase_v.alt hct116.alt sw480.alt \
	   --outf $ancestry.diabetes.preds.summary.9.txt

done
