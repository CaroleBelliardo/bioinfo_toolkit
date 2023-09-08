##-- Empty data
find . -size 0 -print 	## Show empty files
find . -size 0 -delete 	## Delete empty files

# Tab
awk 'BEGIN { FS = OFS = "\t" } { for(i=1; i<=NF; i++) if($i ~ /^ *$/) $i = 0 }; 1' $file # Replace missing values [space] with zero in tabular file
# Fasta
awk 'BEGIN {RS = ">" ; FS = "\n" ; ORS = ""} $2 {print ">"$0}' input.fas > output.fas ## Remove empty sequences in a fasta file

##-- Filtering
sed -i '1d' $file ## Delete the first line # 1: Number of lines to delete
sed -i '2d' $file ## Delete the second line .../// nth line
sed -i '/^$/d' $file ## Delete empty lines in file.txt
grep -Fvxf $linetodelete $file #-F, --fixed-strings (Interpret the PATTERN as a list of fixed strings);  -v: --invert-match; -x, --line-regexp (Select only those matches that exactly match the whole line); -f (Obtain PATTERN from FILE)

awk -F'\t' '$3~/^gene/' ${FILENAME} | awk -F'\t' '{print $1,$4,$5,$6,$7,$8,$9,$2,$3}' OFS='\t' > ${PREF}.gff_gene # Augustus parses genes to bed

##-- Sorting
sort -n -r -k'x,x' # Numeric sort but not with exponential, r = reverse, k = column x
sort -g # With exponential e 10^-n values
perl -e 'print sort { $a<=>$b } <>' # Sort with exponential value

##-- Count
# Fasta
cat $fastaFile | awk '$0 ~ ">" {print c; c=0;printf substr($0,2,100) "\t"; } $0 !~ ">" {c+=length($0);} END { print c; }' > $fileOutput # Give sequence length from fasta file; n values

seqtk comp $i  # Count number of nucleotides in fasta files; !! needs to install seqtk !!

# Tab
awk '{s+=$1} END {print s}' mydatafile # Sum all lines
grep -c $pattern * | cut -d':' -f 2 | awk '{s+=$1} END {print s}' # Sum all file counts

#-- Split file 
awk ' $0 {a++}{ b=int(a/1071)+1; print $0 > FILENAME"-split-"b}'  $file
awk ' $0~">" {a++}{ b=int(a/1071)+1; print $0 > FILENAME"-split-"b}' $fastaFile # Split fasta file

##-- Manage Col 
awk '{print $NF}' $file 	# Print only the last column
awk -F "_" '{print $(NF)}' 	# Print only the last column with "_" separator
awk 'NF{NF-=1};1' $file		# Remove last column
awk ' $3 >= 90 ' $file 		# Filter lines; lines with col3 value > 90
awk '!($2="")' $file 		# Remove column 2
awk -F'\t' '$[col]~/^[pattern]/' $file  ## Filter lines; looking for [pattern] in specific column [col]

##-- Manage Fasta
awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);}  END {printf("\n");}' < file.fa ; sed -i '1{/^$/d}' file.fa #  Convert multirow fasta to one line sequence

awk  '/^>/ {gsub(/.a.fa(sta)?$/,"",FILENAME);printf($0 "_" FILENAME "\n");next;} {print}' $f > renameHeader/$f # Add FILENAME [with 'a.fa' extension] in fasta header with "_" separator

sed -e '/^>/! s/[[:lower:]]/N/g' $file > $fileOutput # Convert lower case to N in fasta file

perl -ne 'if(/^>(\S+)/){$c=$i{$1}}$c?print:chomp;$i{$_}=1 if @ARGV' $listFile $fastaFile # Extract list of sequences from fasta

##-- Manage metag header
awk -F "_" '{print $(NF)}' $listId | sort -u | while read id ; do  grep $id $listId | sed 's/_'$id'//' > $repo/$id ; done # Split

##-- Align tools
# Run diamond
diamond blastp -d /bighub/hub/DB/diamond_ncbi_nr_2018_08/nr -q All_IMG-M_Gigaspora.faa-split-1 -o matches 

# Run PLAST
plast -p plastn -bargraph -e 1e-6 -a 16 -H 1 -Q 150 -i ../data/AllrenameHeader_data1.fa-split-2-split-1 -d /bank/blastdb/nt.nal -o plastn1.out

##-- Blast Parsing
sort -k1,1 -k12,12nr -k11,11n  $blastFile | sort -u -k1,1 --merge # Best hit of blast on evalue

awk 'NR==FNR {h[$1] = $2; next} {print $0,h[$2]}' ${prot.accession2taxid.txt} $blastFile > $outFile
# NR==FNR: Execute only on the first file, save in hash (or key) = 1st column [$1] and value = 2nd column [$2]
# Then, write the entire line from the 2nd file + match from the hash

awk 'NR==FNR {h[$1] = $2; next} {print $0,h[$4]}' ${prot.accession2taxid} $bedFile > $outFile


## Run bioinfo software 
##-- Mapping
# Bowtie2
bowtie2-build $genomefna $name
bowtie2 --threads 25 -x genomes_transcriptomes/fasta/index -U file.fq -S mapping/smalls/file.sam --no-unal

# Samtools
samtools view -bS eg2.sam > eg2.bam
samtools sort eg2.bam -o eg2.sorted.bam
samtools mpileup -uf $BT2_HOME/example/reference/lambda_virus.fa eg2.sorted.bam | bcftools view -Ov - > eg2.raw.bcf
bcftools view eg2.raw.bcf

##-- EukaTools
# Eukrep
EukRep -i $assembledfna -o $outFile

## krona 
ImportTaxomoy.pl -q 2 -t 3 YourKrakenOutputFile -o YourKronaReportFile # kraken to krona

