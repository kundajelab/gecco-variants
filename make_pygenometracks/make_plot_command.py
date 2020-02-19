desired_region_size=5000
flank=2500
outf=open("make_plot.sh",'w')
data=open('toplot.txt','r').read().strip().split('\n')
for line in data:
    tokens=line.split('\t')
    chrom=tokens[0]
    start=int(tokens[1])
    start=start-flank
    end=start+desired_region_size
    rsid=tokens[-1]
    outf.write(' '.join(["pyGenomeTracks","--tracks","tracks.ini","--region",chrom+":"+str(start)+'-'+str(end),"--outFileName","/srv/scratch/annashch/gecco/plots/"+rsid+"/"+rsid+'.pdf'])+'\n')
outf.close()
