#!/usr/bin/env python
# coding: utf-8

# # Mycophyto formated
# ## Import data

# In[1]:


import pandas as pd
import os  


# ### vars

# In[48]:


metabarcoding_file= '/lerins/hub/projects/25_20191015_Mycophyto_AMF/raw/Table_ori/metabarcoding/paste_hmmer_pv2e50_mbntcma'
metadata_file='/lerins/hub/projects/25_20191015_Mycophyto_AMF/JGI_metadata_200817_lat11_long12.xls'


# ### Imports files into dataframe

# In[49]:


metadata_pd=pd.read_table(metadata_file, sep='\t', header=0)
metabarcoding_pd=pd.read_table(metabarcoding_file, sep='\t', names=['taxon_oid','seq_id','combinedName','protacc','idPercent','len','mismatch','gapopen','qstart','qend','sstart','send','evalue','bitscore taxid','complet_lineage','complete_taxid'])


# # Analyse metabarcoding

# In[50]:


len(metabarcoding_pd.taxon_oid.unique())


# In[51]:


metadata_file_hmm=metadata_pd[ metadata_pd.taxon_oid.isin(metabarcoding_pd.taxon_oid) ]


# ## plot map

# In[52]:


import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.basemap import Basemap


# In[53]:


lat=metadata_file_hmm.Latitude
long=metadata_file_hmm.Longitude
col=metabarcoding_pd.complet_lineage
metabarcoding_pd_geo.complet_lineage[1]


# In[56]:


metabarcoding_pd_geo= pd.merge(metabarcoding_pd, metadata_pd,on='taxon_oid')
metabarcoding_pd_geo.complet_lineage=metabarcoding_pd_geo.complet_lineage.str.replace(';cellular organisms;Eukaryota;Opisthokonta;Fungi;Fungi incertae sedis;Mucoromycota;Glomeromycotina;Glomeromycetes;','')
metabarcoding_pd_geo[['Latitude','Longitude','Species','complet_lineage','idPercent','len']]
metabarcoding_pd_geo.len.describe()


# In[55]:


lat=metabarcoding_pd_geo.Latitude
long=metabarcoding_pd_geo.Longitude
col=metabarcoding_pd_geo.complet_lineage.unique()
col


# In[182]:


color = list(np.random.choice(range(256), size=23))
col_dico={}
for i in range(0,len(col)) : 
    col_dico[col[i]]=color[i]

handle_dict=[col_dico[l] for l in  metabarcoding_pd_geo.complet_lineage]


# In[191]:


plt.figure(figsize=(14, 8))
earth = Basemap()

earth.bluemarble(alpha=0.42)
earth.drawcoastlines(color='#555566', linewidth=1)

plt.scatter(long, lat, 
            c=handle_dict,alpha=0.5, zorder=10)

plt.xlabel("Metabarcoding results 126AMFs 23spots")
plt.savefig('metabarcoding_126cma_78spot.png', dpi=350)


# In[117]:


metabarcoding_pd_geo= pd.merge(metabarcoding_pd, metadata_pd,on='taxon_oid')
metabarcoding_pd_geo.complet_lineage=metabarcoding_pd_geo.complet_lineage.str.replace(';cellular organisms;Eukaryota;Opisthokonta;Fungi;Fungi incertae sedis;Mucoromycota;','')


# In[230]:


metabarcoding_pd_geo[['Latitude','Longitude','Species','complet_lineage','idPercent','len','taxon_oid']]
by_loc=metabarcoding_pd_geo.groupby("Latitude")["complet_lineage"]


# In[279]:


species_list=[]
for state, frame in by_loc:
    l=frame
    ll=[i.split(';')[-2] for i in l ]
    species_list.append(set(ll))


# In[217]:


statistics.mean([len(i) for i in species_list])


# In[ ]:


species_list
## test compo


# In[245]:


by_loc=metabarcoding_pd_geo.groupby("Latitude")
by_loc.groups.keys()
metabarcoding_pd_geo.groupby('Latitude')['complet_lineage'].count()


# In[262]:


metabarcoding_pd_geo.to_csv(r'mycophyto_res/hmm_coord.csv', index = False)


# ## compo

# In[58]:


l=[(i.split(';')[-3])for i in metabarcoding_pd_geo.complet_lineage]

d={x:l.count(x) for x in sorted(set(l))}
d.keys()


# In[59]:


t=metabarcoding_pd_geo.groupby('complet_lineage')['complet_lineage'].count()


# In[60]:


plt.pie(d.values(), labels=d.keys(),  textprops={'fontsize': 3},
autopct='%1.1f%%', shadow=False, startangle=140)

plt.axis('equal')
plt.savefig('pie_hmm_genus.png', dpi=350)


# In[345]:


l=[(i.split(';')[-4])for i in metabarcoding_pd_geo.complet_lineage]

d={x:l.count(x) for x in sorted(set(l))}
d.keys()
t=metabarcoding_pd_geo.groupby('complet_lineage')['complet_lineage'].count()
plt.pie(d.values(), labels=d.keys(),  textprops={'fontsize': 3},
autopct='%1.1f%%', shadow=False, startangle=140)

plt.axis('equal')
plt.savefig('pie_hmm_family.png', dpi=350)


