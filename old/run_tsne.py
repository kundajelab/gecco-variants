import matplotlib
matplotlib.use('Agg')
import numpy as np 
from sklearn.manifold import TSNE 
import pylab as Plot
import sys 

if __name__ == "__main__":
        inputf=sys.argv[1] 
        inputl=sys.argv[2] 
	X = np.loadtxt(inputf);
	labels = np.loadtxt(inputl);
	model=TSNE(n_components=2,random_state=0) 
        np.set_printoptions(suppress=True) 
        Y=model.fit_transform(X)
	Plot.scatter(Y[:,0], Y[:,1], 20, labels);
        Plot.savefig("tSNE.pdf",bbox_inches='tight')
        Math.savetxt('tSNE.out.txt',Y)
