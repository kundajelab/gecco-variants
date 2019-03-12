#concatenates feature vectors from CADD, DeepSEA score + cell-specific ratios for DNAse+Basset+Eigen+IGR 
source=open('../crc/input.uniquers.bed','r').read().split('\n') 
cadd=open('../cadd/GECCO_SNP_CADD_ANNOTATED.tsv','r').read().split('\n') 
deepsea_fs=open('../deepsea/deepsea.infile.vcf.out.funsig.FILTERED','r').read().split('\n') 
deepsea_fold=open('../deepsea/logfold.filtered','r').read().split('\n') 
basset=open('../../Basset/tutorials/sad_CRC/sad_table.tabified.txt','r').read().split('\n') 
basset_caco2=open('../../Basset/tutorials/sad_CRC/sad_table.tabified.caco2.txt','r').read().split('\n') 
eigen=open('../eigen_select/eigen_hits_allele_filtered/all_eigen_hits.filtered.bed','r').read().split('\n') 
eigen_pca=open('../eigen_select/eigen_pca_hits_allele_filtered/all_eigen_pca_hits.filtered.bed','r').read().split('\n') 
#igr=open('../gecco_igr/igr.formatted.bed','r').read().split('\n') 
igr=open('../gecco_igr/IGR_PCA_coord_1_2.txt','r').read().split('\n') 

########################################

while '' in source: 
    source.remove('') 
while '' in cadd: 
    cadd.remove('') 
while '' in deepsea_fs: 
    deepsea_fs.remove('')
while '' in deepsea_fold: 
    deepsea_fold.remove('') 
while '' in basset: 
    basset.remove('') 
while '' in basset_caco2:
    basset_caco2.remove('') 
while '' in eigen: 
    eigen.remove('') 
while '' in eigen_pca: 
    eigen_pca.remove('') 
while '' in igr: 
    igr.remove('') 

#######################################
source_dict=dict() 
cadd_dict=dict() 
deepsea_fs_dict=dict() 
deepsea_fold_dict=dict() 
basset_dict=dict() 
basset_caco2_dict=dict() 
eigen_dict=dict() 
eigen_pca_dict=dict() 
igr_dict=dict()
rsid_to_pos=dict()  
header_full=['rs','ref','alt','group','cadd','deepsea_fs'] 
header_small=['rs','ref','alt','group','cadd','deepsea_fs'] 
for line in source: 
    tokens=line.split('\t')[0:6] 
    entry=tuple(tokens[0:2])
    value=tokens[2::] 
    source_dict[entry]=value 
    rsid=tokens[2] 
    rsid_to_pos[rsid]=entry 
print "built source dict!" 
for line in cadd: 
    tokens=line.split('\t') 
    entry=tuple([tokens[1],tokens[2]])
    value=[tokens[5]] 
    cadd_dict[entry]=value 
print "built cadd dict!" 

for line in deepsea_fs[1::]:#skip header line  
    tokens=line.split(',') 
    #print str(tokens) 
    entry=tuple([tokens[1],tokens[2]])
    value=[tokens[-1]] 
    deepsea_fs_dict[entry]=value 
print "built deepsea fs dict" 
deepsea_header=deepsea_fold[0].split('\t')[5::] 
deepsea_header=['ds_'+i for i in deepsea_header] 
header_full=header_full+deepsea_header 
for line in deepsea_fold[1::]: #skip header line 
    tokens=line.split('\t') 
    entry=tuple([tokens[0],tokens[1]])
    value=tokens[5::] 
    deepsea_fold_dict[entry]=value 
print "built deepsea fold dict" 
basset_header=[] 
used=dict() 
for line in basset[1::]: #ASSUMES BASSET OUTPUT FILE IS SORTED!!! 
    tokens=line.split('\t') 
    rsid=tokens[0] 
    celltype=tokens[5] 
    if celltype not in used: 
        basset_header.append(celltype) 
        used[celltype]=1 
    entry=rsid_to_pos[rsid] 
    value=tokens[-1] 
    if entry not in basset_dict: 
        basset_dict[entry]=[value] 
    else: 
        basset_dict[entry].append(value) 
