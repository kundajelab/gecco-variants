for cell_line in dnase_c dnase_v hct116 colo205 sw480
do    
    for split in `seq 0 9`
    do
	for group in `seq 0 4`
	do
	    sbatch -J $cell_line.$split.$group -o logs/$cell_line.$split.$group.o -e logs/$cell_line.$split.$group.e -p akundaje,euan -t 7-0 explain.sh $split $cell_line $group
	done
    done
done
