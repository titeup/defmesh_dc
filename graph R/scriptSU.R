#!/usr/bin/env Rscript

require(ggplot2)
require(reshape2)

f="Laplacian_solver_time_SU"

tab = read.table(file=paste(f,".csv",sep=""), sep=",", header=TRUE)
#tab.m <- melt(tab, id.vars="Cores")
print (tab)
#p <- ggplot(tab.m, aes(x=as.factor(Cores), y=value))
#p <- p + scale_y_continuous(breaks=seq(0,1.25,0.125),limit=c(0.875,1.125))
#p <- p + labs(x="Cores", y="SU D&C/Ref")
#p <- p + geom_bar(position=position_dodge(), stat="identity")

p <- ggplot(tab, aes(x=as.factor(Cores), y=SU))
p <- p + coord_cartesian(ylim=c(0.75,1.25))
p <- p + geom_bar(width=.5)
p <- p + labs(x="Cores", y="SU D&C/Ref")
p <- p + theme_bw()
pdf(paste(f,".pdf",sep=""), width=5, height=2.5)

print(p)

dev.off()
