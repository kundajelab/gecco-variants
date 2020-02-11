mkdir perf.svm.svmtrainset.svmtestset.rbf
prefix=/srv/scratch/annashch/gecco/SVM/rbf_kernel_experiment/SVM_predictions_rbf
python score_svm.py \
       --predictions_on_pos_regions $prefix/predictions.C_merged.0.positives.gkm.rbf $prefix/predictions.C_merged.1.positives.gkm.rbf $prefix/predictions.C_merged.2.positives.gkm.rbf $prefix/predictions.C_merged.3.positives.gkm.rbf $prefix/predictions.C_merged.4.positives.gkm.rbf $prefix/predictions.C_merged.5.positives.gkm.rbf $prefix/predictions.C_merged.6.positives.gkm.rbf $prefix/predictions.C_merged.7.positives.gkm.rbf $prefix/predictions.C_merged.8.positives.gkm.rbf $prefix/predictions.C_merged.9.positives.gkm.rbf $prefix/predictions.colo205.0.positives.gkm.rbf $prefix/predictions.colo205.1.positives.gkm.rbf $prefix/predictions.colo205.2.positives.gkm.rbf $prefix/predictions.colo205.3.positives.gkm.rbf $prefix/predictions.colo205.4.positives.gkm.rbf $prefix/predictions.colo205.5.positives.gkm.rbf $prefix/predictions.colo205.6.positives.gkm.rbf $prefix/predictions.colo205.7.positives.gkm.rbf $prefix/predictions.colo205.8.positives.gkm.rbf $prefix/predictions.colo205.9.positives.gkm.rbf $prefix/predictions.hct116.0.positives.gkm.rbf $prefix/predictions.hct116.1.positives.gkm.rbf $prefix/predictions.hct116.2.positives.gkm.rbf $prefix/predictions.hct116.3.positives.gkm.rbf $prefix/predictions.hct116.4.positives.gkm.rbf $prefix/predictions.hct116.5.positives.gkm.rbf $prefix/predictions.hct116.6.positives.gkm.rbf $prefix/predictions.hct116.7.positives.gkm.rbf $prefix/predictions.hct116.8.positives.gkm.rbf $prefix/predictions.hct116.9.positives.gkm.rbf $prefix/predictions.sw480.0.positives.gkm.rbf $prefix/predictions.sw480.1.positives.gkm.rbf $prefix/predictions.sw480.2.positives.gkm.rbf $prefix/predictions.sw480.3.positives.gkm.rbf $prefix/predictions.sw480.4.positives.gkm.rbf $prefix/predictions.sw480.5.positives.gkm.rbf $prefix/predictions.sw480.6.positives.gkm.rbf $prefix/predictions.sw480.7.positives.gkm.rbf $prefix/predictions.sw480.8.positives.gkm.rbf $prefix/predictions.sw480.9.positives.gkm.rbf $prefix/predictions.V_merged.0.positives.gkm.rbf $prefix/predictions.V_merged.1.positives.gkm.rbf $prefix/predictions.V_merged.2.positives.gkm.rbf $prefix/predictions.V_merged.3.positives.gkm.rbf $prefix/predictions.V_merged.4.positives.gkm.rbf $prefix/predictions.V_merged.5.positives.gkm.rbf $prefix/predictions.V_merged.6.positives.gkm.rbf $prefix/predictions.V_merged.7.positives.gkm.rbf $prefix/predictions.V_merged.8.positives.gkm.rbf $prefix/predictions.V_merged.9.positives.gkm.rbf \
       --predictions_on_neg_regions $prefix/predictions.C_merged.0.negatives.gkm.rbf $prefix/predictions.C_merged.1.negatives.gkm.rbf $prefix/predictions.C_merged.2.negatives.gkm.rbf $prefix/predictions.C_merged.3.negatives.gkm.rbf $prefix/predictions.C_merged.4.negatives.gkm.rbf $prefix/predictions.C_merged.5.negatives.gkm.rbf $prefix/predictions.C_merged.6.negatives.gkm.rbf $prefix/predictions.C_merged.7.negatives.gkm.rbf $prefix/predictions.C_merged.8.negatives.gkm.rbf $prefix/predictions.C_merged.9.negatives.gkm.rbf $prefix/predictions.colo205.0.negatives.gkm.rbf $prefix/predictions.colo205.1.negatives.gkm.rbf $prefix/predictions.colo205.2.negatives.gkm.rbf $prefix/predictions.colo205.3.negatives.gkm.rbf $prefix/predictions.colo205.4.negatives.gkm.rbf $prefix/predictions.colo205.5.negatives.gkm.rbf $prefix/predictions.colo205.6.negatives.gkm.rbf $prefix/predictions.colo205.7.negatives.gkm.rbf $prefix/predictions.colo205.8.negatives.gkm.rbf $prefix/predictions.colo205.9.negatives.gkm.rbf $prefix/predictions.hct116.0.negatives.gkm.rbf $prefix/predictions.hct116.1.negatives.gkm.rbf $prefix/predictions.hct116.2.negatives.gkm.rbf $prefix/predictions.hct116.3.negatives.gkm.rbf $prefix/predictions.hct116.4.negatives.gkm.rbf $prefix/predictions.hct116.5.negatives.gkm.rbf $prefix/predictions.hct116.6.negatives.gkm.rbf $prefix/predictions.hct116.7.negatives.gkm.rbf $prefix/predictions.hct116.8.negatives.gkm.rbf $prefix/predictions.hct116.9.negatives.gkm.rbf $prefix/predictions.sw480.0.negatives.gkm.rbf $prefix/predictions.sw480.1.negatives.gkm.rbf $prefix/predictions.sw480.2.negatives.gkm.rbf $prefix/predictions.sw480.3.negatives.gkm.rbf $prefix/predictions.sw480.4.negatives.gkm.rbf $prefix/predictions.sw480.5.negatives.gkm.rbf $prefix/predictions.sw480.6.negatives.gkm.rbf $prefix/predictions.sw480.7.negatives.gkm.rbf $prefix/predictions.sw480.8.negatives.gkm.rbf $prefix/predictions.sw480.9.negatives.gkm.rbf $prefix/predictions.V_merged.0.negatives.gkm.rbf $prefix/predictions.V_merged.1.negatives.gkm.rbf $prefix/predictions.V_merged.2.negatives.gkm.rbf $prefix/predictions.V_merged.3.negatives.gkm.rbf $prefix/predictions.V_merged.4.negatives.gkm.rbf $prefix/predictions.V_merged.5.negatives.gkm.rbf $prefix/predictions.V_merged.6.negatives.gkm.rbf $prefix/predictions.V_merged.7.negatives.gkm.rbf $prefix/predictions.V_merged.8.negatives.gkm.rbf $prefix/predictions.V_merged.9.negatives.gkm.rbf \
       --outf perf.svm.svmtrainset.svmtestset.rbf

