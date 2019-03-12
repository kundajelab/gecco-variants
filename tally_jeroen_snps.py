data=open("allele_counts_500_subjects.bed").read().strip().split('\n')
thresholds=[0.5,0.4,0.3,0.2,0.1, 0.09, 0.08, 0.07, 0.06, 0.05, 0.04, 0.03, 0.02, 0.01, 0.009, 0.008, 0.007, 0.006, 0.005, 0.004, 0.003, 0.002, 0.0011]
tally_dict=dict()
for thresh in thresholds:
    tally_dict[thresh]=0
for line in data:
    maf=float(line.split('\t')[-1])
    for thresh in thresholds:
        if maf < thresh:
            tally_dict[thresh]+=1

outf=open('jeroen_maf_summary.txt','w')
for thresh in thresholds:
    outf.write(str(thresh)+'\t'+str(tally_dict[thresh])+'\n')
    
