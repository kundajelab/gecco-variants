for task in dnase_v #dnase_c dnase_v sw480 hct116 colo205
do
    for fold in `seq 0 9`
    do
	python pad_na.py $task $fold & 
    done
done
