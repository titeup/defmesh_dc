#!/usr/bin/env Rscript

require(ggplot2)
require(reshape2)

f="Elasticity_asm_L3TCM"

tab = read.table(file=paste(f,".csv",sep=""), sep=",", header=TRUE)
tab$Version=reorder(tab$Version,tab$L3TCM)
tab$L3TCM=as.double(tab$L3TCM/(10**6))

p <- ggplot(tab, aes(x=as.factor(Version), y=L3TCM))
p <- p + geom_bar(position=position_dodge(),stat="identity", width=0.5)
p <- p + labs(x="", y="L3 Cache Misses (Mega)")
p <- p + theme_bw() + theme(axis.text.x=element_text(angle=45,vjust=1,hjust=1))
p <- p + geom_line(aes(x=as.factor(Version), y=15.1, group=1, color="red"))
p <- p + theme(legend.position="none")

pdf(paste(f,".pdf",sep=""), width=4, height=3)
print(p)
dev.off()
