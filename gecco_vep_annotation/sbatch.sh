for i in `seq 0 237`
do
    sbatch -J "vep$i" -o logs/$i.vep.o -e logs/$i.vep.e -p euan,owners runs.sh $i
done

