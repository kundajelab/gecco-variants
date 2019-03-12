labeled=open("combined.allchroms.bed","r").read().split('\n')
while '' in labeled: 
    labeled.remove('') 
original=open("gecco_gwas_pval_sorted_n500000_pruned_rsq_0.8_expanded_rsq_0.8.bed","r").read().split('\n') 
while '' in original: 
    original.remove('') 
scored=open("gecco_gwas_pval_sorted_n500000.bed","r").read().split('\n') 
while '' in scored: 
    scored.remove('') 
outf=open('basset_input.bed','w') 

#score rs_id --> score 
rs_to_score=dict() 
for line in scored: 
    tokens=line.split('\t') 
    rs_field=tokens[3]
    if rs_field=="NA": 
        rs_field=tokens[0]+':'+tokens[1]+'-'+tokens[2] 
    rs_to_score[rs_field]=tokens[4] 

#print "built score dict" 
allele_dict=dict() 
for line in labeled: 
    tokens=line.split('\t') 
    entry=tokens[0]+"-"+tokens[1] 
    ref_allele=tokens[4] 
    all_alleles=tokens[5].split('/') 
    if ref_allele in all_alleles: 
        all_alleles.remove(ref_allele)
    alt_allele=all_alleles[0] 
    allele_dict[entry]=[ref_allele,alt_allele] 
#print "made label dict" 
for line in original: 
    tokens=line.split('\t') 
    entry=tokens[0]+'-'+tokens[1] 
    rsid=tokens[3] 
    if entry in allele_dict: 
        alleles=allele_dict[entry]
    else: 
        #print line
        #continue 
        alleles=['N','N'] 
    score =rs_to_score[rsid] 
    outf.write(tokens[0]+'\t'+tokens[2]+'\t'+tokens[3]+'\t'+alleles[0]+'\t'+alleles[1]+'\t'+tokens[3]+'\t'+score+'\n')

