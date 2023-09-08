#!/bin/bash

f=$1
db_lineage=/bighub/hub/DB/ncbi_taxo/al_taxonomy_lineage_root.txt
awk '{ FS = OFS = "\t" } NR==FNR {h[$1] = $2 ; next} {print $0,h[$2]}' $db_lineage $f > $f.lineage

