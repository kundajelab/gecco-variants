#!/bin/bash
for task in dnase_c dnase_v sw480 hct116 colo205
do
    python add_lead_snp_info.py --input_tsv gkmexplain/score_summary_and_significance/$task.gkmexplain.aggregate.txt --outf gkmexplain/score_summary_and_significance/$task.gkmexplain.aggregate.withleads.txt
done