print "built basset dict" 
for line in basset_caco2[1::]: 
    tokens=line.split('\t') 
    rsid=tokens[0] 
    entry=rsid_to_pos[rsid] 
    value=tokens[-1] 
    if entry not in basset_caco2_dict: 
        basset_caco2_dict[entry]=[value] 
    else: 
        basset_caco2_dict[entry].append(value) 
print "build basset caco2 dict" 
header_full=header_full+basset_header 
header_small=header_small+['basset_caco_2'] 
for line in eigen: 
    tokens=line.split('\t') 
    tokens[0]='chr'+tokens[0] 
    entry=tuple(tokens[0:2]) 
    value=[tokens[-1]] 
    eigen_dict[entry]=value 
print "built eign dict" 
for line in eigen_pca: 
    tokens=line.split('\t')
    tokens[0]='chr'+tokens[0] 
    entry=tuple(tokens[0:2]) 
    value=[tokens[-1]] 
    eigen_pca_dict[entry]=value 
print "built eigen PCA dict" 

for line in igr[1::]: 
    tokens=line.split('\t') 
    entry=tuple([tokens[0],tokens[1]])
    value=[tokens[2],tokens[3]] 
    igr_dict[entry]=value 
print "built igr dict" 
header_full.append('eigen') 
header_full.append('eigen_pca') 
header_full.append('igr_pc1') 
header_full.append('igr_pc2') 

header_small.append('eigen') 
header_small.append('eigen_pca') 
header_small.append('igr_pc1') 
header_small.append('igr_pc2') 
    
    
######################################
outf=open('pca.input.tsv','w') 
outf.write('\t'.join(header_full)+'\n')
outf_small=open('pca.small.input.tsv','w') 
outf_small.write('\t'.join(header_small)+'\n') 
skipped=0 
for entry in source_dict: 
    entry_string=""
    entry_small_string="" 
    entry_string=entry_string+'\t'.join(source_dict[entry])
    entry_small_string=entry_small_string+'\t'.join(source_dict[entry])
    if entry in cadd_dict: 
        entry_string=entry_string+'\t'+'\t'.join(cadd_dict[entry])
        entry_small_string=entry_small_string+'\t'+'\t'.join(cadd_dict[entry])        
    else: 
        skipped+=1 
        continue 
    if entry in deepsea_fs_dict: 
        entry_string=entry_string+'\t'+'\t'.join(deepsea_fs_dict[entry])
        entry_small_string=entry_small_string+'\t'+'\t'.join(deepsea_fs_dict[entry])
    else: 
        skipped+=1 
        continue 
    if entry in deepsea_fold_dict: 
        entry_string=entry_string+'\t'+'\t'.join(deepsea_fold_dict[entry])
    else: 
        skipped+=1 
        continue 
    if entry in basset_dict: 
        entry_string=entry_string+'\t'+'\t'.join(basset_dict[entry])
    else: 
        skipped+=1 
        continue 
    if entry in basset_caco2_dict: 
        entry_small_string=entry_small_string+'\t'+'\t'.join(basset_caco2_dict[entry])
    else: 
        skipped+=1 
        continue 
    if entry in eigen_dict: 
        entry_string=entry_string+'\t'+'\t'.join(eigen_dict[entry]) 
        entry_small_string=entry_small_string+'\t'+'\t'.join(eigen_dict[entry]) 
    else: 
        skipped+=1 
        continue 
    if entry in eigen_pca_dict: 
        entry_string=entry_string+'\t'+'\t'.join(eigen_pca_dict[entry]) 
        entry_small_string=entry_small_string+'\t'+'\t'.join(eigen_pca_dict[entry]) 
    else: 
        skipped+=1 
        continue 
    if entry in igr_dict: 
        entry_string=entry_string+'\t'+'\t'.join(igr_dict[entry])
        entry_small_string=entry_small_string+'\t'+'\t'.join(igr_dict[entry])
    else: 
        skipped+=1 
        continue 
    outf.write(entry_string+'\n') 
    outf_small.write(entry_small_string+'\n') 
print str(skipped) 
