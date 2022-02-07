#!/bin/bash
#combine across model folds
#for ancestry in EUR EAS
#do
#    for task in dnase_v dnase_c colo205 sw480 hct116
#    do
#	cat $ancestry.gkmexplain.$task.diabetes.3.alt.txt $ancestry.gkmexplain.$task.diabetes.9.alt.txt > $ancestry.gkmexplain.$task.diabetes.alt.txt
#	cat $ancestry.gkmexplain.$task.diabetes.3.ref.txt $ancestry.gkmexplain.$task.diabetes.9.ref.txt > $ancestry.gkmexplain.$task.diabetes.ref.txt
#    done
#done
#for f in gkmexplain.colo205.diabetes.3.alt.txt  gkmexplain.dnase_c.diabetes.3.alt.txt  gkmexplain.dnase_v.diabetes.3.alt.txt  gkmexplain.hct116.diabetes.3.alt.txt  gkmexplain.sw480.diabetes.3.alt.txt gkmexplain.colo205.diabetes.3.ref.txt  gkmexplain.dnase_c.diabetes.3.ref.txt  gkmexplain.dnase_v.diabetes.3.ref.txt  gkmexplain.hct116.diabetes.3.ref.txt  gkmexplain.sw480.diabetes.3.ref.txt gkmexplain.colo205.diabetes.9.alt.txt  gkmexplain.dnase_c.diabetes.9.alt.txt  gkmexplain.dnase_v.diabetes.9.alt.txt  gkmexplain.hct116.diabetes.9.alt.txt  gkmexplain.sw480.diabetes.9.alt.txt gkmexplain.colo205.diabetes.9.ref.txt  gkmexplain.dnase_c.diabetes.9.ref.txt  gkmexplain.dnase_v.diabetes.9.ref.txt  gkmexplain.hct116.diabetes.9.ref.txt  gkmexplain.sw480.diabetes.9.ref.txt
#do
#    rm $f
#done

ancestry=EUR
python make_plots.py --tasks healthy tumor sw480 hct116 colo205 \
       --ref_files $ancestry.gkmexplain.dnase_c.diabetes.ref.txt $ancestry.gkmexplain.dnase_v.diabetes.ref.txt $ancestry.gkmexplain.sw480.diabetes.ref.txt $ancestry.gkmexplain.hct116.diabetes.ref.txt $ancestry.gkmexplain.colo205.diabetes.ref.txt \
       --alt_files $ancestry.gkmexplain.dnase_c.diabetes.alt.txt $ancestry.gkmexplain.dnase_v.diabetes.alt.txt $ancestry.gkmexplain.sw480.diabetes.alt.txt $ancestry.gkmexplain.hct116.diabetes.alt.txt $ancestry.gkmexplain.colo205.diabetes.alt.txt \
       --ylim 0.08 \
       --ancestry $ancestry \
       --snps rs9526201 rs9534444 rs1142184 rs7983898 rs9316222 rs56058552 rs3802177 rs11558471 rs28529793 

ancestry=EAS
#python make_plots.py --tasks healthy tumor sw480 hct116 colo205 \
#       --ref_files $ancestry.gkmexplain.dnase_c.diabetes.ref.txt $ancestry.gkmexplain.dnase_v.diabetes.ref.txt $ancestry.gkmexplain.sw480.diabetes.ref.txt $ancestry.gkmexplain.hct116.diabetes.ref.txt $ancestry.gkmexplain.colo205.diabetes.ref.txt \
#       --alt_files $ancestry.gkmexplain.dnase_c.diabetes.alt.txt $ancestry.gkmexplain.dnase_v.diabetes.alt.txt $ancestry.gkmexplain.sw480.diabetes.alt.txt $ancestry.gkmexplain.hct116.diabetes.alt.txt $ancestry.gkmexplain.colo205.diabetes.alt.txt \
#       --ylim 0.05 \
       --ancestry $ancestry \
       --snps rs9526201 rs9316222 rs56058552 rs9526209 rs1408224 rs142306868 rs3802177 rs11558471



   
