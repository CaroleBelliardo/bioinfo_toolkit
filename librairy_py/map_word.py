%matplotlib inline
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.basemap import Basemap

### par methode

lat=geo_all.Latitude
long=geo_all.Longitude
col=geo_all.methode
colU=geo_all.methode.unique()
geo_all.complete_lineage=geo_all.complete_lineage.str.replace(';cellular organisms;Eukaryota;Opisthokonta;Fungi;Fungi incertae sedis;Mucoromycota;Glomeromycotina;Glomeromycetes;','')
colU

color = list(np.random.choice(range(256), size=3)) 
color=['darkblue','lime','darkred']
col_dico={colU[i]:color[i] for i in range(0,len(colU))}    
col_dico

colors=[col_dico[c] for c in col]

len(geo_all.seq_id.unique())

plt.figure(figsize=(14, 8))
earth = Basemap()
earth.bluemarble(alpha=0.42)
earth.drawcoastlines(color='#555566', linewidth=1)

plt.scatter(long, lat, 
            c=colors,alpha=0.5, zorder=10)

l1 = plt.scatter([],[], s=50, edgecolors='darkblue')
l2 = plt.scatter([],[], s=50, edgecolors='lime')
l3 = plt.scatter([],[], s=50, edgecolors='darkred')

labels = ["JGI", "Metabarcoding", "Euka_Imp"]

leg = plt.legend([l1, l2, l3], labels, ncol=3, frameon=True, fontsize=12,
handlelength=2, loc = 8, borderpad = 1.8,
handletextpad=1, title='25,457 DNA sequences; 125 locations', scatterpoints = 1)


plt.xlabel("All methods, AMFs Locations")
plt.savefig('allMpap_methodo.png', dpi=350)
