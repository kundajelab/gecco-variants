cred_set_anno=open("annotations_with_screen.txt",'r').read().strip().split('\n')
positives=open("../mpra_validation/positive_candidates.tsv",'r').read().strip().split('\n')
outf=open("annotations_with_screen.txt.new",'w')
outf.write(cred_set_anno[0]+'\tPositiveCandidate\n')
pos_cand_dict=dict()
for line in positives[1::]:
    tokens=line.split('\t')
    pos_cand_dict[tokens[1]]=1
for line in cred_set_anno[1::]:
    tokens=line.split('\t')
    snp=tokens[2]
    if snp in pos_cand_dict:
        outf.write(line+'\t1\n')
    else:
        outf.write(line+'\t0\n')
        
