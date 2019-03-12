source=open('eigen_input.bed','r').read().split('\n') 
source.remove('') 
#found=open('eigen_pca_hits_allele_filtered/all_eigen_pca_hits.filtered.bed','r').read().split('\n') 
found=open('eigen_hits_allele_filtered/all_eigen_hits.filtered.bed','r').read().split('\n') 
found.remove('') 
found_dict=dict() 
for line in found: 
    entry=line.split('\t')[0:2] 
    found_dict[tuple(entry)]=1 
for line in source: 
    tokens=line.split('\t') 
    entry=tuple([tokens[0],tokens[2]])
    if entry not in found_dict: 
        print str(line) 
