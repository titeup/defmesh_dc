#!/usr/bin/env Rscript

require(ggplot2)
require(reshape2)

f="Laplacian_solver_time_SU"

tab = read.table(file=paste(f,".csv",sep=""), sep=",", header=TRUE)

p <- ggplot(tab, aes(x=as.factor(Cores), y=SU))
p <- p + geom_bar(position=position_dodge(),stat="identity", width=0.5)
p <- p + coord_cartesian(ylim=c(0.85,1.15))
p <- p + labs(x="Cores", y="SU D&C/Ref")
p <- p + theme_bw()

pdf(paste(f,".pdf",sep=""), width=5, height=3)
print(p)
dev.off()
