#!/usr/bin/env Rscript

require(ggplot2)
require(reshape2)

f="Elasticity_asm_efficiency"

tab = read.table(file=paste(f,".csv",sep=""), sep=",", header=TRUE)
tab.m <- melt(tab, id.vars="Cores")

p <- ggplot(tab.m, aes(x=as.factor(Cores), y=value))
p <- p + geom_line(aes(group=variable, color=variable), size=1)
p <- p + scale_colour_manual(values=c("black","#99CCFF","#338888","#005555"),name="",
							 labels=c("Ideal Scaling","Ref", "D&C", "Coloring"))
p <- p + scale_x_discrete(breaks=c(1,2,4,6,8,12))
p <- p + labs(x="Cores", y="Efficiency")
p <- p + theme_bw() + theme(legend.key = element_blank())

pdf(paste(f,".pdf",sep=""), width=5, height=2.45)
print(p)
dev.off()
