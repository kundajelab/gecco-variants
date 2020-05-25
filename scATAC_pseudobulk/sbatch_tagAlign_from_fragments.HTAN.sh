out_dir=/oak/stanford/groups/akundaje/projects/GECCO/scATAC/HTAN/pseudobulk_tagAligns
for fname in `cat /home/groups/akundaje/annashch/gecco-variants/scATAC_pseudobulk/HTAN.frag.files.tsv`
do 
    base_fname=`basename $fname`
    echo $base_fname 
    sbatch -J $base_fname -o logs/$base_fname.o -e logs/$base_fname.e -p akundaje,euan,owners tagAlign_from_fragments.HTAN.sh $fname $out_dir/$base_fname.tagAlign
done
