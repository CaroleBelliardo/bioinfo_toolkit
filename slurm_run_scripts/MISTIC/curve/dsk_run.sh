while read l; do sbatch dsk.sh $l $(echo $l| sed -E 's/(\.fastq|\.fasta)/\.h5/')  $(echo $l| sed -E 's/(\.fastq|\.fasta)/\.txt/') ;done < /kwak/hub/25_cbelliardo/MISTIC/Salade_I/3_curve/list_dsk.txt2
