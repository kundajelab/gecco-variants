for cell_line in dnase_c dnase_v hct116 colo205 sw480
do    
    for split in `seq 0 9`
    do
	sbatch -J $cell_line.$split.ref -o logs_explain/$cell_line.$split.ref.o -e logs_explain/$cell_line.$split.ref.e -p akundaje,euan explain.sh $split $cell_line ref
	sbatch -J $cell_line.$split.alt -o logs_explain/$cell_line.$split.alt.o -e logs_explain/$cell_line.$split.alt.e -p akundaje,euan explain.sh $split $cell_line alt
    done
done
