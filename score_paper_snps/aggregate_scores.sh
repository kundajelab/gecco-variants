python aggregate_scores.py --preds_ref_files pred.colo205.calcium.1.ref.txt pred.dnase_c.calcium.1.ref.txt pred.dnase_v.calcium.1.ref.txt pred.hct116.calcium.1.ref.txt pred.sw480.calcium.1.ref.txt \
       --preds_alt_files pred.colo205.calcium.1.alt.txt pred.dnase_c.calcium.1.alt.txt pred.dnase_v.calcium.1.alt.txt pred.hct116.calcium.1.alt.txt pred.sw480.calcium.1.alt.txt \
       --preds_ref_names colo205.ref dnase_c.ref dnase_v.ref hct116.ref sw480.ref \
       --preds_alt_names colo205.alt dnase_c.alt dnase_v.alt hct116.alt sw480.alt \
       --outf calcium.preds.summary.txt

python aggregate_scores.py --preds_ref_files pred.colo205.diabetes.3.ref.txt pred.dnase_c.diabetes.3.ref.txt pred.dnase_v.diabetes.3.ref.txt pred.hct116.diabetes.3.ref.txt pred.sw480.diabetes.3.ref.txt  \
       --preds_alt_files pred.colo205.diabetes.3.alt.txt pred.dnase_c.diabetes.3.alt.txt pred.dnase_v.diabetes.3.alt.txt pred.hct116.diabetes.3.alt.txt pred.sw480.diabetes.3.alt.txt \
       --preds_ref_names colo205.ref dnase_c.ref dnase_v.ref hct116.ref sw480.ref \
       --preds_alt_names colo205.alt dnase_c.alt dnase_v.alt hct116.alt sw480.alt \
       --outf diabetes.preds.summary.3.txt


python aggregate_scores.py --preds_ref_files pred.colo205.diabetes.9.ref.txt pred.dnase_c.diabetes.9.ref.txt pred.dnase_v.diabetes.9.ref.txt pred.hct116.diabetes.9.ref.txt pred.sw480.diabetes.9.ref.txt  \
       --preds_alt_files pred.colo205.diabetes.9.alt.txt pred.dnase_c.diabetes.9.alt.txt pred.dnase_v.diabetes.9.alt.txt pred.hct116.diabetes.9.alt.txt pred.sw480.diabetes.9.alt.txt \
       --preds_ref_names colo205.ref dnase_c.ref dnase_v.ref hct116.ref sw480.ref \
       --preds_alt_names colo205.alt dnase_c.alt dnase_v.alt hct116.alt sw480.alt \
       --outf diabetes.preds.summary.9.txt

