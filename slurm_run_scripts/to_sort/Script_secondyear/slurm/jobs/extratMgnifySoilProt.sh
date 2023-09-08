l=/lerins/hub/projects/25_20191015_Metag_PublicData/Mgnify/ftp/SOIL_ParsedData_RhizosphereAndRoot_set2/mgy_biomes.tsv_Plants_Rhizosphere_Root_id_Notdone
in=/lerins/hub/projects/25_20191015_Metag_PublicData/Mgnify/ftp/DataOri/
out=/lerins/hub/projects/25_20191015_Metag_PublicData/Mgnify/ftp/SOIL_ParsedData_RhizosphereAndRoot_set2/fasta
sbatch -p infinity --array=0-5  getseq.sh $l $in $out fa
