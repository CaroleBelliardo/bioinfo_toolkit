import pyfasta
from modules import gestError

def extract_seq_F2F(fastaIn, ContigList, fastaOut):
    fasta_sequences = SeqIO.parse(open(fastaIn), 'fasta')  # open fasta
    for seq in fasta_sequences:
        if seq.id in ContigList:  # if sequence is in list of contig of this taxon for this metag
            SeqIO.write([seq], fastaOut, "fasta")  # print sequence in the file



def extractSeq(t_list):
    fastaFile, dico_contigTaxon, fastaRepo, fastaOutRepo, outputfna = t_list
    fasta_sequences = SeqIO.parse(open(fastaRepo + '/' + fastaFile), 'fasta')  # open fasta
    for seq in fasta_sequences:
        for i in dico_contigTaxon.values():
            if seq.id in i:
                modell = list(dico_contigTaxon.keys())[list(dico_contigTaxon.values()).index(i)]
                dp_tx = outputfna.deeper_taxon[modell]
                p = outputfna.fnaPath.loc[outputfna.deeper_taxon == dp_tx]
                # print(list(dico_contigTaxon.keys())[list(dico_contigTaxon.values()).index(seq.id)])
                pp = p.values[0].strip() + '/' + fastaFile + '.fna'
                output_handle = open(pp, "a")
                SeqIO.write([seq], output_handle, "fasta")  # print sequence in the file
                output_handle.close()



def extractSeqRun(fastaRepo, dico_contigTaxon, fastaOutRepo,
                  outPaths):  # metagL,ContigK_fasta,taxon,Kraken_taxon,contigs
    print('*******************************')
    gestError.file_exist(fastaRepo)
    fastaFiles = os.listdir(fastaRepo)
    jobL = []
    for fastaFile in fastaFiles:
        print(fastaFile)
        t_list = [fastaFile, dico_contigTaxon, fastaRepo, fastaOutRepo, outPaths]
        jobL.append(t_list)
    parrallelize(extractSeq, jobL)


