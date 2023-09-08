df=read.csv('/work/cbelliardo/4-seuil_cut-Metag/CAT_all-zero.txt' , stringsAsFactors=F, sep='\t')
names(d)<-c('contig', 'len', 'nb_gene')

s=summary (df)
write.table(s, file='/work/cbelliardo/4-seuil_cut-Metag/OUT_DISTRIB/R_analyses/sum_CAT_all.txt', row.names=FALSE, quote=FALSE, col.names=FALSE, sep='\t')

o_1000pb_or_1g=d[which( d$len >= 1000 | d$nb_gene >= 1),]
o_1000pb_or_2g=d[which( d$len >= 1000 | d$nb_gene >= 2),]
o_1000pb_or_3g=d[which( d$len >= 1000 | d$nb_gene >= 3),]

write.table(o_1000pb_or_1g, file='/work/cbelliardo/4-seuil_cut-Metag/crossing_len-gff_R/o_1000pb_or_1g', row.names=FALSE, quote=FALSE, col.names=FALSE, sep='\t')
write.table(o_1000pb_or_2g, file='/work/cbelliardo/4-seuil_cut-Metag/crossing_len-gff_R/o_1000pb_or_2g', row.names=FALSE, quote=FALSE, col.names=FALSE, sep='\t')
write.table(o_1000pb_or_3g, file='/work/cbelliardo/4-seuil_cut-Metag/crossing_len-gff_R/o_1000pb_or_3g', row.names=FALSE, quote=FALSE, col.names=FALSE, sep='\t')
rm(o_1000pb_or_1g)
rm(o_1000pb_or_2g)
rm(o_1000pb_or_3g)
sink("/work/cbelliardo/4-seuil_cut-Metag/crossing_len-gff_R/o_1000pb_or_1g-3")
summary(o_1000pb_or_1g)
summary(o_1000pb_or_2g)
summary(o_1000pb_or_3g)
sink()

o_750pb_or_1g=d[which( d$len >= 750 | d$nb_gene >= 1),]
o_750pb_or_2g=d[which( d$len >= 750 | d$nb_gene >= 2),]
o_750pb_or_3g=d[which( d$len >= 750 | d$nb_gene >= 3),]

write.table(o_750pb_or_1g, file='/work/cbelliardo/4-seuil_cut-Metag/crossing_len-gff_R/o_750pb_or_1g', row.names=FALSE, quote=FALSE, col.names=FALSE, sep='\t')
write.table(o_750pb_or_2g, file='/work/cbelliardo/4-seuil_cut-Metag/crossing_len-gff_R/o_750pb_or_2g', row.names=FALSE, quote=FALSE, col.names=FALSE, sep='\t')
write.table(o_750pb_or_3g, file='/work/cbelliardo/4-seuil_cut-Metag/crossing_len-gff_R/o_750pb_or_3g', row.names=FALSE, quote=FALSE, col.names=FALSE, sep='\t')
rm(o_750pb_or_1g)
rm(o_750pb_or_2g) 
rm(o_750pb_or_3g) 
sink("/work/cbelliardo/4-seuil_cut-Metag/crossing_len-gff_R/o_750pb_or_1g-3")
summary(o_750pb_or_1g)
summary(o_750pb_or_2g)
summary(o_750pb_or_3g)
sink()



sink("/work/cbelliardo/4-seuil_cut-Metag/crossing_len-gff_R/o_500pb_or_1g-3")
o_500pb_or_1g=d[which( d$len >= 500 | d$nb_gene >= 1),]
write.table(o_500pb_or_1g, file='/work/cbelliardo/4-seuil_cut-Metag/crossing_len-gff_R/o_500pb_or_1g', row.names=FALSE, quote=FALSE, col.names=FALSE, sep='\t')
summary(o_500pb_or_1g)
rm(o_500pb_or_1g)

o_500pb_or_2g=d[which( d$len >= 500 | d$nb_gene >= 2),]
write.table(o_500pb_or_2g, file='/work/cbelliardo/4-seuil_cut-Metag/crossing_len-gff_R/o_500pb_or_2g', row.names=FALSE, quote=FALSE, col.names=FALSE, sep='\t')
summary(o_500pb_or_2g)
rm(o_500pb_or_2g)


o_500pb_or_3g=d[which( d$len >= 500 | d$nb_gene >= 3),]
write.table(o_500pb_or_3g, file='/work/cbelliardo/4-seuil_cut-Metag/crossing_len-gff_R/o_500pb_or_3g', row.names=FALSE, quote=FALSE, col.names=FALSE, sep='\t')
summary(o_500pb_or_3g)
rm(o_500pb_or_3g)
sink()



#svg(filename="boxplot_len.svg",
 #   width=5, 
  #  height=4, 
   # pointsize=12)

#boxplot(df$V2)
#dev.off()

#svg(filename="hist_len.svg",
 #   width=5,
  #  height=4, 
   # pointsize=12)

#hist(df$V2)
#dev.off()

