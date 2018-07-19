#select 2 matched negatives for each positive 
matched_negatives=open("matched_negative_candidates",'r').read().strip().split('\n') 
snp_dict=dict() 
outf=open("matched_negatives_2perpos.tsv",'w')
outf.write(matched_negatives[0]+'\n')
for line in matched_negatives[1::]: 
    tokens=line.split('\t') 
    snp_name=tokens[0] 
    if snp_name not in snp_dict: 
        snp_dict[snp_name]=[line]
    else: 
        snp_dict[snp_name].append(line) 
for snp_name in snp_dict: 
    value=snp_dict[snp_name][0:min(3,len(snp_dict[snp_name]))]
    for entry in value: 
        outf.write(entry+'\n') 

