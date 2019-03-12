from os import listdir
from os.path import isfile, join
mypath="/users/nasa/lab/igr/gecco/"
onlyfiles = [f for f in listdir(mypath) if isfile(join(mypath, f))]
details=dict()
exclude=['Ctcf.8.400.10000.bed']  
tf_set=set([]) 
for f in onlyfiles: 
    print str(f) 
    if f in exclude: 
        continue 
    #EDIT: ONLY 7 MER 
    if f.__contains__('.8.400.'): 
        continue 
    if f.endswith('bed')==False: 
        continue 
    data=open(mypath+f,'r').read().split('\n') 
    while '' in data: 
        data.remove('') 
    tf='.'.join(f.split('.')[0:2]) 
    tf_set.add(tf) 
    for line in data: 
        tokens=line.split('\t') 
        entry=tuple(tokens[0:4])
        if entry not in details: 
            details[entry]=dict() 
        description=tokens[4].split(',') 
        logp=description[0].split('=')[1] 
        t=float(description[1].split('=')[1])
        baseline_ratio=float(description[32].split('=')[1])
        if t>0: 
            if baseline_ratio!=0: 
                baseline_ratio=1/baseline_ratio
        else: 
            baseline_ratio=baseline_ratio
        passed_logp=description[36].split('=')[1] 
        passed_nice=description[33].split('=')[1] 
        passed_ugly=description[34].split('=')[1] 
        passed_all=description[35].split('=')[1] 
        if passed_all=="TRUE": 
            passed_all=1
        else: 
            passed_all=0 
        if passed_ugly=="TRUE": 
            passed_ugly=1
        else: 
            passed_ugly=0 
        if passed_nice=="TRUE": 
            passed_nice=1
        else: 
            passed_nice=0 
        if passed_logp=="TRUE": 
            passed_logp=1
        else: 
            passed_logp=0 
        value=[baseline_ratio,logp,passed_all,passed_ugly,passed_nice,passed_logp]
        value=[str(i) for i in value] 
        details[entry][tf]=value 
print "built input dictionary!" 
#outf_full=open('IGR_PCA_format_details.tsv','w') 
#outf_condensed=open('IGR_PCA_condensed.tsv','w') 
outf_full=open('IGR_PCA_7mer_ugly_nice_format_details.tsv','w') 
outf_condensed=open('IGR_PCA_7mer_ugley_nice_condensed.tsv','w') 
tf_set=list(tf_set) 
outf_full.write('chrom\tstartpos\tendpos\trs')
outf_condensed.write('chrom\tstartpos\tendpos\trs')
for tf in tf_set: 
    outf_condensed.write('\t'+tf) 
    outf_full.write('\tBASELINE_RATIO_'+tf+'\tLOGP_'+tf+'\tPASSED_ALL_'+tf+'\tPASSED_UGLY_'+tf+'\tPASSED_NICE_'+tf+'\tPASSED_LOGP_'+tf)
outf_full.write('\n') 
outf_condensed.write('\n') 
for entry in details: 
    outf_full.write('\t'.join(entry)) 
    outf_condensed.write('\t'.join(entry)) 
    for tf in tf_set: 
        if tf in details[entry]: 
            outf_full.write('\t'+'\t'.join(details[entry][tf]))
            #if details[entry][tf][2]=='1': 
            if (details[entry][tf][3]=='1') and (details[entry][tf][4]=='1'): 
                outf_condensed.write('\t'+details[entry][tf][0])
            else: 
                outf_condensed.write('\tNA') 
        else: 
            outf_full.write('\tNA'*6)
            outf_condensed.write('\tNA') 
    outf_full.write('\n') 
    outf_condensed.write('\n') 

    
