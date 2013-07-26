#!/usr/bin/env Rscript

require(ggplot2)
require(reshape2)

f="Laplacian_solver_time_SU"

tab = read.table(file=paste(f,".csv",sep=""), sep=",", header=TRUE)

p <- ggplot(tab, aes(x=as.factor(Cores), y=SU))
p <- p + geom_bar(position=position_dodge(),stat="identity", width=0.5)
p <- p + coord_cartesian(ylim=c(0.85,1.15))
p <- p + labs(x="Cores", y="SU D&C/Ref")
p <- p + geom_line(aes(x=as.factor(Cores), y=1, group=1, color="red"))
p <- p + theme_bw() + theme(legend.position="none")

pdf(paste(f,".pdf",sep=""), width=4, height=2.35)
print(p)
dev.off()
