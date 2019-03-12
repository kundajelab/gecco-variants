for i in `seq 21 22`
do
    tabix /mnt/lab_data/montgomery/shared/Eigen/EIGEN/Eigen_hg19_0916_chr$i.tab.bgz -B chr$i.bed > eigen_hits/chr$i.eigen.bed
    echo $i
done 