# # JGI data

# In[5]:


JGI_file= '/lerins/hub/projects/25_20191015_Mycophyto_AMF/raw/2_jigData_metagID.txt'


# In[6]:


## a modifier
# AJOUTER METAG ID
metadata_pd=pd.read_table(metadata_file, sep='\t', header=0)
JGI_pd=pd.read_table(JGI_file, sep='\t', names=['taxon_oid','seq_id','combinedName', 'idPercent','len','mismatch','gapopen','qstart','qend','sstart','send','evalue','bitscore taxid','complet_lineage','complete_taxid'])
JGI_pd.describe()


# ### stat dmd

# In[8]:


import seaborn as sns
sns.set_theme(style="ticks", palette="pastel")
# Load the example tips dataset
tips = sns.load_dataset("tips")


# In[9]:


# Draw a nested boxplot to show bills by day and time
sns.boxplot(JGI_pd.idPercent)

#sns.despine(offset=10, trim=True)


# ## 

# In[10]:


metadata_file_jgi=metadata_pd[ metadata_pd.taxon_oid.isin(JGI_pd.taxon_oid) ]
len(metadata_file_jgi.Longitude.unique())
t=metadata_file_jgi['Latitude'].astype(str) + metadata_file_jgi['Longitude'].astype(str)
t


# In[23]:


JGI_pd_geo= pd.merge(JGI_pd, metadata_file_jgi,on='taxon_oid')
JGI_pd_geo.complet_lineage=JGI_pd_geo.complet_lineage.str.replace(';cellular organisms;Eukaryota;Opisthokonta;Fungi;Fungi incertae sedis;Mucoromycota;Glomeromycotina;Glomeromycetes;','')
JGI_pd_geo[['Latitude','Longitude','Species','complet_lineage','idPercent','len']]


# In[25]:


lat=metadata_file_jgi.Latitude
long=metadata_file_jgi.Longitude
col=JGI_pd.complet_lineage


# In[26]:


lat=JGI_pd_geo.Latitude
long=JGI_pd_geo.Longitude
col=JGI_pd_geo.complet_lineage.unique()


# In[27]:


import numpy as np
color = list(np.random.choice(range(256), size=23))
col_dico={}
for i in range(0,len(col)) : 
    col_dico[col[i]]=color[i]

handle_dict=[col_dico[l] for l in  JGI_pd_geo.complet_lineage]


# In[32]:


plt.figure(figsize=(14, 8))
earth = Basemap()

earth.bluemarble(alpha=0.42)
earth.drawcoastlines(color='#555566', linewidth=1)

plt.scatter(long, lat, 
            c=handle_dict,alpha=0.5, zorder=10)
plt.xlabel("jgi results 23spots")
plt.savefig('jgi.png', dpi=350)


# In[29]:





# In[33]:


JGI_pd= pd.merge(JGI_pd, metadata_pd,on='taxon_oid')
JGI_pd.complet_lineage=JGI_pd_geo.complet_lineage.str.replace(';cellular organisms;Eukaryota;Opisthokonta;Fungi;Fungi incertae sedis;Mucoromycota;','')


# In[35]:


JGI_pd_geo[['Latitude','Longitude','Species','complet_lineage','idPercent','len','taxon_oid']]
by_loc=JGI_pd_geo.groupby("Latitude")["complet_lineage"]
by_loc


# In[37]:


import statistics
species_list=[]
for state, frame in by_loc:
    l=frame
    ll=[i.split(';')[-2] for i in l ]
    species_list.append(set(ll))


statistics.mean([len(i) for i in species_list])


# In[39]:


by_loc=JGI_pd_geo.groupby("Latitude")
by_loc.groups.keys()
JGI_pd_geo.groupby('Latitude')['complet_lineage'].count()


# In[40]:


JGI_pd_geo.to_csv(r'mycophyto_res/jgi_coord.csv', index = False)


# In[42]:


l=[(i.split(';')[-3])for i in JGI_pd_geo.complet_lineage]

d={x:l.count(x) for x in sorted(set(l))}
d.keys()

t=JGI_pd_geo.groupby('complet_lineage')['complet_lineage'].count()


# In[44]:


plt.pie(d.values(), labels=d.keys(),  textprops={'fontsize': 3},
autopct='%1.1f%%', shadow=False, startangle=140)

plt.axis('equal')
plt.savefig('pie_jgi_genus.png', dpi=350)


# In[46]:


l=[(i.split(';')[-4])for i in JGI_pd_geo.complet_lineage]

d={x:l.count(x) for x in sorted(set(l))}
d.keys()
t=JGI_pd_geo.groupby('complet_lineage')['complet_lineage'].count()
plt.pie(d.values(), labels=d.keys(),  textprops={'fontsize': 3},
autopct='%1.1f%%', shadow=False, startangle=140)

plt.axis('equal')
plt.savefig('pie_jgi_family.png', dpi=350)


# In[47]:


len(metabarcoding_pd.taxon_oid.unique())


# # Euka

# In[62]:


euka= '/lerins/hub/projects/25_20191015_Mycophyto_AMF/raw/Table_ori/euka_outdmd-Glomerom_50euk.txt'


# In[ ]:




