prefix="/srv/scratch/annashch/gecco/colorectal_cancer_gwas_hits_for_anna/credible_sets"
for f in $prefix/*
do
    cat $f >> cred_set_all.tsv 
done
