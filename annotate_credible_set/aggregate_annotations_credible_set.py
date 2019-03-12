credible_set_data=open("99percent_cred_set.bed",'r').read().strip().split('\n')
credible_set_dict=dict()
for line in credible_set_data:
    tokens=line.split('\t')
    snp_name=tokens[3]
    credible_set_dict[snp_name]=line
print("made credible set dictionary")

dnase_data=open("dnase.intersections",'r').read().strip().split('\n')
dnase_dict=dict()
for line in dnase_data:
    tokens=line.split('\t')
    snp_name=tokens[3]
    dnase_dict[snp_name]=1
print("made dnase dictionary")


ctcf_data=open("9.state.high.CTCF",'r').read().strip().split('\n')
ctcf_dict=dict()
for line in ctcf_data:
    tokens=line.split('\t')
    snp_name=tokens[3]
    ctcf_dict[snp_name]=1
print("made ctcf dictionary")


H3K4me3_data=open("9.state.high.H3K4me3",'r').read().strip().split('\n')
H3K4me3_dict=dict()
for line in H3K4me3_data:
    tokens=line.split('\t')
    snp_name=tokens[3]
    H3K4me3_dict[snp_name]=1
print("made H3K4me3 dictionary")

H3K27ac_data=open("9.state.high.H3K27ac",'r').read().strip().split('\n')
H3K27ac_dict=dict()
for line in H3K27ac_data:
    tokens=line.split('\t')
    snp_name=tokens[3]
    H3K27ac_dict[snp_name]=1
print("made H3K27ac dictionary")

g5_data=open("5group",'r').read().strip().split('\n')
g5_dict=dict()
for line in g5_data:
    tokens=line.split('\t')
    snp_name=tokens[3]
    g5_dict[snp_name]=1
print("made g5 dictionary")


wald_data=open("99percent_cred_set.snp.annotations",'r').read().strip().split('\n')
wald_dict=dict()
for line in wald_data:
    tokens=line.split('\t')
    snp_name=tokens[0]
    wald_dict[snp_name]=line
print("made wald dict")

gc_data=open("gc.percent.200bp.bed",'r').read().strip().split('\n')
gc_dict=dict()
for line in gc_data:
    tokens=line.split('\t')
    snp_name=tokens[3]
    gc_dict[snp_name]='\t'.join([tokens[i] for i in [-5,-4,-3,-2,-1]])
print("made gc dict")

dist_data=open("closest.bed",'r').read().strip().split('\n')
dist_dict=dict()
for line in dist_data:
    tokens=line.split('\t')
    snp_name=tokens[3]
    closest_gene=tokens[-3]
    dist_to_closest=tokens[-1]
    dist_dict[snp_name]=closest_gene+'\t'+dist_to_closest
print("made distance to TSS dict")

outf=open("annotation.txt",'w')
outf.write("variant\tr2\tbeta\tse\tdirection\tZ\tr\tABF\tposterior_prob\tcumsum_posterior_prob\tin_99pct_credible_set\tDNAse\t5group\tH3K27ac\tH3K4me3\tCTCF\tMarkerName\tAllele1\tAllele2\tFreq1\tFreqSE\tMinFreq\tMaxFreq\tEffect\tStdErr\tP-value\tDirection\tPosition\tNearestGene\tDistToTSS\tA%\tC%\tG%\tT%\tGC%\n")

for snp in credible_set_dict:
    outf.write(credible_set_dict[snp])
    outf.write('\t')
    outf.write(str(snp in dnase_dict))
    outf.write('\t')
    outf.write(str(snp in g5_dict))
    outf.write('\t')
    outf.write(str(snp in H3K27ac_dict))
    outf.write('\t')
    outf.write(str(snp in H3K4me3_dict))
    outf.write('\t')
    outf.write(str(snp in ctcf_dict))
    outf.write('\t')
    outf.write(wald_dict[snp])
    outf.write('\t')
    outf.write(dist_dict[snp])
    outf.write('\t')
    outf.write(gc_dict[snp])
    outf.write('\n')
