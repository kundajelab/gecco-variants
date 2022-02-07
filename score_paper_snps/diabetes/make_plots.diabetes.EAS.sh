#!/bin/bash
ancestry=EAS
for snp in rs9526201 rs9316222 rs56058552 rs9526209 rs1408224 rs142306868 rs3802177 rs11558471
do
    python make_plots.py --tasks healthy tumor sw480 hct116 colo205 \
	   --ref_files $ancestry.gkmexplain.dnase_c.diabetes.ref.txt $ancestry.gkmexplain.dnase_v.diabetes.ref.txt $ancestry.gkmexplain.sw480.diabetes.ref.txt $ancestry.gkmexplain.hct116.diabetes.ref.txt $ancestry.gkmexplain.colo205.diabetes.ref.txt \
	   --alt_files $ancestry.gkmexplain.dnase_c.diabetes.alt.txt $ancestry.gkmexplain.dnase_v.diabetes.alt.txt $ancestry.gkmexplain.sw480.diabetes.alt.txt $ancestry.gkmexplain.hct116.diabetes.alt.txt $ancestry.gkmexplain.colo205.diabetes.alt.txt \
	   --ylim 0.07 \
	   --ancestry $ancestry \
	   --snps $snp &
done



   
