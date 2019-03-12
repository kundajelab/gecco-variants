for i in `seq 1 22`
do
    tabix /mnt/lab_data/montgomery/shared/Eigen/EIGEN-PC/Eigen-PC_hg19_0916_chr$i.tab.bgz -B chr$i.bed > eigen_pca_hits/chr$i.eigen.pca.bed & 
    echo $i
done

