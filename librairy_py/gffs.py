from Bio import SeqIO
import pathlib  # test file


def gfftobed(l):  # conversion en fichier bed
    gffP, BedP, aaP, gffF = l  # ex . : ['test/GFF_krakenEuka-contigs/', 'test/BED_krakenEuka-contigs/', 'test/AA_krakenEuka-contigs/', 'Mammalia.gff']
    filename = gffF.strip('.gff')  # ex: Mammalia
    GffIN = gffP + gffF
    BedOUT = BedP + filename + '.bed'
    str1 = " awk -F'\t' '$3~/^gene/' " + GffIN + " | awk -F'\t' '{print $1,$4,$5,$6,$7,$8,$9,$2,$3}' OFS='\t' > " + BedOUT
    content = os.popen(str1).read()


def gfftofasta(l):  # extraction seq prot
    gffP, BedP, aaP, gffF = l
    filename = gffF.strip('.gff')
    GffIN = gffP + gffF
    FaaOUT = gffP + filename + '.aa'
    FaaOUTmv = aaP + filename + '.aa'
    str1 = "perl " + wd + "/getAnnoFasta.pl " + GffIN
    content = os.popen(str1).read()
    if pathlib.Path(FaaOUT).exists():
        str2 = " mv " + FaaOUT + " " + FaaOUTmv
        content = os.popen(str2).read()
    else:
        print("  -" + FaaOUT + ' doesnt existe!!')


def gffParse2(
        liste):  # fastaRepo,dico_contigTaxon,fastaOutRepo      #metagL,ContigK_fasta,taxon,Kraken_taxon,contigs
    # Gff,Bed, Aa=liste
    listeOfgff = os.listdir(liste[0])
    jobL = []
    for f in listeOfgff:
        t_list = liste + [f]
        jobL.append(t_list)
    parrallelize(gfftobed, jobL)
    parrallelize(gfftofasta, jobL)


# parse diamond
def addLineage(f):
    str1 = "sh ./modules/addL.sh" + f
    content = os.popen(str1).read()

