#!/bin/bash
#combine across model folds 
#for task in dnase_v dnase_c colo205 sw480 hct116
#do
#    cat gkmexplain.$task.diabetes.3.alt.txt gkmexplain.$task.diabetes.9.alt.txt > gkmexplain.$task.diabetes.alt.txt
#    cat gkmexplain.$task.diabetes.3.ref.txt gkmexplain.$task.diabetes.9.ref.txt > gkmexplain.$task.diabetes.ref.txt
#done
#for f in gkmexplain.colo205.diabetes.3.alt.txt  gkmexplain.dnase_c.diabetes.3.alt.txt  gkmexplain.dnase_v.diabetes.3.alt.txt  gkmexplain.hct116.diabetes.3.alt.txt  gkmexplain.sw480.diabetes.3.alt.txt gkmexplain.colo205.diabetes.3.ref.txt  gkmexplain.dnase_c.diabetes.3.ref.txt  gkmexplain.dnase_v.diabetes.3.ref.txt  gkmexplain.hct116.diabetes.3.ref.txt  gkmexplain.sw480.diabetes.3.ref.txt gkmexplain.colo205.diabetes.9.alt.txt  gkmexplain.dnase_c.diabetes.9.alt.txt  gkmexplain.dnase_v.diabetes.9.alt.txt  gkmexplain.hct116.diabetes.9.alt.txt  gkmexplain.sw480.diabetes.9.alt.txt gkmexplain.colo205.diabetes.9.ref.txt  gkmexplain.dnase_c.diabetes.9.ref.txt  gkmexplain.dnase_v.diabetes.9.ref.txt  gkmexplain.hct116.diabetes.9.ref.txt  gkmexplain.sw480.diabetes.9.ref.txt
#do
#    rm $f
#done


python make_plots.py --tasks healthy tumor sw480 hct116 colo205 \
       --ref_files gkmexplain.dnase_c.calcium.hits.ref.txt gkmexplain.dnase_v.calcium.hits.ref.txt gkmexplain.sw480.calcium.hits.ref.txt gkmexplain.hct116.calcium.hits.ref.txt gkmexplain.colo205.calcium.hits.ref.txt \
       --alt_files gkmexplain.dnase_c.calcium.hits.alt.txt gkmexplain.dnase_v.calcium.hits.alt.txt gkmexplain.sw480.calcium.hits.alt.txt gkmexplain.hct116.calcium.hits.alt.txt gkmexplain.colo205.calcium.hits.alt.txt \
       --ylim 0.2

