#!/bin/bash
for i in 15 18 22 31 32 44 66 71 72 76 104 155 #`seq 0 157`
do
    python get_seqs.py --variant_bed gecco.variants.in.overlap.peaks$i --out_prefix $i
    echo $i 
done
